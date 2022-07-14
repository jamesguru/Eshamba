import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class RemovePost extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(

      backgroundColor: Colors.white,



        appBar: AppBar(

          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text("Remove Post", style: TextStyle(
              color: Colors.black),),
          centerTitle: true,),


        body: StreamBuilder(

          stream: Firestore.instance.collection("userpoststest").orderBy("timestamp",descending: true).snapshots(),


          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(


                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot posts = snapshot.data.documents[index];


                    return Container(

                        child: Column(

                          children: <Widget>[


                            GestureDetector(


                              child: ListTile(


                                leading: Container(



                                  width: 100,

                                  height: 100,


                                  child: posts['url'] == null ?  Text(' ') : Image.network(posts['url']),
                                ),


                                subtitle: Text(posts["description"]),


                                trailing: GestureDetector(

                                    onTap: () => posts.reference.delete(),


                                    child: Icon(Icons.delete,size: 30,color: Colors.red,)
                                ),
                              ),


                            ),

                            Divider()

                          ],
                        )
                    );
                  });
            } else {
              return circularProgress();
            }
          },


        )
    );
  }


}
