import 'package:eshamba_updated/pages/Admin/View/viewapplication.dart';
import 'package:eshamba_updated/pages/Admin/View/viewmarketplace.dart';
import 'package:eshamba_updated/pages/Admin/View/viewusers.dart';
import 'package:flutter/material.dart';

class View extends StatelessWidget{



  static const routeName ='view';



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


              child: Text("View the product or element you want or as per required",style: TextStyle(color: Colors.black,fontSize: 25),textAlign: TextAlign.center,),


            ),




            SizedBox(height: 10,),
            GestureDetector(



              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){



                return ViewMarketplace();
              })),



              child:  Text("View approve",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),


            SizedBox(height: 20,),


            GestureDetector(



              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){



                return ViewMarketplace();
              })),



              child: Text("View payed",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),


            SizedBox(height: 20,),


            GestureDetector(



              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){



                return ViewUser();
              })),



              child: Text("View Users",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),

            GestureDetector(



              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){



                return ViewApplication();
              })),



              child: Text("View Application",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),


          ],
        ),
      ) ,
    );
  }
}