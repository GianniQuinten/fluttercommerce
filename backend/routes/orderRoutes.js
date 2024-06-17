const express = require('express');
const Order = require('../models/order');
const router = express.Router();

// Create a new order
router.post('/orders', async (req, res) => {
  const { userName, userAddress, items } = req.body;
  console.log('Received order data:', req.body);  // Log received data
  try {
    const orders = items.map(item => ({
      shoeId: item.shoeId,
      quantity: item.quantity,
      userName,
      userAddress,
    }));
    console.log('Parsed orders:', orders);  // Log parsed orders
    const newOrders = await Order.insertMany(orders);
    res.status(201).send(newOrders);
  } catch (error) {
    console.error('Error creating order:', error);
    res.status(400).send(error);
  }
});

// Get all orders
router.get('/orders', async (req, res) => {
  try {
    const orders = await Order.find();
    res.status(200).send(orders);
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
