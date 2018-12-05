const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

	// API NO. 1, takes data from the body of the request. keys to be passed in: email_id, password 
router.post('/login', (req, res, next) => {
    const email_id = req.body.email_id;
    sql = "SELECT * FROM users where email_id = ?";		                    			
	con.query(sql, email_id, function (queryerr, result, fields) {              // querying this way provides safety from sql injection 
        if (queryerr) {
            throw queryerr;
        }
        console.log(result);
        if (result.length < 1){
            res.status(400).json({
                message: "auth failed"
            })
        }
        bcrypt.compare(req.body.password, result[0].password, (err, succ) => {
            if (err) {
                return res.status(400).json({
                    message:'Auth Failed'
                });
            }
            if (result) {
                const token = jwt.sign(
                    {
                        email_id: result[0].email_id,                           // storing payload in jwt for further use
                        customer_id: result[0].id,
                        admin_status: result[0].admin_status                    // this will be used to verify the admin status of user in other api calls
                    },
                    "mysecretkey", {expiresIn: '1h'}
                );
                return res.status(200).json({
                    message: 'Auth Successful',
                    token: token
                });
            } else {
                return res.status(200).json({
                    message: 'Auth Failed'
                });
            }
        });
    });
    
});


// signup api
router.post('/signup', (req, res, next) => {
    const email_id = req.body.email_id;
    const regex = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    const match = email_id.match(regex);
    if (match ===  null) {
        res.status(400).json({
            message: "invalid email id format"
        });
    }
    sql = "SELECT email_id FROM users where email_id = ?";					
	con.query(sql, email_id, function (queryerr, result, fields) {
        if (queryerr) {
            throw queryerr;
        }
        console.log(result);
        if (result.length != 0){
            res.status(400).json({
                message: "email name exists"
            })
        } else {
            bcrypt.hash(req.body.password, 10, (err, hash) => {
                if (err) {
                    return res.status(500).json({
                        error: err
                    });
                } else {
                    const name = req.body.name;
                    const email_id = req.body.email_id;
                    const password = hash;
                    sql = "INSERT INTO `users` (`name`, `email_id`, `password`) VALUES ( ?, ?, ?);";					
                    con.query(sql, [name ,email_id, password], function (queryerr, result, fields) {
                        if (queryerr) {
                            throw queryerr;
                        } else{
                            res.status(200).json({
                                message: "user created successfully, login with your credentials now"
                            })
                        }
                        console.log(result);
                    });

                }
            });

        }
	});
    
});

module.exports = router;