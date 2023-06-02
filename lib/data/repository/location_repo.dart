import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  getAddressFormGeoCode(LatLng latLng) async {
    //return await apiClient.getData();
  }
}