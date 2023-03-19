import mongoose from "mongoose";
const Schema = mongoose.Schema;
const listingSchema = Schema({
    address : {
        type: String,
        required: true
    },
    price : {
        type: Number,
        required: true
    },
    property_type: {
        type: String,
        required: true
    },
    bedrooms: {
        type: Number,
        required: true
    },
    bathrooms: {
        type: Number,
        required: true
    },
    sizesqft: {
        type: Number,
        required: false
    },
    latitude: {
        type: Number,
        required: true
    },
    longitude: {
        type: Number,
        required: true
    },
    date_added: {
        type: Date,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    features: {
        type: [String],
        required: false
    },
    let_type: {
        type: String,
        required: false
    },
    deposit: {
        type: Number,
        required: false
    },
    furnish_type: {
        type: String,
        required: false
    },
    images: {
        type: [String],
        required: true
    },
    link: {
        type: String,
        required: true
    },
    floorplan: {
        type: String,
        required: false
    },
    agent: {
        type: mongoose.Types.ObjectId,
        ref: "User",
        required: true
    },
    matchscore: {
        type: Number,
        required: false
    }
    
});
export default mongoose.model("Listing", listingSchema);