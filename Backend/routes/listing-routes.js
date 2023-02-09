import express from 'express';
import { getAllListings, newListing, updateListing, getListing, deleteListing, getUserListings, authenticate, recommender} from '../controllers/listing-controller';
const listingRouter = express.Router();

listingRouter.post("/", authenticate, getAllListings);
listingRouter.post("/new", newListing);
listingRouter.put("/update/:id",updateListing);
listingRouter.get("/:id",getListing);
listingRouter.delete("/delete/:id", deleteListing);
listingRouter.get("/user/:id", getUserListings);
listingRouter.post("/discover/:id", authenticate, recommender);
export default listingRouter;