import express from 'express';
import mongoose from 'mongoose';
import listingRouter from './routes/listing-routes';
import router from './routes/user-routes';
import jwt from 'jsonwebtoken';
import likeRouter from './routes/like-routes';
const app = express();
import cors from 'cors'
import bodyParser from 'body-parser'

//"fltHUuMl1uLNnCC9";
app.use(express.json());
app.use(cors());
//app.use(express.urlencoded({ extended: false, limit: '2gb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '2gb' }))
app.use(bodyParser.json())
app.use("/api/user", router);
app.use("/api/listing", listingRouter);
app.use("/api/like", likeRouter);
app.use(express.static('public'));

const port = process.env.PORT || 5000;

mongoose
.connect("mongodb+srv://admin:fltHUuMl1uLNnCC9@cluster0.vxxksfc.mongodb.net/db?retryWrites=true&w=majority")
.then(()=>app.listen(port, () => console.log(`Listening on ${port}`)))
.then(()=>console.log("connected"))
.catch((err)=>console.log(err));
