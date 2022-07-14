import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;




class BuyerReview extends StatelessWidget{


  final String buyerId;

  final String name;

  final String name2;




  BuyerReview({this.name2, this.buyerId,this.name});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(elevation: 0, backgroundColor: Colors.white,centerTitle: true,title: Text(name2,style: TextStyle(color: Colors.black,fontSize: 16),),),


      body: StreamBuilder(

        stream: Firestore.instance.collection("Reviews").document(buyerId).collection("PersonalReviews").snapshots(),


        builder: (context,snapshot){



          if(snapshot.hasData){



            return ListView.builder(


                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){








                  DocumentSnapshot Reviews =snapshot.data.documents[index];


                  return Column(


                    children: <Widget>[


                      Container(





                          //decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight:Radius.circular(0.0),topLeft: Radius.circular(0.0),bottomLeft: Radius.circular(0.0) ,bottomRight:Radius.circular(0.0)),color: Colors.grey,),


                          width: 350,

                          child: Column(

                            children: <Widget>[


                              GestureDetector(




                                child: ListTile(





                                  subtitle: Text(Reviews["review"] + '  ' + '\n' + 'Natoka upande wa : ' +  Reviews["location"],style: TextStyle(color: Colors.black),),







                                  title: Text(Reviews['name'],




                                    style: TextStyle(

                                      color: Colors.black,

                                      fontWeight: FontWeight.bold,
                                    ),),


                                  trailing: Text(tAgo.format(Reviews["timestamp"].toDate()),style: TextStyle(color: Colors.black),) ,
                                ),


                              ),






                            ],
                          )
                      ),


                      Container(

                        width: 250,

                        child:  Divider(),
                      )


                    ],
                  );
                });
          }else{



            return circularProgress();
          }
        },



      ),
    );
  }

}





