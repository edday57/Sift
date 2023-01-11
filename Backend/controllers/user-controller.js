import User from "../model/User";
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'
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

export const signUp = async(req, res, next) => {
    let { email, password } = req.body;
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
        email,
        password:  hashedPassword,
        signedUp: false,
        posts: []
    });
    try{
        await user.save();
        return res.status(200).json({user});
    } catch(err){
        return console.log(err);
    }
};

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
    const valiatePass = bcrypt.compareSync(password, user.password)
    if (!valiatePass) {
        return res.status(404).json({message: "Password is incorrect. Please try again."});
    }
    const token = jwt.sign({id: user.id}, "SECRET");
    user.token = token;
    if(token){
        return res.status(200).json({token: token, user: user});
    }
    return res.status(400).json({message: "Authentication error."});
    
};

export const completeSignUp = async(req,res,next)=>{
    const{name, about, dob,image} = req.body;
    const userId = req.params.id;
    let user;
    try{
        user = await User.findByIdAndUpdate(userId, {
            name,
            about,
            dob,
            image,
            signedUp:true
        });
    } catch(err){
        console.log(err);
    }
    if (!user){
        return res.status(500).json({message: "Unable to complete signup."});
    }
    return res.status(200).json({user});
};