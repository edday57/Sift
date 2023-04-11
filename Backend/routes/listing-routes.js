import express from 'express';
import { getAllListings, newListing, updateListing, getListing, deleteListing, getUserListings, authenticate, recommenderCB, recommenderCF, getNamedListings} from '../controllers/listing-controller';
const listingRouter = express.Router();

listingRouter.post("/", authenticate, getAllListings);
listingRouter.post("/new", newListing);
listingRouter.put("/update/:id",updateListing);
listingRouter.get("/:id",getListing);
listingRouter.delete("/delete/:id", deleteListing);
listingRouter.get("/user/:id", authenticate, getUserListings);
listingRouter.post("/discover/cb/:id", authenticate, recommenderCB);
listingRouter.post("/discover/cf/:id", authenticate, recommenderCF);
listingRouter.get("/test/all", getNamedListings);
export default listingRouter;