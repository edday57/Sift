import mongoose from "mongoose";
const Schema = mongoose.Schema;
const likeSchema = Schema({
    user: {
        type: mongoose.Types.ObjectId,
        ref: "User",
        required: true
    },
    listing: {
        type: mongoose.Types.ObjectId,
        ref: "Listing",
        required: true
    },
    timestamp: {
        type: Date,
        required: true
    }
});
export default mongoose.model("Like", likeSchema);