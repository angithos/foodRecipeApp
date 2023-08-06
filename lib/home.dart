import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';
import 'package:flutter_application_1/recipeView.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'search.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool isLoading=true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController search_controller = new TextEditingController();
  List RecipeCatList = [
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
      "heading": "spicyfood"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
      "heading": "sweetfood"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
      "heading": "keto"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
      "heading": "vegan"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
      "heading": "vegan"
    }
  ];

//function
  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=7cc0d962&app_key=38c52b9f900cfa35d64e1ca4870efcaa";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    //debugPrint(wrapWidth: 1024,data.toString());

    //something new
    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading=false;      
      });
      //log(recipeList.toString());
    });
    recipeList.forEach((recipe) {
      print(recipe.applable);
    });
  }

  @override
  void initState() {
    getRecipe("laddoo");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff213A50), Color(0xff071938)])),
        ),
        //search  bar
        SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6.0),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((search_controller.text).replaceAll(" ", "") ==
                              "") {
                            print("Blank search");
                          } else {
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>search(search_controller.text)));
                                                      }
                        },
                        child: const Icon(Icons.search,
                            color: Colors.lightBlueAccent),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: search_controller,
                          style: const TextStyle(color: Colors.black54),
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              hintText: "what do u like to eat",
                              fillColor: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //Header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WHAT DO YOU WANT TO COOK TODAY?",
                      style: TextStyle(fontSize: 33, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lets cook something today",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                child:  isLoading ?CircularProgressIndicator():ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recipeList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //working here
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeView(recipeList[index].appurl)));
                        },
                        child: Card(
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 0.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    recipeList[index].appimgUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 250,
                                  )),
                              Positioned(
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration:
                                          BoxDecoration(color: Colors.black26),
                                      child: Text(
                                        recipeList[index].applable,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ))),
                              Positioned(
                                  right: 0,
                                  width: 80,
                                  height: 40,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10))),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              size: 23,
                                            ),
                                            SizedBox(width: 4),
                                            Text(recipeList[index]
                                                .appCalories
                                                .toString()
                                                .substring(0, 6)),
                                          ],
                                        ),
                                      )))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                    itemCount: RecipeCatList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0.0,
                              child:
                              Stack(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      RecipeCatList[index]["imgUrl"],
                                      fit: BoxFit.fill,
                                     height: 50,
                                     width: 80,
                                    ),
                                  ),
                                  Positioned(
                                      child: Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(RecipeCatList[index]
                                                    ["heading"])
                                              ],
                                            ),
                                          )
                                          )
                                          )
                                ]
                              )

                              ),
                        
                      ));
                    }),
              )
            ],
          ),
        )
      ],
    ));
  }
}
