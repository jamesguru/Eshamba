import 'package:eshamba_updated/pages/Admin/Add/addFeeds.dart';
import 'package:flutter/material.dart';
import 'package:eshamba_updated/pages/Admin/Add/addseller.dart';
import 'package:eshamba_updated/pages/Admin/Add/addbuyer.dart';

class Add extends StatelessWidget{


  static const routeName = "Add";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      backgroundColor: Colors.white,



      body:Container(





        alignment: Alignment.center,

        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,


          children: <Widget>[




            GestureDetector(


              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){



                return AddSeller();
              })),


              child: Text("Add Seller",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),


            SizedBox(height: 20,),

            GestureDetector(


              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){



                return AddFeed();
              })),

              child:
              Text("Add Feeds",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),

            SizedBox(height: 20,),


            GestureDetector(



              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){



                return AddBuyer();
              })),



              child: Text("Add into marketplace",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),





          ],
        ),
      ) ,
    );
  }
}