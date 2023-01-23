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
    r;
};