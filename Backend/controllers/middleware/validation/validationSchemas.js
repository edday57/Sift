import { body } from 'express-validator'

export const loginSchema = [
    body('email').not().isEmpty().withMessage('Email must be provided'),
    body('password').not().isEmpty().withMessage('Password must be provided'),
];

export const signUpSchema = [
    body('email').not().isEmpty().withMessage('Email must be provided'),
    body('name').not().isEmpty().withMessage('Name must be provided'),
    body('fromGoogle').isBoolean().withMessage('Must specify whether sign up is from Google'),
];