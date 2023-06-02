import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/no_data_page.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/route/route_helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String,int> cartItemsPerOder = {};
    for(int i = 0; i< getCartHistoryList.length; i++){
      if(cartItemsPerOder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOderToList(){
      return cartItemsPerOder.entries.map((e) => e.value).toList();
    }
    List<String> cartOderTimeToList(){
      return cartItemsPerOder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOder = cartItemsPerOderToList();

    var listCount = 0;

    Widget timeWidget(int index){
      var outPutDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCount].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outPutFormat =  DateFormat("dd/MM/yyyy hh:mm a");
        outPutDate = outPutFormat.format(inputDate);
      }
      return BigText(text: outPutDate);
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 10,
            width: double.maxFinite,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController){
            return cartController.getCartHistoryList().isNotEmpty
                ? Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for(int i = 0; i < itemsPerOder.length; i++)
                        Container(
                          height: Dimensions.height20 * 6 , //120
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCount),
                              SizedBox(height: Dimensions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOder[i], (index) {
                                      if(listCount < getCartHistoryList.length){
                                        listCount++;
                                      }
                                      return index <= 2
                                          ? Container(
                                        height: Dimensions.height20 * 4,
                                        width: Dimensions.width20 * 4,
                                        margin: EdgeInsets.only(
                                          right: Dimensions.width10 / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15 / 2
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    getCartHistoryList[listCount - 1].img!
                                            ),
                                          ),
                                        ),
                                      )
                                          : Container();
                                    }),
                                  ),
                                  Container(
                                    height: Dimensions.height20 * 4, // 80
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(
                                          text: "Total",
                                          color: AppColors.titleColor,
                                        ),
                                        BigText(
                                          text: "${itemsPerOder[i]} items",
                                          color: AppColors.titleColor,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime = cartOderTimeToList();
                                            Map<int, CartModel> moreOder = {};
                                            for(int j =0; j< getCartHistoryList.length; j++){
                                              if(getCartHistoryList[j].time == orderTime[i]){
                                                moreOder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions.width10,
                                              vertical: Dimensions.height10 / 2,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3,
                                              ),
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                            child: SmallText(
                                              text: "one more",
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
                : SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              child: const Center(
                child: NoDataPage(
                  text: "You didn't buy anything so far!",
                  imgPath:"assets/image/empty_box.png" ,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
