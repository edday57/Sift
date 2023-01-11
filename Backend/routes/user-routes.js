import express from 'express';
import { getAllUser, signUp, login, completeSignUp } from '../controllers/user-controller';

const router = express.Router();

router.get("/",getAllUser);

router.post("/signup", signUp);
router.post("/login", login);
router.put("/completeSignup/:id", completeSignUp);
export default router;