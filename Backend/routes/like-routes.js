import express from 'express';
import { addLike, getLikedPosts, getLikes, removeLike, toggleLike } from '../controllers/like-controller';
import { authenticate } from '../controllers/listing-controller';

const likeRouter = express.Router();

likeRouter.post("/add",authenticate, addLike);
likeRouter.post("/toggle",authenticate, toggleLike);
likeRouter.delete("/remove",authenticate, removeLike);
likeRouter.get("/:id",authenticate, getLikes);
likeRouter.post("/posts/:id",authenticate, getLikedPosts);

export default likeRouter;