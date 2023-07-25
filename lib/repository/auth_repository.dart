import 'package:test/data/network/BaseApiServices.dart';
import 'package:test/data/network/NetworkApiServices.dart';
import 'package:test/res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> LoginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> SignUpApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
    } catch (e) {
      throw e;
    }
  }


  Future<dynamic> LogoutApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
    } catch (e) {
      throw e;
    }
  }
}
