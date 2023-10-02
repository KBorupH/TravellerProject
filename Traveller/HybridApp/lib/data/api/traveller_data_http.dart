import 'package:traveller_app/interfaces/i_api_traveller.dart';
import 'package:http/http.dart' as http;

class TravellerDataHttp /*implements IApiTraveller*/ {
  final String _baseURL = "http://test:20/";
  final String _routeEndPoint = "/route";

  Future<List<int>> GetAllRoutes() async {
    final response = await http.get(Uri.parse(_baseURL + _routeEndPoint));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // List<ImageModel> imgMdls = (json.decode(response.body) as List)
      //     .map((i) => ImageModel.fromJson(i)).toList();

      return  [1, 2, 3];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          '[ERROR] Failed to get - response code: ${response.statusCode}');
    }
  }
}