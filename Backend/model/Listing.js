import mongoose from "mongoose";
const Schema = mongoose.Schema;
const listingSchema = Schema({
    title : {
        type: String,
        required: true
    },
    body : {
        type: String,
        required: true
    },
    images : {
        type: [String],
        required: true
    },
    user : {
        type: mongoose.Types.ObjectId,
        ref: "User",
        required: true
    },
    category : {
        type: String,
        required: true
    },
    tags : {
        type : [String],
        required: true
    }
});
export default mongoose.model("Listing", listingSchema);