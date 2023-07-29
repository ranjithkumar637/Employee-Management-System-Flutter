const mongoose = require('mongoose');

const leaveRequestSchema = new mongoose.Schema({
  staff: {
    type: String,
    required: true,
  },
  photo: {
    type: String,
    required: true,
  },
  department: {
    type: String,
    required: true,
  },
  reason: {
    type: String,
    required: true,
  },
  from: {
    type: String,
    required: true,
  },
  to: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  appliedOn: {
    type: String,
    required: true,
  },
  action: {
    type: Boolean,
    required: true,
  },
});

const LeaveRequest = mongoose.model('LeaveRequest', leaveRequestSchema);

module.exports = LeaveRequest;