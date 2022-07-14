import 'dart:async';

import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/pages/User/HomePage.dart';

import 'package:flutter/material.dart';



class Splash extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState


    return SplashState();
  }
}


class SplashState extends State<Splash>{



void initState(){


  super.initState();

  startTimer();
}


  startTimer() async{


    var duration = Duration(seconds: 10);



    return Timer(duration,route);



  }



  route(){


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      body: Container(









        decoration: BoxDecoration(


            image: DecorationImage(

                image: AssetImage("assets/images/intro.jpg"),


                fit: BoxFit.cover

            )
        ),


        child: Container(





          child: Column(


            crossAxisAlignment: CrossAxisAlignment.center,


            mainAxisAlignment: MainAxisAlignment.center,


            children: <Widget>[

              Text("Welcome to app that helps kenyans farmers to sell and buy farm products",style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,),
              SizedBox(height: 50,),
              Text("BUY , SELL and Reach other farmers",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Signatra"),textAlign: TextAlign.center,),







            ],
          ),


        ),

      ),
    );
  }
}