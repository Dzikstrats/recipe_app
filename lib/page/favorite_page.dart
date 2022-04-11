import 'package:flutter/material.dart';
import 'package:recipe_app/database/dbhelper.dart';
import 'package:recipe_app/model/response_filter.dart';
import 'package:recipe_app/ui/list_meals.dart';

class FavouritePages extends StatefulWidget {
  final int indexNavigation;
  const FavouritePages({Key? key, required this.indexNavigation}) : super(key: key);

  @override
  _FavouritePagesState createState() => _FavouritePagesState();
}

class _FavouritePagesState extends State<FavouritePages> {
  int currentIndex = 0;
  String category = "Seafod";
  ResponseFilter? responseFilter;
  bool isLoading = true;
  var db = DBHelper();

  void fetchDataMeals() async {
    var data = await db.gets(category);
    setState(() {
      responseFilter = ResponseFilter(meals: data);
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement activate
    super.initState();
    fetchDataMeals();
    currentIndex = widget.indexNavigation;
  }

  @override
  Widget build(BuildContext context) {
    var listNav = [listMeals(responseFilter), listMeals(responseFilter)];
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite receipe"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: isLoading == false
        ? listNav[currentIndex]
        : CircularProgressIndicator(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Seafod"),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: "Dessert"),
        ],
        onTap: (index){
          setState(() {
            currentIndex = index;
            index == 0 ? category = "Seafood" : category = "Dessert";
          });
          fetchDataMeals();
        },
      ),
    );
  }
}


