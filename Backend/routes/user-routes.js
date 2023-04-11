import express from 'express';
import { validate } from '../controllers/middleware/validation/validation';
import { loginSchema, signUpSchema } from '../controllers/middleware/validation/validationSchemas';
import { getAllUser, signUp, login, updateProfile, fetchUser, googleLogin, checkEmail } from '../controllers/user-controller';

const router = express.Router();

router.get("/",getAllUser);
router.get("/:id",fetchUser);
router.post("/checkEmailExists", checkEmail);
router.post("/signup", validate(signUpSchema),signUp);
router.post("/login", validate(loginSchema), login);
router.post("/googleLogin", googleLogin);
router.put("/updateProfile/:id", updateProfile);
export default router;