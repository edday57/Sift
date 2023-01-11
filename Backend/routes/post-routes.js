import express from 'express';
import { getAllPosts, newPost, updatePost, getPost, deletePost, getUserPosts} from '../controllers/post-controller';
const postRouter = express.Router();

postRouter.get("/",getAllPosts);
postRouter.post("/new", newPost);
postRouter.put("/update/:id",updatePost);
postRouter.get("/:id",getPost);
postRouter.delete("/delete/:id", deletePost);
postRouter.get("/user/:id", getUserPosts);
export default postRouter;