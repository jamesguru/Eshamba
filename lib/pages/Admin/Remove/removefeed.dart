import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class RemoveFeed extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(

      backgroundColor: Colors.white,


        appBar: AppBar(

          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Remove Feeds", style: TextStyle(
              color: Colors.grey, fontSize: 25),),
          centerTitle: true,),


        body: StreamBuilder(

          stream: Firestore.instance.collection("Feed").orderBy("timestamp",descending: true).snapshots(),


          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(


                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot Feeds = snapshot.data.documents[index];


                    return Container(

                        child: Column(

                          children: <Widget>[


                            GestureDetector(


                              child: ListTile(


                                subtitle: Text(Feeds['subtitle'],overflow: TextOverflow.ellipsis,),


                                leading: Container(



                                  child: Image.network(Feeds['img1'],fit: BoxFit.cover,height: 100,width: 100,),
                                ),


                                trailing: GestureDetector(

                                    onTap: () => Feeds.reference.delete(),


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
