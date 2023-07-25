import 'package:test/data/network/BaseApiServices.dart';
import 'package:test/data/network/NetworkApiServices.dart';
import 'package:test/model/movies_model.dart';
import 'package:test/res/app_url.dart';

class HomeRepository{
  
  BaseApiServices _apiServices = NetworkApiServices();

  Future<MoviewListModel> fetchMovieList() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response=MoviewListModel.fromJson(response);
      
    } catch (e) {
      throw e;
    }
  }
}