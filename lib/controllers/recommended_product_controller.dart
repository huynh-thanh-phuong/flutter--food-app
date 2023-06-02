import 'package:flutter_food_delivery/data/repository/recommended_product_repo.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  //private
  bool _isLoader = false;
  //public
  bool get isLoader => _isLoader;
  Future<void> getRecommendedProductList()async{

    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      print("get product recommended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoader = true;
      update();
    }else{
      print("could not get products recommended");
    }
  }
}