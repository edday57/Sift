import { json, response } from "express";
import Listing from "../model/Listing"
import User from "../model/User";
import mongoose from "mongoose";
//import jsonData from '../../Scraper/data2.json'
import jwt from 'jsonwebtoken'

export const getAllListings = async(req, res, next) => {
    let listings;
    try {
        listings = await Listing.find();
    } catch(err) {
        console.log(err);
    }
    if(!listings){
        return res.status(404).json({message: "No listings found"});
    }
    return res.status(202).json(listings);
};
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
        listing = await Listing.findByIdAndUpdate(listingtId, {
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

    //Add Limit/skip

    try {
        userListings = await User.findById(userId).populate("listings");
    } catch(err) {
        return console.log(err);
    }
    if(!userListings){
        return res.status(404).json({message: "No listings found."});
    }
    return res.status(200).json({listings: userListings});
};