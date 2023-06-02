import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  //private
  bool _isLoader = false;
  //public
  bool get isLoader => _isLoader;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItem = 0;
  int get inCartItem => _inCartItem + _quantity;

  Future<void> getPopularProductList()async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoader = true;
      update();
    }else{
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity + 1);
    }else{
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity){

    if((_inCartItem + quantity) < 0){
      Get.snackbar("Item count", "You can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItem > 0){
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    }else if((_inCartItem + quantity) > 20){
      Get.snackbar("Item count", "You can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cart){
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //get from storage _inCartItems =
    if(exist){
      _inCartItem = _cart.getQuantity(product);
    }
  }
  void addItem(ProductModel product, ){
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItem = _cart.getQuantity(product);

    update();
  }
  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel>get getItems{
    return _cart.getItems;
  }
}