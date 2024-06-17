const express = require('express');
const Order = require('../models/order'); // Ensure the path is correct
const router = express.Router();

// Create a new order
router.post('/orders', async (req, res) => {
  const { shoeId, quantity, userId } = req.body;
  try {
    const order = new Order({ shoeId, quantity, userId });
    await order.save();
    res.status(201).send(order);
  } catch (error) {
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
