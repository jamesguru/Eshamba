import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class FeedsDetailed extends StatelessWidget{


  final String img1;

  final String img;

  final String img2;

  final String details;


  FeedsDetailed({this.img,this.img1,this.img2,this.details});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Colors.white,


      appBar: AppBar(elevation:0,centerTitle: true, title: Text("Get information",),backgroundColor: Colors.white,),


      body: ListView(




        children: <Widget>[





          Container(


            width: double.infinity,

            height: 400,

            color: Colors.grey[300],


            child: Image.network(img1,fit: BoxFit.cover,),
          ),

          SizedBox(height: 15,),


          Container(

            width: 300,


            child: Text(details),


          ),

          SizedBox(height: 15,),


          Container(


            width: double.infinity,

            height: 400,

            color: Colors.grey[300],


            child: Image.network(img2,fit: BoxFit.cover,),
          ),


          SizedBox(height: 50,),




          Container(


            width: double.infinity,

            height: 400,

            color: Colors.grey[300],


            child: Image.network(img,fit: BoxFit.cover,),
          )





        ],
      ),


    );
  }
}