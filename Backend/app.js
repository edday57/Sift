import express from 'express';
import mongoose from 'mongoose';
import listingRouter from './routes/listing-routes';
import router from './routes/user-routes';
import jwt from 'jsonwebtoken';
const app = express();


//"fltHUuMl1uLNnCC9";
app.use(express.json());
app.use("/api/user", router);
app.use("/api/listing", listingRouter);


mongoose
.connect("mongodb+srv://admin:fltHUuMl1uLNnCC9@cluster0.vxxksfc.mongodb.net/db?retryWrites=true&w=majority")
.then(()=>app.listen(5000))
.then(()=>console.log("connected"))
.catch((err)=>console.log(err));
