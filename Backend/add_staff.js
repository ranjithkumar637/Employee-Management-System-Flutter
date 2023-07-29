const mongoose = require('mongoose');


const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true, 
  },
  department: {
    type: String,
    
  },
  gender: {
    type: String,
   
  
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    lowercase: true,
    validate: {
      validator: function (value) {
        
        return /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/.test(value);
      },
      message: 'Invalid email address',
    },
  },
  mobile: {
    type: String,
    required: true,
    validate: {
      validator: function (value) {
        return /^\+[1-9]\d{1,14}$/.test(value);
      },
      message: 'Invalid mobile number (must be in the international format, e.g., +1234567890)',
    },
  },
  photo: {
    type: String,
    default:" "
  },
  dateOfBirth: {
    type: String,
    required: true,
    
   
  },
  dateOfJoining: {
    type: String,
    required: true,
  
  
  },
  city: {
    type: String,
    required: true,
    trim: true,
  },
  state: {
    type: String,
    required: true,
    trim: true,
  },
  country: {
    type: String,
    required: true,
    trim: true,
  },
  address: {
    type: String,
    required: true,
    trim: true,
  },
});
const User = mongoose.model('User', userSchema);

module.exports = User;
