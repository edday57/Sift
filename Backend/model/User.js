import mongoose from "mongoose";
const Schema = mongoose.Schema;
const userSchema = Schema({
    name : {
        type: String,
        required: true
    },
    email : {
        type: String,
        required: true,
        unique: true
    },
    mobile : {
        type: Number,
        required: false,
        unique: true
    },
    password : {
        type: String,
        required: false,
        minLength: 6
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
    renterType:{
        type: String,
        required: false
    },
    profession:{
        type: String,
        required: false
    },
    salary:{
        type: Number,
        required: false
    },
    token: {
        type: String,
        required: false
    },
    isAgent: {
        type: Boolean,
        required: true
    },
    test: {
        type: Boolean,
        required: false
    }
});
export default mongoose.model("User", userSchema);