import mongoose from "mongoose";
const Schema = mongoose.Schema;
const eventSchema = Schema({
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
    },
    type: {
        type: String,
        required: true
    },
    details: {
        type: String,
        required: false
    }
});
export default mongoose.model("Event", eventSchema);