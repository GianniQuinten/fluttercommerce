const mongoose = require('mongoose');
require('dotenv').config();
const Sneaker = require('./models/sneaker'); // Ensure the path is correct
const Order = require('./models/order'); // Ensure the path is correct

mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log('Connected to MongoDB');
    insertMockData();
  })
  .catch(err => {
    console.error('Failed to connect to MongoDB', err);
  });

const insertMockData = async () => {
  try {
    // Mock data for sneakers
    const sneakers = [
      {
        shoeName: 'Air Jordan 1',
        brand: 'Nike',
        silhoutte: 'High',
        styleID: '12345',
        retailPrice: 160,
        releaseDate: '2023-01-01',
        description: 'Classic Air Jordan 1',
        imageLinks: ['https://example.com/aj1.jpg'],
        thumbnail: 'https://example.com/aj1-thumb.jpg',
        urlKey: 'air-jordan-1',
        make: 'USA',
        goatProductId: 98765,
        colorway: 'Red/Black',
        resellLinks: {
          stockX: 'https://stockx.com/air-jordan-1',
          stadiumGoods: 'https://stadiumgoods.com/air-jordan-1',
          goat: 'https://goat.com/air-jordan-1',
          flightClub: 'https://flightclub.com/air-jordan-1'
        },
        size: 10,
        lowestResellPrice: { stockX: 200, stadiumGoods: 220, goat: 210, flightClub: 230 },
        resellPrices: {
          stockX: {},
          goat: {},
          stadiumGoods: {},
          flightClub: {}
        }
      },
      // Add more sneaker data here if needed
    ];

    // Insert sneakers
    const insertedSneakers = await Sneaker.insertMany(sneakers);
    console.log('Inserted sneakers:', insertedSneakers);

    // Mock data for orders
    const orders = [
      {
        shoeId: insertedSneakers[0]._id, // Use the first inserted sneaker ID
        quantity: 1,
        userName: 'John Doe',
        userAddress: '123 Main St, Anytown, USA'
      },
      // Add more order data here if needed
    ];

    // Insert orders
    const insertedOrders = await Order.insertMany(orders);
    console.log('Inserted orders:', insertedOrders);

    process.exit();
  } catch (err) {
    console.error('Error inserting mock data:', err);
    process.exit(1);
  }
};
