import 'package:flutter/material.dart';




class SellersFullCommodityScreen extends StatelessWidget{


  final String imgUrl;


  SellersFullCommodityScreen({this.imgUrl});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(


      body: Stack(


        children: <Widget>[

          Image.network(imgUrl,fit: BoxFit.cover,height: double.infinity, width: double.infinity,)
        ],
      ),
    );
  }
}