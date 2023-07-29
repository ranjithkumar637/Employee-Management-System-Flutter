const mongoose = require('mongoose');

const salarySchema = new mongoose.Schema({
  staff: {
    type: String,
    required: true,
  },
  basicSalary: {
    type: String,
    required: true,
  },
  allowance: {
    type: String,
    required: true,
    default: 0, // Provide a default value for allowance (optional field)
  },
  total: {
    type: String,
    require:true,
  
  },
});

const Salary = mongoose.model('Salary', salarySchema);

module.exports = Salary;