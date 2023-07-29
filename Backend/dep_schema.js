const mongoose=require("mongoose");

const schema_dept=mongoose.Schema({

    dept:{
        require:true,
        type:String
    }
});
const Dept=mongoose.model("Dept",schema_dept);
module.exports=Dept;