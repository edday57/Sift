import { response } from "express";
import Post from "../Post";
import User from "../model/User";
import mongoose from "mongoose";

export const getAllPosts = async(req, res, next) => {
    let posts;

    try {
        posts = await Post.find();
    } catch(err) {
        console.log(err);
    }
    if(!posts){
        return res.status(404).json({message: "No posts found"});
    }
    return res.status(202).json({ posts });
};

export const newPost = async(req, res, next) => {
    const {title, body, images, user, category, tags} = req.body;

    //Classify post

    let existingUser;
    try{
        existingUser = await User.findById(user);
    } catch(err){
        return console.log(err);
    }
    if (!existingUser){
        return res.status(400).json({message: "Unable to find user."});
    }
    const post = Post({
        title, 
        body, 
        images, 
        user, 
        category, 
        tags
    });
    try{
        const session = await mongoose.startSession();
        session.startTransaction();
        post.save({session});
        existingUser.posts.push(post);
        await existingUser.save({session});
        await session.commitTransaction();
    } catch(err){
        console.log(err);
        return res.status(500).json({message:err});
    }
    return res.status(200).json({ post });
};

export const updatePost = async(req, res, next) => {
    const {title, body} = req.body;
    const postId = req.params.id;
    let post;
    try{
        post = await Post.findByIdAndUpdate(postId, {
            title,
            body
        });
    } catch(err){
        return console.log(err);
    }
    if (!post){
        return res.status(500).json({message: "Unable to update post"});
    }
    return res.status(200).json({post});
};

export const getPost = async(req, res, next) => {
    let post;
    const postId= req.params.id;
    try{
        post = await Post.findById(postId);
    } catch(err){
        return console.log(err);
    }
    if (!post){
        return res.status(404).json({message: "Unable to find post"});
    }
    return res.status(200).json({post});

};

export const deletePost = async(req, res, next)=>{
    const postId= req.params.id;
    let post;
    try{
        post = await Post.findByIdAndDelete(postId).populate("user");
        await post.user.posts.pull(post);
        await post.user.save();
    } catch(err){
        return console.log(err);
    }
    if (!post){
        return res.status(500).json({message: "Unable to delete post."});
    }
    return res.status(200).json({message: "Post successfully deleted."});
};

export const getUserPosts = async(req,res,next)=>{
    let userPosts;
    const userId = req.params.id;

    //Add Limit/skip

    try {
        userPosts = await User.findById(userId).populate("posts");
    } catch(err) {
        return console.log(err);
    }
    if(!userPosts){
        return res.status(404).json({message: "No posts found."});
    }
    return res.status(200).json({posts: userPosts});
};