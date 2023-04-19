import express from 'express';
import { validate } from '../controllers/middleware/validation/validation';
import { loginSchema, signUpSchema } from '../controllers/middleware/validation/validationSchemas';
import { getAllUser, signUp, login, updateProfile, fetchUser, googleLogin, checkEmail, signUpImg } from '../controllers/user-controller';
import multer from 'multer';
var storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'public/uploads/')
    },
    filename: (req, file, cb) => {
        cb(null, file.fieldname + '-' + Date.now())
    }
});
var upload = multer({ storage: storage });
const router = express.Router();

router.get("/",getAllUser);
router.get("/:id",fetchUser);
router.post("/checkEmailExists", checkEmail);
router.post("/signup", validate(signUpSchema),signUp);
router.post("/signupImg" ,upload.single('image'), signUpImg);
router.post("/login", validate(loginSchema), login);
router.post("/googleLogin", googleLogin);
router.put("/updateProfile/:id", updateProfile);
export default router;