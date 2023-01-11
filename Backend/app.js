import express from 'express';
import mongoose from 'mongoose';
import postRouter from './routes/post-routes';
import router from './routes/user-routes';
import jwt from 'jsonwebtoken';
const app = express();
//"fltHUuMl1uLNnCC9";
app.use(express.json());
app.use("/api/user", router);
app.use("/api/post", postRouter);

mongoose
.connect("mongodb+srv://admin:fltHUuMl1uLNnCC9@cluster0.vxxksfc.mongodb.net/?retryWrites=true&w=majority")
.then(()=>app.listen(5000))
.then(()=>console.log("connected"))
.catch((err)=>console.log(err));
