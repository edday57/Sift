import express from 'express';
import { addLike, getLikes, removeLike } from '../controllers/like-controller';
import { authenticate } from '../controllers/listing-controller';

const likeRouter = express.Router();

likeRouter.post("/add",authenticate, addLike);
likeRouter.delete("/remove",authenticate, removeLike);
likeRouter.get("/:id",authenticate, getLikes);

export default likeRouter;