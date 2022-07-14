import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eshamba_updated/pages/User/BuyerAddReview.dart';
import 'package:eshamba_updated/pages/User/BuyerReviewPage.dart';



class BuyersDetailedScreen extends StatelessWidget{

  final String name;


  final String name2;

  final String phoneNumber;





  final String details;



  final String img;

  final String buyerId;


  BuyersDetailedScreen({this.phoneNumber,this.name2,this.name,this.details,this.img, this.buyerId});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    return Scaffold(




      appBar: AppBar(elevation: 0,backgroundColor : Colors.white, title: Text(name2, style: TextStyle(fontSize: 20,),overflow: TextOverflow.ellipsis,),centerTitle: true),



      body: ListView( children: <Widget>[


        Padding ( padding: EdgeInsets.only(top: 30,right: 10,left: 10,bottom: 30), child: Row(


          mainAxisAlignment: MainAxisAlignment.spaceBetween,


          children: <Widget>[

            CircleAvatar ( radius : 70, backgroundImage: CachedNetworkImageProvider(img),),





          ],)
          ,),


        Column(



          children: <Widget>[


            GestureDetector(


              onTap: () => goToReviewPage(context),

              child: Padding(

                padding: EdgeInsets.all(25),


                child:Container(


                  height: 30,

                  width: 100,

                  color: Colors.deepPurple,


                  child:Center(

                    child:  Text("See other's Review",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  )
                ),
              ),
            ),



            SizedBox(height: 10,),


            GestureDetector(


              onTap: () => goToReviewAddPage(context),

              child: Padding(

                padding: EdgeInsets.all(25),


                child:Container(


                  height: 30,

                  width: 100,

                  color: Colors.deepPurple,


                  child: Center(

                    child: Text("Add honest Review",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  )
                ),
              ),
            ),

          ],),


        Padding(
          padding: EdgeInsets.only(top: 10,left: 100,right: 10),


          child: Text('Call: $phoneNumber',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),),
        ),

        Padding( padding: EdgeInsets.only(top: 10, left: 40),


          child: Container(

              //decoration:  BoxDecoration( border: Border.all(color:  Colors.grey, width: 2),borderRadius: BorderRadius.circular(15)),


              child: Padding( padding : EdgeInsets.all(15), child: Text(details),)

          ),

        ),







      ],),

    );
  }


  goToReviewAddPage(context){
    Navigator.push(context, MaterialPageRoute(builder: (context) {





      return BuyerReviewAdd(buyerId: buyerId, name: name,);
    }));

  }


  goToReviewPage(context){

    Navigator.push(context, MaterialPageRoute(builder: (context) {





      return BuyerReview(buyerId: buyerId, name: name,name2: name2,);
    }));




  }




}