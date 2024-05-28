const express = require('express');
const app = express();
const mongoose = require('mongoose');
require('dotenv').config();
require('./routes/sneaks.routes.js')(app);
const SneaksAPI = require('./controllers/sneaks.controllers.js');

var port = process.env.PORT || 4000;
mongoose.Promise = global.Promise;

// Connect to MongoDB
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log('Connected to MongoDB');
    // Start the server only after the DB connection is established
    app.listen(port, function () {
      console.log(`Sneaks app listening on port `, port);
    });
  })
  .catch(err => {
    console.error('Failed to connect to MongoDB', err);
  });

module.exports = app;
module.exports = SneaksAPI;