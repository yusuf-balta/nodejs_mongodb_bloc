import 'package:nodejs_mongodb/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final url = 'http://10.0.2.2:3000/';

  Future<http.Response> addProductToDb(ProductModel productModel) async {
    final uri = Uri.parse(url + 'create');
    final response = await http.post(uri, body: productModel.toMap());
    print(response.body);
    return response;
  }

  Future<http.Response> updateProductToDb(ProductModel productModel) async {
    final uri = Uri.parse(url + 'update');
    final response = await http.post(uri, body: productModel.toMap());
    print(response.body);
    return response;
  }

  Future<http.Response> deleteProductToDb(ProductModel productModel) async {
    final uri = Uri.parse(url + 'delete');
    final response = await http.post(uri, body: productModel.toMap());
    print(response.body);
    return response;
  }
}
