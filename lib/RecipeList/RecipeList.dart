import 'package:flutter/material.dart';
import 'package:food_recipe/ProjectResource.dart';
import 'package:food_recipe/RecipeList/RecipeListElements.dart';
import 'package:food_recipe/RecipeList/RecipelistBloc.dart';

class RecipeList extends StatefulWidget {
  @override
  RecipeListState createState() => RecipeListState();
}

class RecipeListState extends State<RecipeList> {

  RecipeListElements recipeListElements;
  RecipeListBloc recipeListBloc;

  dynamic recipeLists;
  var getRecipeListView;
  TextEditingController searchCatalog = TextEditingController(text: "");


  @override
  void initState() {
    recipeListBloc = RecipeListBloc(this);
    getData();
    super.initState();
  }

  getData() async{
    print(ProjectResource.currentValidUserToken);
    await recipeListBloc.getRecipes();
  }

  @override
  void dispose() {
    recipeListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProjectResource.statusBar();
    ProjectResource.setScreenSize(context);
    recipeListElements = RecipeListElements(this);
    getRecipeListView = recipeListElements.getRecipeListView();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<bool>(
        stream: recipeListBloc.getStream(),
        initialData: false,
        builder: (context, snapshot) {
          print(snapshot.data);
          return SafeArea(
            child: snapshot.data? getRecipeListView: Container(
              height: ProjectResource.screenHeight, width: ProjectResource.screenWidth,
              child: Center(child: CircularProgressIndicator(),),
            ),
          );
        }
      )
    );
  }
}
