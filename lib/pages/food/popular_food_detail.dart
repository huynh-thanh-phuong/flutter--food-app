import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:flutter_food_delivery/route/route_helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_column.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct( product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!
                  ),
                ),
              ),
            ),
          ),
          //icon widgets
          Positioned(
            left: Dimensions.width20,
            top: Dimensions.height45,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      if(page == "cartPage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                      Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios)
                ),
                GetBuilder<PopularProductController>(builder: (popular){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        popular.totalItems >= 1 ?
                        Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(
                              icon: Icons.circle,
                              size: Dimensions.iconSize20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
                            )
                        ) :
                        Container(),
                        popular.totalItems >= 1 ?
                        Positioned(
                            right: 3,
                            top: 3,
                            child: BigText(
                              text: popular.totalItems.toString(),
                              size: Dimensions.font12,
                              color: Colors.white,
                            ),
                        ) :
                        Container(),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          //introduction of food
          Positioned(
            left: 0,
            right: 0,
            top: Dimensions.popularImgSize - Dimensions.height20,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!,),
                  SizedBox(height: Dimensions.height20,),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20,),
                  //expandable text widget
                  Expanded(
                      child:SingleChildScrollView(
                          child: ExpandableTextWidget(text: product.description!,),
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct){
          return Container(
            height: Dimensions.pageViewTextContainer,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(Icons.remove, color: AppColors.signColor,)
                      ),
                      SizedBox(width: Dimensions.width10 / 2,),
                      BigText(text: popularProduct.inCartItem.toString()),
                      SizedBox(width: Dimensions.width10 / 2,),
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(Icons.add, color: AppColors.signColor,)
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      popularProduct.addItem(product);
                    },
                    child: BigText(
                      text: "\$${product.price!} | Save to cart",
                      color: Colors.white,
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
