import mongoose from "mongoose";
const Schema = mongoose.Schema;
const filterSchema = Schema({
    minPrice : {
        type: Number,
        required: false
    },
    maxPrice : {
        type: Number,
        required: false
    },
    property_type: {
        type: [String],
        required: true
    },
    minBedrooms: {
        type: Number,
        required: false
    },
    maxBedrooms: {
        type: Number,
        required: false
    },
    minBathrooms: {
        type: Number,
        required: false
    },
    maxBathrooms: {
        type: Number,
        required: false
    },
    user: {
        type: mongoose.Types.ObjectId,
        ref: "User",
        required: true
    }
});
export default mongoose.model("Filter", filterSchema);