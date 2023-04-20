import express from 'express';
import { validate } from '../controllers/middleware/validation/validation';
import { loginSchema, signUpSchema } from '../controllers/middleware/validation/validationSchemas';
import { getAllUser, signUp, login, updateProfile, fetchUser, googleLogin, checkEmail, signUpImg } from '../controllers/user-controller';
import multer from 'multer';
import aws from 'aws-sdk';
import multerS3 from 'multer-s3';
const spacesEndpoint = new aws.Endpoint('nyc3.digitaloceanspaces.com');
const s3 = new aws.S3({
  endpoint: spacesEndpoint
});


const upload = multer({
    storage: multerS3({
      s3: s3,
      bucket: 'sift',
      acl: 'public-read',
      key: function (request, file, cb) {
        console.log(file);
        cb(null, String(Date.now()));
      }
    })
  });

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