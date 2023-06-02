import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/show_custom_loader.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
import 'package:flutter_food_delivery/route/route_helper.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/account_widget.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLogged();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text: "Profile",
            size: Dimensions.font26 - 2,
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn ?
        (userController.isLoading ?
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //Profile icon
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.iconSize20 * 3.75,
                size: Dimensions.height15 * 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      SizedBox(height: Dimensions.height30,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5/2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: userController.userModel.name,),
                      ),

                      //phone
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone_android_outlined,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5/2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: userController.userModel.phone,),
                      ),

                      //email
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.email_outlined,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5/2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: userController.userModel.email,),
                      ),

                      //address
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5/2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: "KP Kim Dinh, T.T Can Giuoc",),
                      ),
                      //message
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.message,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5/2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: "Alo",),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLogged()){
                            Get.find<AuthController>().clearShareData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.logout_outlined,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10 * 5/2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: "Log Out",),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ) :
        const ShowCustomLoader()) :
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Dimensions.height20 * 8,
                width: double.maxFinite,
                margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image:AssetImage("assets/image/signintocontinue.png"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getSignInPage());
                  },
                child: Container(
                  height: Dimensions.height20 * 5,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sig In Now",
                      color: Colors.white,
                      size: Dimensions.font26,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },),
    );
  }
}
