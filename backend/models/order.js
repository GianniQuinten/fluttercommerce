const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const orderSchema = new Schema({
  shoeId: {
    type: Schema.Types.ObjectId,
    required: true,
    ref: 'Sneaker' // Reference to the Sneaker model
  },
  quantity: {
    type: Number,
    required: true
  },
  userName: {
    type: String,
    required: true
  },
  userAddress: {
    type: String,
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: {
    type: Date,
    default: Date.now
  }
});

const Order = mongoose.model('Order', orderSchema);

module.exports = Order;
