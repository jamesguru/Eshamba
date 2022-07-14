import 'package:eshamba_updated/pages/Admin/Remove/removefeed.dart';
import 'package:eshamba_updated/pages/Admin/Remove/removepost.dart';
import 'package:eshamba_updated/pages/Admin/Remove/removeusers.dart';
import 'package:flutter/material.dart';

import 'package:eshamba_updated/pages/Admin/Remove/removebuyer.dart';




class Remove extends StatelessWidget{



  static const routeName ='remove';



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


            Icon(Icons.delete_forever,color: Colors.grey,size: 70,),

            Padding(


              padding: EdgeInsets.all(30),


              child: Text("Remove the product or element you want or as per required",style: TextStyle(color: Colors.grey,fontSize: 25),textAlign: TextAlign.center,),


            ),


            GestureDetector(


              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){




                return  RemovePost();
              })),

              child: Text("Remove Post",style: TextStyle(color: Colors.pink,fontFamily: "Georgia",fontSize: 25),),
            ),



            SizedBox(height: 10,),

            GestureDetector(


              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){




                return  RemoveBuyer();
              })),

              child:  Text("Remove Buyer",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),



            SizedBox(height: 20,),

            GestureDetector(


              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){




                return  RemoveUser();
              })),

              child: Text("Remove user",style: TextStyle(color: Colors.pink,fontFamily: "Georgia",fontSize: 25),),
            ),



            SizedBox(height: 10,),


            GestureDetector(


              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){




                return RemoveFeed() ;
              })),

              child: Text("Remove Feeds",style: TextStyle(color: Colors.pink,fontSize: 25),),
            ),



          ],
        ),
      ) ,
    );
  }
}