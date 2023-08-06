import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class RecipeView extends StatefulWidget {

  String url;
  RecipeView(this.url);
 

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> controller =Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter food recipe app",style: TextStyle(color: Colors.white),),
        backgroundColor:Color(0xff213A50) ,
      ),
  body: Container(
    child: WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController){
        setState(() {
          controller.complete(webViewController);
        });
      },
    ),
  ),
    );
  }
}