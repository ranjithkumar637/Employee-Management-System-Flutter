const express=require("express");
const List = require("./schema");
const Dep=require("./dep_schema");
const Staff=require("./add_staff");
const list=express.Router();
const Leave=require("./leave_schema");
const Salary = require('./data_schema');
list.use(express.json());
list.post('/loginpu',async(req,res)=>{
  try{
    const {username,password}=req.body;
    const no_user=await List.findOne({username});
    if(no_user){
        return res.status(400).json({msg:"The user is already login"});
    }
    let lister= new List({
        username,
        password
    });
    lister=await lister.save();
    res.json(lister); } catch (error) {
      res.status(400).json({ msg: error.message });
    }
});
list.post('/loginpu',async(req,res)=>{
  try{
    const {username,password}=req.body;
    const no_user=await List.findOne({username});
    if(no_user){
        return res.status(400).json({msg:"The user is already login"});
    }
    let lister= new List({
        username,
        password
    });
    lister=await lister.save();
    res.json(lister); } catch (error) {
      res.status(400).json({ msg: error.message });
    }
});
list.get('/login',async(req,res)=>{
  try{
  const fetch=await List.findOne({username:req.query.username});
  if(fetch)
  res.json({msg:"yes"});
  else
  res.json({msg:'Check Email and Password'});

} catch (error) {
    res.status(400).json({ msg: error.message });
  }
});

list.post('/dep',async(req,res)=>{
  try{
    const {dept}=req.body;
    const no_dept=await Dep.findOne({dept});
    if(no_dept){
        return res.status(400).json({msg:"Already exists"});
    }
    let Dept= new Dep({
      dept
    });
    Dept=await Dept.save();
    res.json(Dept);} catch (error) {
      res.status(400).json({ msg: error.message });
    }
}) 
list.post('/staff',async(req,res)=>{
  try{
    const {name, department, gender, email, mobile, photo, dateOfBirth, dateOfJoining, city, state, country, address}=req.body;
   
    let user= new Staff({
        name, department, gender, email, mobile, photo, dateOfBirth, dateOfJoining, city, state, country, address
      
    });
    user=await user.save();
    res.json(user);
  } catch (error) {
    res.status(400).json({ msg: error.message });
  }
}) 
list.post('/add-salary',async (req, res) => {
  try{
    const {staff,
    basicSalary,
    allowance,
    total}=req.body;
   
    let salary= new Salary({
        staff,
    basicSalary,
    allowance,
    total
    });
    salary=await salary.save();
    res.json(salary);} catch (error) {
      res.status(400).json({ msg: error.message });
    }
  });
  list.post('/leave',async (req, res) => {
    try{
    const {
        staff, photo, department, reason, from, to, description, appliedOn, action}=req.body;
    let leave= new Leave({
        staff, photo, department, reason, from, to, description, appliedOn, action
    });
    leave=await leave.save();
    res.json(leave);} catch (error) {
      res.status(400).json({ msg: error.message });
    }
  });
  list.get('/leaveget',async (req, res) => {
    try{
   const leaver=await Leave.find({});
    res.json(leaver);} catch (error) {
      res.status(400).json({ msg: error.message });
    }
  });
  list.put('/update/:staffName', async (req, res) => {
    try {
      const staffName = req.params.staffName;
      const newData = req.body;
  
      
      const updatedData = await Leave.findOneAndUpdate(
        { staff: staffName }, 
        newData, 
        { new: true } 
      );
      res.json(updatedData);
    } catch (error) {
      res.status(500).json({ message: 'Error updating data' });
    }
  });

  list.get('/depget',async(req,res)=>{
    try{
    const fetch=await Dep.find({});
    res.json(fetch);} catch (error) {
      res.status(400).json({ msg: error.message });
    }
  });

  list.get('/depsp',async(req,res)=>{
    try{
    const fetch=await Staff.find({department:req.query.department});
    res.json(fetch);} catch (error) {
      res.status(400).json({ msg: error.message });
    }
  });
  list.get('/staff',async(req,res)=>{
    try{
    const fetchly=await Staff.find({});
    res.json(fetchly);} catch (error) {
      res.status(400).json({ msg: error.message });
    }
  });
  list.delete('/delete', async (req, res) => {
    try {
      const departmentToDelete = req.query.email;
  
      // Use the provided department to delete the documents that match the criteria
      const result = await Staff.deleteOne({ email: departmentToDelete });
  
      if (result.deletedCount === 0) {
        return res.json({
          success: false,
          message: `No documents found for department: ${departmentToDelete}`,
        });
      }
  
      res.json({
        success: true,
        message: `Documents deleted for department: ${departmentToDelete}`,
      });
    } catch (err) {
      res.status(500).json({ success: false, error: err.message });
    }
  });
 



module.exports = list;