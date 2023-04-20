import User from "../model/User";
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import multiparty from 'multiparty';
import multer from "multer";
import { OAuth2Client } from "google-auth-library";
export const getAllUser = async(req, res, next) => {
    let users;

    try {
        users = await User.find();
    } catch(err) {
        console.log(err);
    }
    if(!users){
        return res.status(404).json({message: "No users found"});
    }
    return res.status(202).json({ users });
};

export const checkEmail = async(req, res, next) => {
    let email = req.query.email;
    let existingUser;
    let exists = false;
    try {
        existingUser = await User.findOne({email});
    } catch(err) {
        console.log(err);
    }
    if(existingUser){
        exists = true;
    }
    return res.status(200).json(exists);
};

export const fetchUser = async(req,res,next) => {
    let user;
    const userId = req.params.id;
    try {
        user = await User.findById(userId);
    } catch(err) {
        return console.log(err);
    }
    if(!user){
        return res.status(404).json({message: "No user found."});
    }
    return res.status(200).json(user);
};

export const signUp = async(req, res, next) => {
    let { email, password, name, dob, about, mobile, fromGoogle } = req.body;
    
    console.log(req.body)
    //Sign Up if not from Google
    if(fromGoogle == false){
        email = email.toLowerCase();
        let existingUser;
        try {
            existingUser= await User.findOne({email});
        }catch(err){
            return console.log(err);
        }
        if (existingUser){
            return res.status(400).json({message: "User already exists"});
        }
        const hashedPassword = bcrypt.hashSync(password);
        const user = User({
            name,
            email,
            password:  hashedPassword,
            dob,
            about,
            mobile,
            isAgent: false
        });
        try{
            await user.save();
        } catch(err){
            return console.log(err);
        }
        const token = jwt.sign({id: user.id}, "SECRET");
        user.token = token;
        if(token){
            return res.status(200).json({token: token, user: user});
        }
        return res.status(400).json({message: "Authentication error."});
    }
    

};


export const signUpImg = async(req, res, next) => {
    try {
        let { email, password, name, dob, about, mobile, fromGoogle } = JSON.parse(req.body.json);
        console.log(req.file);
        email = email.toLowerCase();
        let existingUser;
        try {
            existingUser= await User.findOne({email});
        }catch(err){
            return console.log(err);
        }
        if (existingUser){
            return res.status(400).json({message: "User already exists"});
        }
        const hashedPassword = bcrypt.hashSync(password);
        const user = User({
            name,
            email,
            password:  hashedPassword,
            dob,
            about,
            image: req.file.location,
            mobile,
            isAgent: false
        });
        console.log(user);
        return res.status(400).json({message: "Authentication error."});
        try{
            await user.save();
        } catch(err){
            return console.log(err);
        }
        const token = jwt.sign({id: user.id}, "SECRET");
        user.token = token;
        if(token){
            return res.status(200).json({token: token, user: user});
        }
        return res.status(400).json({message: "Authentication error."});
    }catch (ex) {
        throw ex;
    }
    return res.status(400).json({message: "Authentication error."});
    
    

};


// export const signUp2 = async(req, res, next) => {
//     let { email, password } = req.body;
//     email = email.toLowerCase();
//     let existingUser;
//     try {
//         existingUser= await User.findOne({email});
//     }catch(err){
//         return console.log(err);
//     }
//     if (existingUser){
//         return res.status(400).json({message: "User already exists"});
//     }
//     const hashedPassword = bcrypt.hashSync(password);
//     const user = User({
//         email,
//         password:  hashedPassword,
//         signedUp: false,
//         isAgent: false,
//         listings: []
//     });
//     try{
//         await user.save();
//         return res.status(200).json({user});
//     } catch(err){
//         return console.log(err);
//     }
// };

export const login = async(req,res,next) => {
    
    let {email, password} = req.body;
    email = email.toLowerCase();
    let user;
    try {
        user= await User.findOne({email});
    }catch(err){
        return console.log(err);
    }
    if (!user){
        return res.status(404).json({message: "Account does not exist."});
    }
    //If test account
    if (user.test == true){
        const token = jwt.sign({id: user.id}, "SECRET");
        user.token = token;
        if(token){
            return res.status(200).json({token: token, user: user});
        }
    }

    let validatePass;
    if(user.password){
        validatePass = bcrypt.compareSync(password, user.password)
    }
    else{
        return res.status(404).json({message: "Please sign in with Google."});
    }
    
    if (!validatePass) {
        return res.status(404).json({message: "Password is incorrect. Please try again."});
    }
    
    const token = jwt.sign({id: user.id}, "SECRET");
    user.token = token;
    if(token){
        
        return res.status(200).json({token: token, user: user});
    }
    return res.status(400).json({message: "Authentication error."});
    
};

export const googleLogin = async(req,res,next) => {
    const {idToken} = req.body;
    const client = new OAuth2Client("800583686389-suib9d2bnodrjajsrviea1v7eocv5u59.apps.googleusercontent.com");
    let ticket;
    try {ticket = await client.verifyIdToken({
        idToken: idToken,
        requiredAudience: "800583686389-vhl3f2dft53g6id3fjfis8rupt77cjmr.apps.googleusercontent.com",  // Specify the CLIENT_ID of the app that accesses the backend
    });
    } catch(err) {
        console.log(err)
    }
    const payload = ticket.getPayload();
    const userid = payload['sub'];
    const email = payload['email'];
    const name = payload['name'];
    const image = payload['picture'];
    console.log(email);
    let newAccount = false;
    let user;
    try {
        user= await User.findOne({email});
    }catch(err){
        return console.log(err);
    }
    if (!user){
        newAccount = true;
        console.log("No user exists")
        user = User({
            email,
            signedUp: false,
            name,
            isAgent: false,
            image,
            listings: []
        });
        try{
            await user.save();
        } catch(err){
            return console.log(err);
        }
    }
    
    const token = jwt.sign({id: user.id}, "SECRET");
    user.token = token;
    if(token){
        return res.status(200).json({token: token, user: user, newAccount: newAccount});
    }
    return res.status(400).json({message: "Authentication error."});
    

};

export const updateProfile = async(req,res,next)=>{
    const{name, about, dob,image, mobile} = req.body;
    var data = {};
    if(req.body.mobile != null){
        data['mobile']= req.body.mobile;
    }
    if(req.body.name != null){
        data['name']= req.body.name;
    }
    if(req.body.about != null){
        data['about']= req.body.about;
    }
    let updateData = { $set: data };
    const userId = req.params.id;
    let user;
    try{
        user = await User.findByIdAndUpdate(userId, updateData, {new:true});
    } catch(err){
        console.log(err);
    }
    if (!user){
        return res.status(500).json({message: "Unable to update profile."});
    }
    return res.status(200).json({user});
};