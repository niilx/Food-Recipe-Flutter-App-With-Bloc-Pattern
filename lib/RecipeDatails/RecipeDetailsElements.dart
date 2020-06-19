
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

        IconButton(
          padding: EdgeInsets.only(right: ProjectResource.screenWidth*0.05),
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(recipeDetailsState.context);
          },
        )
        ,
        Expanded(child: Container(),),
        Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Recipe',
                    style: TextStyle(color: Colors.black,fontSize: ProjectResource.headerFontSize*1.1),
                  ),
                  TextSpan(
                    text: ' Details',
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

    String recipeName="",recipeImgUrl="",recipeId="", ingredientName="",ingredientPreparation="",ingredientquantity="", stepInfo="";
    int countGradients=0, countSteps = 0,servings = 0, totaltime =0, stepNo =0;

    List<Widget> ingradientList = List();
    List<Widget> stepsList = List();

    combineDatas(){
      //Getting Ingredients
      ingredientItem(int i){
        try{
          if(recipeDetailsState.recipeDetails["data"]["ingredients"][i]["name"]==null){
            ingredientPreparation = "-";
          }else{ingredientName = recipeDetailsState.recipeDetails["data"]["ingredients"][i]["name"];}
        }catch(e){ingredientName ="-";}

        try{
          if(recipeDetailsState.recipeDetails["data"]["ingredients"][i]["preparation"]==null){
            ingredientPreparation = "-";
          }else{ingredientPreparation = recipeDetailsState.recipeDetails["data"]["ingredients"][i]["preparation"];}
        }catch(e){ingredientPreparation ="-";}

        try{
          if(recipeDetailsState.recipeDetails["data"]["ingredients"][i]["display_quantity"]==null){
            ingredientquantity = "-";
          }else{ingredientquantity = recipeDetailsState.recipeDetails["data"]["ingredients"][i]["display_quantity"];}
        }catch(e){ingredientquantity ="-";}
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: ProjectResource.screenWidth*0.02,),  Icon(Icons.label_important,color: ProjectResource.deepOrangeColor,), SizedBox(width: 5,),
            Expanded(child: Text(ingredientquantity+" "+ingredientPreparation+" "+ingredientName+"", style: TextStyle(fontSize: ProjectResource.bodyFontSize, color: ProjectResource.fontColor),)),
          ],
        );
      }

      for(int i=0; i<recipeDetailsState.recipeDetails["data"]["ingredients"].length; i++) {
        ingradientList.add(ingredientItem(i));
      }


      //Getting Instructions
      stepItem(int i){
        try{
          if(recipeDetailsState.recipeDetails["data"]["directions"][i]["step"]==null){
            stepNo = 0;
          }else{
            stepNo = recipeDetailsState.recipeDetails["data"]["directions"][i]["step"];}
        }catch(e){stepNo =0;}

        try{
          if(recipeDetailsState.recipeDetails["data"]["directions"][i]["text"]==null){
            stepInfo = "-";
          }else{
            stepInfo = recipeDetailsState.recipeDetails["data"]["directions"][i]["text"];}
        }catch(e){stepInfo ="-";}

        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: ProjectResource.screenWidth*0.017,),
                Icon(Icons.label_important,color: ProjectResource.deepOrangeColor,),
                Text("Step "+stepNo.toString(), style: TextStyle(fontSize: ProjectResource.bodyFontSize, fontWeight: FontWeight.bold),),

              ],
            ),
            Padding(
              padding:EdgeInsets.only(left: ProjectResource.screenWidth*0.075, right: ProjectResource.screenWidth*0.05,bottom: ProjectResource.screenHeight*0.012),
              child: Text(stepInfo,style: TextStyle(color: ProjectResource.fontColor),textAlign: TextAlign.justify,),
            )

          ],
        );
      }

      for(int i=0; i<recipeDetailsState.recipeDetails["data"]["directions"].length; i++) {
        stepsList.add(stepItem(i));
      }

    }

    getRecipeInfo(){



      try{  recipeName = recipeDetailsState.recipeDetails["data"]["title"]; }  catch(e){ print(e); recipeName = "-";}
      try{  recipeImgUrl = recipeDetailsState.recipeDetails["data"]["image_url"]; } catch(e){ print(e); recipeImgUrl = "_";}
      try{  servings = recipeDetailsState.recipeDetails["data"]["servings"]; } catch(e){ print(e); recipeImgUrl = "_";}
      try{  totaltime = recipeDetailsState.recipeDetails["data"]["total_time"]; } catch(e){ print(e); recipeImgUrl = "_";}




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
                  Text(recipeName, style: TextStyle(fontSize: ProjectResource.headerFontSize*1, color: ProjectResource.darkColor,fontWeight: FontWeight.bold),)
                  ,
                  margin,
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Yeild: ',
                                style: TextStyle(color: Colors.black,fontSize: ProjectResource.headerFontSize*0.9),
                              ),
                              TextSpan(
                                text: servings.toString() +" Servings",
                                style: TextStyle(color: ProjectResource.fontColor, fontWeight: FontWeight.normal,fontSize: ProjectResource.headerFontSize*0.9),
                              ),

                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total Time: ',
                                style: TextStyle(color: Colors.black,fontSize: ProjectResource.headerFontSize*0.9),
                              ),
                              TextSpan(
                                text:totaltime.toString()+" mins",
                                style: TextStyle(color: ProjectResource.fontColor, fontWeight: FontWeight.normal,fontSize: ProjectResource.headerFontSize*0.9),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  margin,
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Ingredients",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ProjectResource.headerFontSize),)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ingradientList,
                  ),
                  margin,
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Instruction",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ProjectResource.headerFontSize),)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: stepsList,
                  ),
                  margin,
                  margin







                ],
              ),
            )
          ),
        );
    }


    return StreamBuilder<dynamic>(
        stream: recipeDetailsState.recipeDetailsBloc.getStreamData(),
        builder: (context, snapshot) {
          recipeDetailsState.recipeDetails = snapshot.data;
         if(recipeDetailsState.recipeDetails==null){}else {
           combineDatas();
         }
          return
            ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                getRecipeInfo()

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