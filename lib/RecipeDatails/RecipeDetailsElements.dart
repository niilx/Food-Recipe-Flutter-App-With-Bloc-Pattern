
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/ProjectResource.dart';
import 'package:food_recipe/RecipeDatails/RecipeDetails.dart';

class RecipeDetailsElements{
  RecipeDetailsState recipeDetailsState;
  RecipeDetailsElements(this.recipeDetailsState);


  getHeaderSection(){
    return Row(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Recipe',
                    style: TextStyle(color: Colors.black,fontSize: ProjectResource.headerFontSize*1.1),
                  ),
                  TextSpan(
                    text: '\nDetails',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: ProjectResource.headerFontSize*1.2),
                  ),

                ],
              ),
            )

        ),
        Expanded(child: Container(),),
        IconButton(
          icon: Icon(Icons.fastfood,color: ProjectResource.deepOrangeColor,),
          onPressed: (){
            ProjectResource.showToast("Development In Progresss...", false);
          },
        )
      ],
    );
  }


  getRecipeDetails(){
    var margin = SizedBox(height: ProjectResource.screenHeight*0.03,);

    getRecipeIntro(){

      String recipeName="",recipeImgUrl="",recipeId="";
      int countGradients=0, countSteps = 0;

      try{  recipeName = recipeDetailsState.recipeDetails["data"]["title"]; }  catch(e){ print(e); recipeName = "-";}
      try{  recipeImgUrl = recipeDetailsState.recipeDetails["data"]["image_url"]; } catch(e){ print(e); recipeImgUrl = "_";}


      return
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black12.withOpacity(0.01), width: 0.5),
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                    child: CachedNetworkImage(
                      imageUrl:recipeImgUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(height: MediaQuery.of(context).size.height * 0.3, width: 50, alignment: Alignment.center, child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Image.asset(
                          "assets/noImage.jpg",
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  margin,
                  Text(recipeName, style: TextStyle(fontSize: ProjectResource.headerFontSize*0.95, color: ProjectResource.darkColor,fontWeight: FontWeight.bold),)
                  ,margin






                ],
              ),
            )
          ),
        );
    }
    // print("LenL"+ recipeListState.recipeLists.length.toString());

    return StreamBuilder<dynamic>(
        stream: recipeDetailsState.recipeDetailsBloc.getStreamData(),
        initialData: [0,1],
        builder: (context, snapshot) {
          recipeDetailsState.recipeDetails = snapshot.data;

          return
            ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                getRecipeIntro(),

              ],
            );
        }
    );
  }

  getRecipeDetailsView(){
    return Container(
      padding: ProjectResource.pagePadding,
      child: Column(
        children: <Widget>[

          Expanded(flex: 7,
            child:getHeaderSection(),
          ),

          Expanded(
            flex: 80,
            child: getRecipeDetails(),
          )

          //getCatalogSection(),

        ],
      ),
    );
  }
}