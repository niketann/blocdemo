import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/data/response/status.dart';
import 'package:test/model/movies_model.dart';
import 'package:test/res/components/round_button.dart';
import 'package:test/utlis/routes/routes_name.dart';
import 'package:test/utlis/routes/utils.dart';
import 'package:test/view_model/auth_view_model.dart';
import 'package:test/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewViewModel homeViewViewModel=HomeViewViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewViewModel.fecthMovieListApi();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          RoundButton(
              title: "Log Out",
              onPress: () {
                authViewModel.Logout(context);
                //createAccount();
                print("Logout");
              }
          ),
        ],
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          ChangeNotifierProvider<HomeViewViewModel>(
            create: (BuildContext context)=>homeViewViewModel,
            child: Consumer<HomeViewViewModel>(
                builder: (context, value, _){
                  switch(value.moviesList.status!){
                    case Status.LOADING:
                      return CircularProgressIndicator();
                    case Status.ERROR:
                      return Center(child: Text(value.moviesList.message.toString()));
                    case Status.COMPLETED:
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.moviesList.data!.movies!.length,
                          itemBuilder: (context,index){
                        return Card(
                          child: ListTile(
                            leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                                errorBuilder:(context,error,stack){
                              return Icon(Icons.error);
                                },
                            height: 40,
                            width: 50,
                              fit: BoxFit.cover,),
                            title: Text(value.moviesList.data!.movies![index].title.toString()),
                            subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(Utils.averageRating(value.moviesList.data!.movies![index].ratings!).toStringAsFixed(1)),
                                Icon(Icons.star,color: Colors.yellow,)
                              ],
                            ),
                          ),
                        );
                      });

                  }
                   return Container();
                  }),
            ),


        ],
      ),
    );
  }
}
