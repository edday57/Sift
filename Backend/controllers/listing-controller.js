import { json, response } from "express";
import Listing from "../model/Listing"
import User from "../model/User";
import Like from "../model/Like";
import mongoose from "mongoose";
import jwt from 'jsonwebtoken'
import { spawn } from 'child_process';
export const getAllListings = async(req, res, next) => {
    let {filters} =req.body;
    console.log(filters);
    let listings;
    console.log(req.query.skip)
    let skip = Number(req.query.skip)
    let limit = 10;
    var match = {};
    //Filters
    //Price
    if (filters.minPrice != 100 || filters.maxPrice != 20000) {
        match.price = { $gte: filters.minPrice, $lte: filters.maxPrice };
    }
    
    //Size
    if (filters.minSize != 100 || filters.maxSize != 5000) {
        match.sizesqft = { $gte: filters.minSize, $lte: filters.maxSize };
    }
    //Bedrooms
    if (filters.minBeds != -1) {
        if (filters.maxBeds != 4){
            //match.push()
            match.bedrooms = { $gte: filters.minBeds, $lte: filters.maxBeds };
        }
        else {
            match.bedrooms = { $gte: filters.minBeds};
        }
    }

    //Bathrooms
    if (filters.minBaths != -1) {
        if (filters.maxBaths != 4){
            match.bathrooms = { $gte: filters.minBaths, $lte: filters.maxBaths };
        }
        else {
            match.bathrooms = { $gte: filters.minBaths};
        }
    }
    
    try {
        
        listings = await Listing.aggregate([
            { $match: match },
            { $sort: { "date_added": -1 }},
            //To implement sort and skip
            { $skip: skip },
            { $limit: limit },
        ]);
    } catch(err) {
        console.log(err);
    }
    if(!listings){

        
        return res.status(404).json({message: "No listings found"});
    }
    return res.status(202).json(listings);
};

export const recommender = async(req,res,next) => {
    const userId = req.params.id;
    var viewed = req.body;
    if (req.body ==""){
        viewed="None"
    }
    let likes;
    try {
        likes = await Like.find({user: userId}).sort({timestamp: -1});
    }
    catch(err){
        return console.log(err);
    }
    if (likes.length > 0) {
        likes = likes.map(item => item.listing);
        likes = likes.toString()
    } else {
        likes = "a";
    }
    let discoverrecommendations;
    let extrarecommendations;
    let recommendationIDs;
    console.log(likes.toString())
    var process = spawn('python3',["./Classifier/CBRecommender.py", likes, viewed ],{shell: true} );

    for await (const data of process.stdout) {
        //console.log(data.toString())
        //Python returns object IDs as array in string datatype
        recommendationIDs= data.toString();
        recommendationIDs = recommendationIDs.replace(/'/g, '"');
        //Convert to actual array
        recommendationIDs = JSON.parse(recommendationIDs);
        //Change IDs to object ID type
        var discoveroids = [];
        var extraoids=[];
        var discoverConverted=false;
        //Keep discover and extra ids seperate for query
        recommendationIDs.forEach(function(item){
            //Flag between ids
            if(item=="*"){
                discoverConverted=true;
            }
            else{
                if(discoverConverted==false){
                    discoveroids.push(new mongoose.Types.ObjectId(item));
                }
                else{
                    extraoids.push(new mongoose.Types.ObjectId(item));
                }
            }  
        
        });
        
        //Get property data and return
        try{
            discoverrecommendations = await Listing.find({_id: { $in: discoveroids }}); 
        } catch(err) {
            console.log(err);
        }
        try{
            extrarecommendations = await Listing.find({_id: { $in: extraoids }}); 
        } catch(err) {
            console.log(err);
        }
        
        //discoverrecommendations =discoverrecommendations.concat(extrarecommendations);
        //console.log(recommendations);
        if(!discoverrecommendations){
            return res.status(404).json({message: "No listings found"});
        }
        return res.status(202).json({discoverProperties: discoverrecommendations, additionalProperties: extrarecommendations});
      };
    //look at user filters to pass to python
    //Look at 5 most recent liked properties from like table to pass to python function
    //Take viewed as parameter when we make this call, add to users viewed in database and pass to python 
}

export function authenticate(req, res, next) {
    
    const headers = req.headers['authorization']
    console.log(headers)
    if(headers) {
        try{
            // Bearer oabsdoabsoidabsiodabsiodbasoid
            const token = headers.split(' ')[1]
            const decoded = jwt.verify(token, 'SECRET')
            if(decoded) {
                const id = decoded.id 
                const persistedUser = User.findById(id)
                if(persistedUser) {
                next()
                } else {
                res.json({message: 'Unauthorized access'})
                }
            } else {
                return res.json({message: 'Unauthorized access'});
            }
            } catch(err){
                return res.status(400).json({message: 'Unauthorized access'});
            }

      
    } else {
      res.json({message: 'Unauthorized access'})
    }
    
}
  
// export const getAllListings = async(req, res, next) => {
    
//     return res.status(202).json(jsonData);
// };

export const newListing = async(req, res, next) => {
    const {title, body, images, user, category, tags} = req.body;

    let existingUser;
    try{
        existingUser = await User.findById(user);
    } catch(err){
        return console.log(err);
    }
    if (!existingUser){
        return res.status(400).json({message: "Unable to find user."});
    }
    const listing = Listing({
        address, 
        price, 
        images, 
        user, 
        category, 
        tags
    });
    try{
        const session = await mongoose.startSession();
        session.startTransaction();
        listing.save({session});
        existingUser.listings.push(listing);
        await existingUser.save({session});
        await session.commitTransaction();
    } catch(err){
        console.log(err);
        return res.status(500).json({message:err});
    }
    return res.status(200).json({ listing });
};

export const updateListing = async(req, res, next) => {
    const {title, body} = req.body;
    const listingId = req.params.id;
    let listing;
    try{
        listing = await Listing.findByIdAndUpdate(listingId, {
            title,
            body
        });
    } catch(err){
        return console.log(err);
    }
    if (!listing){
        return res.status(500).json({message: "Unable to update listing"});
    }
    return res.status(200).json({listing});
};

export const getListing = async(req, res, next) => {
    let listing;
    const listingId= req.params.id;
    try{
        listing = await Listing.findById(listingId);
    } catch(err){
        return console.log(err);
    }
    if (!listing){
        return res.status(404).json({message: "Unable to find listing"});
    }
    return res.status(200).json({listing});

};

export const deleteListing = async(req, res, next)=>{
    const listingId= req.params.id;
    let listing;
    try{
        listing = await Listing.findByIdAndDelete(listingId).populate("user");
        await listing.user.listings.pull(listing);
        await listing.user.save();
    } catch(err){
        return console.log(err);
    }
    if (!listing){
        return res.status(500).json({message: "Unable to delete listing."});
    }
    return res.status(200).json({message: "Listing successfully deleted."});
};

export const getUserListings = async(req,res,next)=>{
    let userListings;
    const userId = req.params.id;
    let ouid = new mongoose.Types.ObjectId(userId)
    //Add Limit/skip

    try {
        userListings = await Listing.find({agent: { $eq: ouid }});
    } catch(err) {
        return console.log(err);
    }
    if(!userListings){
        return res.status(404).json({message: "No listings found."});
    }
    console.log("Returning user listings")
    return res.status(200).json(userListings);
};