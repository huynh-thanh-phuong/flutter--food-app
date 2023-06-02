import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLogged;

  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(10.622197500013613, 106.66996274477285),
    zoom: 17,
  );
  late LatLng _initialPosition = const LatLng(10.622197500013613, 106.66996274477285);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLogged();

    if(_isLogged && Get.find<UserController>().userModel == null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center( child: BigText(text: "Address page",),),
      ),
      body: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          children: [
            Container(
              height: Dimensions.height20 * 7,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                left: Dimensions.width10 / 2,
                right: Dimensions.width10 / 2,
                top: Dimensions.height10 / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                border: Border.all(
                  width: Dimensions.width20 / 10,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 17,
                    ),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    onCameraIdle: (){
                      locationController.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position)=>_cameraPosition = position),
                    onMapCreated: (GoogleMapController controller){
                      locationController.setMapController(controller);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
