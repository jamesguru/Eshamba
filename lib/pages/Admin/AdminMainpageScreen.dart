import 'package:eshamba_updated/pages/Admin/Remove.dart';

import 'package:flutter/material.dart';
import './Adding.dart';
import './View.dart';




class AdminMainPageScreen extends StatelessWidget{


  final Function logoutUser;


  AdminMainPageScreen({this.logoutUser});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(





      body: Container(





        alignment: Alignment.center,

        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,


          children: <Widget>[


            Padding(


              padding: EdgeInsets.all(30),


              child: Text("Admin Page",style: TextStyle(fontSize: 15),),

            ),

            SizedBox(height: 20,),


            GestureDetector(


              onTap: () => Navigator.of(context).pushNamed(Add.routeName),


              child: Text("Adding",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),



            SizedBox(height: 10,),




            GestureDetector(

              onTap: () => Navigator.of(context).pushNamed(Remove.routeName),

              child: Text("Removing",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),


            SizedBox(height: 20,),




          GestureDetector(

            onTap:() => Navigator.of(context).pushNamed(View.routeName),

            child: Text("View",style: TextStyle(color: Colors.pink,fontSize: 25),),
          ),


            SizedBox(height: 20,),


          ],
        ),
      )
    );
  }
}