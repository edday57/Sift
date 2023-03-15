import express from 'express';
import { getAllUser, signUp, login, completeSignUp, fetchUser, googleLogin, checkEmail } from '../controllers/user-controller';

const router = express.Router();

router.get("/",getAllUser);
router.get("/:id",fetchUser);
router.post("/checkEmailExists", checkEmail);
router.post("/signup", signUp);
router.post("/login", login);
router.post("/googleLogin", googleLogin);
router.put("/completeSignup/:id", completeSignUp);
export default router;