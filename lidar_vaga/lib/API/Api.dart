import 'package:http/http.dart' as http;

const baseUrl = 'https://fakestoreapi.com';

class API{

  static Future getProdutos()async{
    var url = baseUrl + "/products";
    return await http.get(url);
  }

}