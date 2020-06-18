
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/ProjectResource.dart';
import 'package:food_recipe/RecipeDatails/RecipeDetails.dart';
import 'package:food_recipe/RecipeList/RecipeList.dart';

class RecipeListElements{
  RecipeListState recipeListState;
  RecipeListElements(this.recipeListState);

  var margin = SizedBox(height: ProjectResource.screenHeight*0.01,);





  getHeaderSection(){
    return Row(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Food',
                    style: TextStyle(color: Colors.black,fontSize: ProjectResource.headerFontSize*1.1),
                  ),
                  TextSpan(
                    text: '\nRecipes',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: ProjectResource.headerFontSize*1.2),
                  ),

                ],
              ),
            )

        ),
        Expanded(child: Container(),),
        IconButton(
          icon: Icon(Icons.notifications,color: ProjectResource.deepOrangeColor,),
          onPressed: (){
            ProjectResource.showToast("Development In Progresss...", false);
          },
        )
      ],
    );
  }



  getSearchSection() {

    return Container(
      // margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(70),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: recipeListState.searchCatalog,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Food Recipes",
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  suffixIcon: recipeListState.searchCatalog.text.isNotEmpty? Container(
                    child: IconButton(
                      onPressed: () {
                        recipeListState.searchCatalog.clear();

                      },
                      icon: Icon(Icons.clear),
                    ),
                  ):null,
                ),

                onSubmitted: (val){
                  if(val.isNotEmpty)
                    print(val);
                  ProjectResource.showToast("Development In Progresss...", false);
                },

                enableSuggestions: true,

              ),
            ),
          ),



        ],
      ),
    );
  }



  getRecipeList(){


    getRecipeCard(int index){

      String recipeName="",recipeImgUrl="",recipeId="";
      int countGradients=0, countSteps = 0;

      try{  recipeName = recipeListState.recipeLists["data"][index]["title"]; }  catch(e){ print(e); recipeName = "-";}
      try{  recipeId= recipeListState.recipeLists["data"][index]["id"]; }  catch(e){ print(e); recipeId = "-";}
      try{  recipeImgUrl = recipeListState.recipeLists["data"][index]["image_url"]; } catch(e){ print(e); recipeImgUrl = "_";}
      try{  countGradients = recipeListState.recipeLists["data"][index]["ingredients"].length; } catch(e){ print(e); countGradients = 0;}
      try{  countSteps = recipeListState.recipeLists["data"][index]["directions"].length; } catch(e){ print(e); countSteps = 0;}


      return
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12, width: 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            splashColor: Colors.deepOrange.withOpacity(0.1),
            onTap: (){
              print("Tapped on $recipeId");
              Navigator.push(recipeListState.context,  MaterialPageRoute(builder: (context) => RecipeDetails(recipeId)));
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
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
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8),
                    child: Text(recipeName, textAlign: TextAlign.center, style: TextStyle(color: ProjectResource.darkColor,fontWeight: FontWeight.bold, fontSize: ProjectResource.bodyFontSize),),
                  ),
                  margin,
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8),
                    child: Text(countGradients.toString()+" Ingredients", textAlign: TextAlign.center, style: TextStyle(color: ProjectResource.fontColor, fontSize: ProjectResource.bodyFontSize),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(),
                      Padding(
                        padding:  EdgeInsets.only(right: ProjectResource.screenWidth*0.05),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('$countSteps',style: TextStyle(color: ProjectResource.deepOrangeColor,fontSize: ProjectResource.bodyFontSize*1.2,fontWeight: FontWeight.bold,),)
                           ,   Text(' Steps',style: TextStyle(color: ProjectResource.deepOrangeColor,fontSize: ProjectResource.bodyFontSize*1.2,fontWeight: FontWeight.bold,),)

                          ],
                        ),
                      ),

                    ],
                  ),
                  margin,




                ],
              ),
            ),
          ),
        ),
      );
    }
   // print("LenL"+ recipeListState.recipeLists.length.toString());

    return StreamBuilder<dynamic>(
      stream: recipeListState.recipeListBloc.getStreamData(),
      initialData: [0,1],
      builder: (context, snapshot) {
        recipeListState.recipeLists = snapshot.data;

        return
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.hasData && snapshot.data.toString()!=null? snapshot.data.length-2:0,
            itemBuilder: (BuildContext context, int index) {
             // print(snapshot.data[index]["title"]);
              return getRecipeCard(index);
            }
        );
      }
    );
  }


  getRecipeListView(){
    return Container(
      padding: ProjectResource.pagePadding,
      // color: ProjectResource.bodyColors,
      child: Column(
        children: <Widget>[

          Expanded(flex: 7,
            child:getHeaderSection(),
          ),

          Expanded(
            flex: 10,
            child: getSearchSection(),
          ),

//          Expanded(
//            flex: 10,
//            child:  getFilterSection(),
//          ),
          Expanded(
            flex: 80,
            child: getRecipeList(),
          )

          //getCatalogSection(),

        ],
      ),
    );
  }
}