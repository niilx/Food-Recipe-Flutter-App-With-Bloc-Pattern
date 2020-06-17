import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_recipe/Login/Auth.dart';
import 'package:food_recipe/ProjectResource.dart';
import 'package:food_recipe/RecipeList/RecipeList.dart';
import 'package:http/http.dart' as http;

class AuthBloc{
  LoginUserState loginUserState;
  AuthBloc(this.loginUserState);

  Future<bool> signInWithEmailAndPassword() async {

    await new Future.delayed(const Duration(seconds: 2));
    try{

      http.post(
          ProjectResource.baseUrl+"auth/login",
          headers: {"Accept": "application/json"},
          body: {"email": loginUserState.emailController.text.toString(), "password": loginUserState.passwordController.text.toString()}
      ).timeout(Duration(seconds: 30)).then((value){
        print("status code Token:${value.statusCode}");


        dynamic data=json.decode(value.body);
        print(data["response"].toString());
        if(data["response"].toString()== "success") {
          ProjectResource.currentValidUserToken = data["result"]["token"].toString();
          //  SharedPref.save("user", data);

          print(ProjectResource.currentValidUserToken);
          Navigator.push(loginUserState.context,  MaterialPageRoute(builder: (context) => RecipeList()));
          ProjectResource.showToast("Successfull Logged In", false);
        }else{
          ProjectResource.showToast("Invalid mail/password", true);
        }



      });
    }catch(e){

    }


  }

}