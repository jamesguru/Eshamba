import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/pages/User/FeedsDetailedScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timeago/timeago.dart' as tAgo;





class Feed extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


        appBar: AppBar(backgroundColor: Colors.white,

            elevation: 0.0,
            title: Text("Feeds", style: TextStyle(
                fontSize: 18, color: Colors.deepPurple),),
            centerTitle: true),


        body: StreamBuilder(

          stream: FirebaseFirestore.instance.collection("Feed").orderBy('timestamp',descending: true).snapshots(),


          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(


                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot Feeds = snapshot.data
                        .documents[index];


                    return Column(


                      children: <Widget>[




                        Row(children: <Widget>[


                          Container(

                            color: Colors.grey,

                            height: 200,

                            width: 200,


                            child: Image.network(Feeds['img1'],fit: BoxFit.cover,),


                          ),


                          Container(


                            margin: EdgeInsets.all(5),


                            width: 150,

                            height: 200,


                            child: Text(Feeds['subtitle']),
                          )


                        ],),



                       Row(


                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         
                         children: <Widget>[


                           Padding(

                             padding: EdgeInsets.all(10),

                             child: Text(tAgo.format(Feeds["timestamp"].toDate()),style: TextStyle(color: Colors.blueGrey),),
                           ),



                           GestureDetector(


                             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){

                               return FeedsDetailed(img: Feeds['img2'],img1: Feeds['img3'],img2: Feeds['img1'],details: Feeds['description'],);
                             })),




                             child:Container(

                                 margin: EdgeInsets.all(5),

                                 color: Colors.blueGrey,
                                 height: 30,

                                 width: 100,

                                 child: Center(child: Text('Read more',style: TextStyle(color: Colors.white,fontSize: 15),),)
                             ) ,
                           ),



                         ],
                       ),
                        Container(


                          width: 250,

                          child: Divider(),
                        )






                      ],
                    );



                  });
            } else{
              return circularProgress();
            }
          },


        )
    );
  }


}
