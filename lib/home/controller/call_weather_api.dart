import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/api_endpoints.dart';
import 'package:weather_app/home/model/WeatherAPIResponse.dart';

Future<WeatherApiResponse> callWeatherApi(String city) async {
  final response = await http.get(
      Uri.parse('${ApiEndpoints.baseUrl}$city&appid=${ApiEndpoints.appid}'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    return WeatherApiResponse.fromJson(jsonDecode(response.body));
  } else {
    // If the server returns an error response, throw an exception.
    throw Exception('Failed to load user');
  }
}
