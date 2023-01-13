import mongoose from "mongoose";
const Schema = mongoose.Schema;
const userSchema = Schema({
    name : {
        type: String,
        required: false
    },
    email : {
        type: String,
        required: true,
        unique: true
    },
    password : {
        type: String,
        required: true,
        minLength: 6
    },
    signedUp : {
        type: Boolean,
        required: true
    },
    dob:{
        type: String,
        required: false
    },
    about:{
        type: String,
        required: false
    },
    image:{
        type: String,
        required: false
    },
    token: {
        type: String,
        required: false
    },
    listings:[{type: mongoose.Types.ObjectId, ref: "Listing", required: true}]
});
export default mongoose.model("User", userSchema);