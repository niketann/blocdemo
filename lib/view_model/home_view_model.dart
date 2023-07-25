import 'package:flutter/cupertino.dart';
import 'package:test/data/response/api_response.dart';
import 'package:test/model/movies_model.dart';
import 'package:test/repository/home_repository.dart';

class HomeViewViewModel with  ChangeNotifier{
 final _myRepo=HomeRepository();

 ApiResponse<MoviewListModel>moviesList=ApiResponse.loading();
 setMoviesList(ApiResponse<MoviewListModel>response){
   moviesList=response;
   notifyListeners();
 }
 Future<void> fecthMovieListApi()async{
   _myRepo.fetchMovieList().then((value) {
     setMoviesList(ApiResponse.completed(value));
   }).onError((error, stackTrace) {
     setMoviesList(ApiResponse.error(error.toString()));
   });
 }
}