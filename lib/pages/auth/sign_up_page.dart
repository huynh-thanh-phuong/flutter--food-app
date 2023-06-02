import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/show_custom_loader.dart';
import 'package:flutter_food_delivery/base/show_custom_snackbar.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/models/signup_body_model.dart';
import 'package:flutter_food_delivery/route/route_helper.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_text_field..dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = [
      "f.png",
      "g.png",
    ];
    void registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if(name.isEmpty){
        showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address", title: "Email address");
      } else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid email address");
      } else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length < 6){
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      }else{
        //POST form
        SignUpBody signUpBody = SignUpBody(
          email: email,
          password: password,
          name: name,
          phone: phone,);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading
            ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //app logo
              SizedBox(height: Dimensions.screenHeight * 0.05,),
              SizedBox(
                height: Dimensions.screenHeight * 0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: Dimensions.height20 * 4,
                    backgroundImage: const AssetImage(
                      "assets/image/logo part 1.png",
                    ),
                  ),
                ),
              ),
              //email
              AppTextField(
                controller: emailController,
                hintText: "Email",
                icon: Icons.email_outlined,
              ),
              //password
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                controller: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp,
                isObscure: true,
              ),
              //name
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                controller: nameController,
                hintText: "Name",
                icon: Icons.person,
              ),
              //phone
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                controller: phoneController,
                hintText: "Phone",
                icon: Icons.phone_android_sharp,
              ),
              //button sign up
              SizedBox(height: Dimensions.height20,),
              GestureDetector(
                onTap:(){
                  registration(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign Up",
                      size: Dimensions.height30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              //
              SizedBox(height: Dimensions.height20,),
              RichText(
                  text: TextSpan(
                    text: "Have an account already ?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                        text: " Sign in now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainBlackColor,
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ]
                  ),
              ),
              SizedBox(height: Dimensions.screenHeight * 0.05,),
              RichText(
                  text: TextSpan(
                    text: "Sign up using one of the following methods",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16,
                    ),
                  )
              ),
              SizedBox(height: Dimensions.height20,),
              Wrap(
                children: List.generate(2, (index) => CircleAvatar(
                  radius: Dimensions.radius30,
                  backgroundImage: AssetImage(
                      "assets/image/${signUpImage[index]}"
                  ),
                )),
              ),
            ],
          ),
        )
            : const ShowCustomLoader();
      },),
    );

  }
}
