const express = require('express');
const router = express.Router();
const checkAuth = require('../middleware/check-auth');


// could be used to get products
router.get('/', (req, res, next) => {
    res.status(200).json({
        message: 'GET METHOD /PRODUTS'        
    });
});

// could be used to post products
router.post('/', (req, res, next) => {
    res.status(200).json({
        message: 'POST METHOD /PRODUCTS',
    });
});

module.exports = router;