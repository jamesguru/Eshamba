import 'package:eshamba_updated/pages/Admin/Remove/removebuyer.dart';

import 'package:flutter/material.dart';

import 'pages/User/BuyerScreen.dart';

import 'pages/User/TimeLineScreen.dart';
import 'pages/Admin/Adding.dart';
import 'pages/Admin/Remove.dart';
import 'pages/Admin/View.dart';
import './pages/Admin/Add/addseller.dart';
import './pages/Admin/Add/addbuyer.dart';
import './pages/Admin/View/viewbuyer.dart';






void main() => runApp(MyApp());



class MyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(



      debugShowCheckedModeBanner: false,


      theme: ThemeData(



        dialogBackgroundColor:  Colors.deepPurple,


        cardColor: Colors.white70, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(secondary: Colors.black)



      ),


      home: AddBuyer(),

      routes: {

        TimeLine.routeName:(ctx) => TimeLine(),

        Buyer.routeName:(ctx) => Buyer(),


        Add.routeName:(ctx) => Add(),



        ViewBuyer.routeName: (ctx) => ViewBuyer(),
        AddSeller.routeName : (ctx) => AddSeller(),
        AddBuyer.routeName : (ctx) => AddBuyer(),



        RemoveBuyer.routeName : (ctx) => RemoveBuyer(),



        Remove.routeName:(ctx) => Remove(),



        View.routeName:(ctx) => View(),


      },
    );
  }
}