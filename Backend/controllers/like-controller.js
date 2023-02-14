import User from "../model/User";
import Listing from "../model/Listing";
import jwt from 'jsonwebtoken'
import Like from "../model/Like";

export const addLike = async(req, res, next) => {
    let {user, listing} = req.body;
    let isLiked;
    try {
        isLiked = await Like.findOne({user, listing});
    }
    catch(err){
        return console.log(err);
    }
    if (isLiked){
        return res.status(400).json({message: "Post already liked"});
    }
    const like = Like({
        user,
        listing,
        timestamp: Date.now()
    })
    try{
        await like.save();
        return res.status(200).json({like});
    } catch(err){
        return console.log(err);
    }
};

export const toggleLike = async(req, res, next) => {
    let user = req.query.user
    let listing = req.query.listing
    let isLiked;
    let like;
    try {
        isLiked = await Like.findOne({user, listing});
    }
    catch(err){
        return console.log(err);
    }
    if (isLiked){
        try {
            like = await Like.findOneAndDelete({user, listing});
        }
        catch(err){
            return console.log(err);
        }
        if (!like){
            return res.status(400).json({message: "Post not already liked"});
        }
        return res.status(200).json({message: "Like successfully deleted."});
    }
    else {
        const like = Like({
            user,
            listing,
            timestamp: Date.now()
        })
        try{
            await like.save();
            return res.status(201).json({message: "Like successfully added."});
        } catch(err){
            return console.log(err);
        }
    }

};

export const removeLike = async(req, res, next) => {
    let {user, listing} = req.body;
    let like;
    try {
        like = await Like.findOneAndDelete({user, listing});
    }
    catch(err){
        return console.log(err);
    }
    if (!like){
        return res.status(400).json({message: "Post not already liked"});
    }
    return res.status(200).json({message: "Like successfully deleted."});
};

export const getLikedPosts = async(req, res, next) => {
    //
    let {filters} =req.body;
    const userId = req.params.id;
    let likes;
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

    //Get liked post IDs
    try {
        likes = await Like.find({user: userId}).sort({timestamp: -1});
    }
    catch(err){
        return console.log(err);
    }
    if (likes.length > 0) {
        let listingIds = likes.map(item => item.listing);
        let likedListings;
        //Get data for liked posts
        match._id = { $in: listingIds };
        try{
            likedListings = await Listing.aggregate([
                { $match: match },
                { $addFields: { "__order" : { "$indexOfArray" : [ listingIds, "$_id" ] } }},
                { $sort: { "__order": 1 }},
                //To implement sort and skip
                { $skip: skip },
                { $limit: limit },
            ]);
        } catch(err) {
            console.log(err);
        }
        //let obj = {}
        //likedListings.forEach(x => obj[x._id]=x)
        //const ordered = listingIds.map(key => obj[key])
        return res.status(200).json(likedListings);
    } else {
        return res.status(200).json([]);
    }
    
};

export const getLikes = async(req, res, next) => {
    const userId = req.params.id;
    let likes;
    try {
        likes = await Like.find({user: userId}).sort({timestamp: -1});
    }
    catch(err){
        return console.log(err);
    }
    if (likes.length > 0) {
        let listingIds = likes.map(item => item.listing)

        return res.status(200).json(listingIds);
    } else {
        return res.status(200).json([]);
    }
    
};