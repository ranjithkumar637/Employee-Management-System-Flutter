const express=require('express');
const mongoose=require('mongoose');
const app=express();
const push=require("./pusher");
const port='3000';
const cloud='mongodb+srv://employee:employee@cluster0.xm1lpsw.mongodb.net/?retryWrites=true&w=majority'

mongoose.connect(cloud).then(()=>{
    console.log("mongoose connect");
})
app.use(express.json());
app.use(push);
app.listen(port,'0.0.0.0',()=>{
    console.log(`Connection esatablish in port number ${port}`);
})

