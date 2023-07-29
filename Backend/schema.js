const mongoose=require("mongoose");
const schema=mongoose.Schema({
    username:
    {
        require:true,
        type:String
    },
    password:{
        require:true,
        type:String,
    }
});


const List= mongoose.model("List",schema);

module.exports = List;
