var express = require('express')

var app = express()
var bodyParser = require('body-parser')

var urlEncodedParser = bodyParser.urlencoded({ extended: false })

var mongoose = require('mongoose')
var Product = require('./product')
var url = 'mongodb+srv://...:....@cluster0.jtjlj.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'


mongoose.connect(url, { useNewUrlParser: true, useUnifiedTopology: true }).then((result) => {
    console.log("baglanti kuruldu")

}).catch((err) => { console.log(err) })

app.get('/view', function (requset, response) {
    Product.find({}, (error, data) => {
        if (error) {
            throw error;
        }
        console.log('okuma işlemi başarılı')
        response.send(data)

    })

})
app.post('/create', urlEncodedParser, function (requset, response) {
    var product = new Product(requset.body)
    console.log(requset.body)

    product.save((error) => {
        if (error) {
            throw error
        }
        console.log('ekleme işlemi başarılı')
        response.send(true)
        
    }
    )

})

app.post('/update', urlEncodedParser, function (requset, response) {
    var product = requset.body;
    console.log(product);

    Product.findOneAndUpdate({uuid:product.uuid},product, (err, docs) => {
        if (err) {
            console.log(err)
        }
        
        console.log('güncelleme işlemi başarılı')
        response.send(true)
            
        


    })



})

app.post('/delete', urlEncodedParser, function (requset, response) {
    var product = requset.body;
    console.log(product);

    Product.findOneAndDelete({uuid:product.uuid},(err, docs) => {
        if (err) {
            console.log(err)
        }
            console.log('silme işlemi başarılı')
            response.send(true)
            
        


    })



})

var server = app.listen(3000);
