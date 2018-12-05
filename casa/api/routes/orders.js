const express = require('express');
const router = express.Router();
const checkAuth = require('../middleware/check-auth');

    // API NO. 2, returns all orders placed if the logged in user is admin.
	// Here offset is the start index to fetch record from database and limit tells how many records to fetch.
	// these values could be sent from the front end by implementing something like pagination such that only limited
	// number of records are shown and screen is not flooded with the result. 
	// so on first load, offset will be 0 and limit might be 10, on clicking page 2, offset will be 10 and limit again 10
	// i.e general formula could be (page_num - 1)*10 for offset
router.get('/allOrders/:offset/:limit', checkAuth, (req, res, next) => {
    console.log(req.userData);
    if (req.userData.admin_status != 1){                                            // checking the admin status of user from jwt
        return res.status(400).json({
            message:"not an admin user, unauthorized access"
        });
    }
    sql = "SELECT * FROM orders limit ?,?";					                        // fetching all order
    const offset = parseInt(req.params.offset);
    const limit = parseInt(req.params.limit);
	con.query(sql, [offset, limit], function (queryerr, result, fields) {
        if (queryerr) {
            throw queryerr;
        }
        console.log(result);
        if (result.length == 0){
            console.log("returned with empty row");
            return res.status(200).json({
                message:"no data available to fetch"
            });
        }
        res.status(200).json({
            message: "orders fetched"        
        });								                        //****** result set with all the orders
    });
    
});

	// API NO. 3, returns the orders placed by the logged in user
	// if required, the same logic of offset and limit can be implemented here as well
router.get('/userOrders', checkAuth, (req, res, next) => {

    userID = req.userData.customer_id;                                              // extracting customer_id from the jwt
    sql = "SELECT * FROM orders WHERE customer_id = ?";			                    // fetiching all orders made my the user
	con.query(sql, userID, function (err, result, fields) 
	{
		if (err) 
			throw err;
        console.log(result);
        if (result.length == 0){
            console.log("returned with empty row");
            return res.status(200).json({
                message:"no data available to fetch"
            });
        }
        res.status(200).json({
            message: "orders fetched"        
        });									                    //****** result set with all orders of a user
    });
    
    
});
    // API NO. 4, returns the details of a particular order placed given an order_number
router.get('/orderDetails/:orderNumber', checkAuth, (req, res, next) => {
    
    var orderNumber = req.params.orderNumber;
    // check if the order number belongs to this user. if not, then send error
	// if admin is looking for this order details then proceed
	if (req.userData.admin_status!=1) {										    // checking for admin status
		sql = "SELECT customer_id FROM orders WHERE order_id = ?";		        // customer id who made this order
		con.query(sql, orderNumber, function (err, result, fields) {
            if (err) throw err;
            console.log("***************");
            console.log(result.length);
            if (result.length == 0){
                console.log("returned with empty row");
                return res.status(200).json({
                    message:"no data available to fetch"
                });
            }
            res.status(200).json({
                message: "orders fetched"        
            });
			console.log(result[0]['customer_id']);
			if (result[0]['customer_id'] != req.userData.id) {			// if the logged in customer is different from the owner of order number then return error msg
				res.sendStatus(403);
			};
        });
        
	}
	// since the number of records in order_details table can be huge, 
	// it is better to reduce the size of tables while joining, this will result in faster execution
	sql = "SELECT temp_order.order_id, temp_order.product_id, product.product_name, product.price, temp_order.quantity AS 'quantity purchased' FROM (SELECT order_id, product_id, quantity FROM order_details WHERE order_id = ?) AS temp_order JOIN product ON temp_order.product_id = product.product_id";
	con.query(sql, orderNumber, function (err, result, fields) 
	{
		if (err) 
			throw err;
        console.log(result);                                                        //******** result with order details
        if (result.length == 0){
            console.log("returned with empty row");
            return res.status(200).json({
                message:"no data available to fetch"
            });
        }
        res.status(200).json({
            message: "orders fetched"        
        });											
    });
});

// can be used to POST orders
router.post('/', (req, res, next) => {
    res.status(200).json({
        message: 'POST METHOD /ORDERS'
    });
});

module.exports = router;