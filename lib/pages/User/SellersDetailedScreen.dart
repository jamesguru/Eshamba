import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eshamba_updated/pages/User/SellersAddReview.dart';
import 'package:eshamba_updated/pages/User/SellersReviewPage.dart';
import 'package:flutter/rendering.dart';
import 'package:eshamba_updated/pages/User/SellersFullCommodityScreen.dart';



class SellersDetailedScreen extends StatelessWidget{

  final String name;


  final String name2;
  
  
  final String img2;
  
  final String img3;

  final String phoneNumber;



  final String details;



  final String img;

  final String img1;

  final String sellerId;


  SellersDetailedScreen({this.phoneNumber,this.name2,this.name,this.details,this.img, this.sellerId,this.img1, this.img2,this.img3});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    return Scaffold(

      appBar: AppBar(elevation:0.0,backgroundColor : Colors.white, title: Text(name2, style: TextStyle(fontSize: 20,),overflow: TextOverflow.ellipsis,),centerTitle: true),



      body: ListView( children: <Widget>[


        Padding ( padding: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 30),
          child: Row(


          mainAxisAlignment: MainAxisAlignment.spaceBetween,


          children: <Widget>[

            CircleAvatar ( radius : 70, backgroundImage: CachedNetworkImageProvider(img),),



            Column(



              children: <Widget>[


                Padding(

                    padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),


                    child: GestureDetector(

                      onTap: () => goToReviewPage(context),

                      child: Container(

                        color: Colors.deepPurple,

                        height: 30,

                        width: 100,

                        child: Center(

                          child: Text("See other's review",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                ),


                SizedBox(height: 10,),


                Padding(

                    padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),


                    child: GestureDetector(

                      onTap: () => goToReviewAddPage(context),

                      child: Container(

                        color: Colors.deepPurple,

                        height: 30,

                        width: 100,

                        child: Center(

                          child: Text("Add your review",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                ),


                Padding(
                  padding: EdgeInsets.only(top: 10,left: 50,right: 10),


                  child: Text('Call: $phoneNumber',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),),
                ),





              ],)

          ],)
          ,),



        Padding( padding: EdgeInsets.only(top: 5, left: 40),


          child: Container(




              child: Padding( padding : EdgeInsets.all(5), child: Text(details, style: TextStyle( fontSize : 14),),)

          ),

        ),






        Padding(

          padding: EdgeInsets.only(top: 5,left: 50,bottom: 5),

          child: Text("Products", style: TextStyle(fontSize: 20),),
        ),



        Row(

          children: <Widget>[



            viewImage(img3,context,100),


            viewImage(img2,context,150),


            viewImage(img1,context,100)



          ],


        )
        

        

        
      ],),

    );
  }


  goToReviewAddPage(context){
    Navigator.push(context, MaterialPageRoute(builder: (context) {





      return SellerReviewAdd(sellerId: sellerId, name: name,);
    }));

  }


  goToReviewPage(context){

    Navigator.push(context, MaterialPageRoute(builder: (context) {





      return SellerReview(sellerId: sellerId, name: name,name2: name2,);
    }));







  }


  Container viewImage(String img, context,double length){


    return Container(


      height: 250,

      width: length,



      child: GestureDetector(


        onTap: () => Navigator.push(context, MaterialPageRoute(

          builder: (context){



            return SellersFullCommodityScreen(imgUrl: img,);

          }




        )),


          child: Image.network(img),
      ),


    );



  }
}