var mongoose= require('mongoose')

var Schema=mongoose.Schema;

var productSchema=new Schema({
    uuid:String,
    productId:String,
    productCode:String,
    productName:String,
    productPrice:String,
})

var Product = mongoose.model('Product',productSchema)

module.exports=Product