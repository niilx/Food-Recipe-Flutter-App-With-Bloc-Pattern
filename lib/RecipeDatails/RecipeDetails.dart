
import 'package:flutter/material.dart';
import 'package:food_recipe/ProjectResource.dart';
import 'package:food_recipe/RecipeDatails/RecipeDetailsBloc.dart';
import 'package:food_recipe/RecipeDatails/RecipeDetailsElements.dart';

class RecipeDetails extends StatefulWidget {
  String recipeId;
  RecipeDetails(this.recipeId);
  @override
  RecipeDetailsState createState() => RecipeDetailsState(this.recipeId);
}

class RecipeDetailsState extends State<RecipeDetails> {
  String recipeId;
  RecipeDetailsState(this.recipeId);
  var recipeDetailsView;
  RecipeDetailsElements recipeDetailsElements;
  RecipeDetailsBloc recipeDetailsBloc;

  dynamic recipeDetails;

  @override
  void initState() {
    recipeDetailsBloc = RecipeDetailsBloc(this);
    getData();
    super.initState();
  }

  @override
  void dispose() {
    recipeDetailsBloc.dispose();
    super.dispose();
  }

  getData() async{
    print(ProjectResource.currentValidUserToken);
    await recipeDetailsBloc.getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    ProjectResource.statusBar();
    ProjectResource.setScreenSize(context);
    recipeDetailsElements = RecipeDetailsElements(this);
    recipeDetailsView = recipeDetailsElements.getRecipeDetailsView();
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: recipeDetailsBloc.getStream(),
          initialData: false,
          builder: (context, snapshot) {
            print(snapshot.data);
            return SafeArea(
              child: snapshot.data? recipeDetailsView: Container(
                height: ProjectResource.screenHeight, width: ProjectResource.screenWidth,
                child: Center(child: CircularProgressIndicator(),),
              ),
            );
          }
      )
    );
  }
}
