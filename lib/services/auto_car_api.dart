import 'dart:convert';
import 'package:http/http.dart' as http;

class AutoCarApi {
  List carsListFromAPI = [];
  List carsBrandFromAPI = [];

  Future<void> fetchCars() async {
    final response = await http.get(Uri.parse(
        'https://private-anon-f3a0b5d41e-carsapi1.apiary-mock.com/cars'));
    carsListFromAPI = jsonDecode(response.body);
    final response2 = await http.get(Uri.parse(
        'https://car-data.p.rapidapi.com/cars/makes?rapidapi-key=566cd9d51cmshb5266a816dfa9eap1a8ffdjsnb4a3303b621e'));
    carsBrandFromAPI = jsonDecode(response2.body);
    print(carsListFromAPI.length);
    print(carsBrandFromAPI.length);
    print('fetchAPI successful');
  }
}
