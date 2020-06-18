
import 'dart:async';
import 'dart:convert';

import 'package:food_recipe/ProjectResource.dart';
import 'package:food_recipe/RecipeDatails/RecipeDetails.dart';
import 'package:food_recipe/RecipeList/RecipeList.dart';
import 'package:http/http.dart' as http;
class RecipeDetailsBloc{

  RecipeDetailsState recipeDetailsState;
  RecipeDetailsBloc(this.recipeDetailsState);

  bool connectionValue = false;
  dynamic recipeLists;

  StreamController<bool> connectionState = StreamController();
  StreamController<dynamic> recipeListController = StreamController();

  dispose(){
    connectionState.close();
    recipeListController.close();
  }

  Future<bool> getRecipes() async {

    try{

      http.get(
        ProjectResource.baseUrl+"recipes/"+recipeDetailsState.recipeId,
        headers: {"Accept": "application/json",
          "Authorization": "Bearer ${ProjectResource.currentValidUserToken}"},
      ).timeout(Duration(seconds: 30)).then((value){
        print("status code Token:${value.statusCode}");

        if(value.statusCode == 200) {
          recipeLists = json.decode(value.body);
          print(recipeLists["data"].toString());
         // print(recipeLists["data"][0]["title"]);
          print(value.body);
          recipeListController.sink.add(recipeLists);
          connectionValue = true;
          connectionState.sink.add(connectionValue);

        }else{
          print("ERROR");
          print(value.statusCode);
          print(value.body);
          connectionValue = false;
          ProjectResource.showToast("Something Went Wrong", true);
          connectionState.sink.add(connectionValue);
        }


      });
    }catch(e){

    }


  }

  Stream<bool> getStream(){
    return connectionState.stream;
  }

  Stream<dynamic> getStreamData(){
    return recipeListController.stream;
  }
}