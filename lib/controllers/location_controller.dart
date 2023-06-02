import 'package:flutter_food_delivery/data/repository/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService{
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _isLoading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList =[];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ["home","office", "others"];
  int _addressTypeIndex = 0;

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get isLoading => _isLoading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  Placemark get placeMark => _placemark;
  Placemark get pickPlaceMark => _pickPlacemark;

  void setMapController(GoogleMapController mapController){
    _mapController = mapController;
  }
  Future<void> updatePosition(CameraPosition position, bool formAddress) async {
    if(_updateAddressData){
      _isLoading = true;
      update();
      try{
        if(formAddress){
          _position = Position(
            longitude: position.target.latitude,
            latitude: position.target.longitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }else{
          _pickPosition = Position(
            longitude: position.target.latitude,
            latitude: position.target.longitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }
        if(_changeAddress){
          String _address = await getAddressFormGeoCode(
            LatLng(position.target.latitude, position.target.longitude),
          );
        }
      }catch (e){
        print(e);
      }
    }
  }
  Future<String> getAddressFormGeoCode(LatLng latLng) async {
    String _address = "Unknown Location Found";
    Response response = await locationRepo.getAddressFormGeoCode(latLng);
    return _address;
  }
}