import 'package:flutter_food_delivery/data/repository/auth_repo.dart';
import 'package:flutter_food_delivery/models/response_model.dart';
import 'package:flutter_food_delivery/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> login(String email, String password) async {
    authRepo.getUserToken();
    _isLoading = true;
    update();
    Response response = await authRepo.login(email,password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> saveUserNumberAndPassword(String phone, String password) async {
    authRepo.saveUserNumberAndPassword(phone, password);
  }
  bool userLogged(){
    return authRepo.userLogged();
  }
  bool clearShareData(){
    return authRepo.clearSharedData();
  }
}