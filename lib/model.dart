class RecipeModel
{
  late String applable;
  late String appimgUrl;
  late double appCalories;
  late String appurl;

  RecipeModel({this.applable="", this.appimgUrl="image", this.appCalories=0.00,this.appurl="url"});
  
   
  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
      applable: recipe["label"],
      appimgUrl: recipe["image"],
      appurl: recipe["url"],
      appCalories: recipe["calories"]
    );
  }
}