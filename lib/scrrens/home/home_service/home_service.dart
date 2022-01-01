import 'package:http/http.dart' as http;

class HomeService {
  final url = 'http://10.0.2.2:3000/';
  Future<http.Response> getProductFromDb() async {
    final uri = Uri.parse(url + 'view');
    final response = await http.get(
      uri,
    );
    print(response.body);
    return response;
  }
}
