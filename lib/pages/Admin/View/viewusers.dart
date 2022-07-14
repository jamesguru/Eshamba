import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';





class ViewUser extends StatelessWidget {

  updateInfo(){


    Firestore.instance.collection("users").getDocuments().then((snapshot){

      snapshot.documents.first.reference.updateData({


        "blocked" : true



      });

    });


  }


  updateInfo1(){


    Firestore.instance.collection("users").getDocuments().then((snapshot){

      snapshot.documents.first.reference.updateData({


        "blocked" : false



      });

    });


  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(

        backgroundColor: Colors.white,


        appBar: AppBar(

          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("View Users", style: TextStyle(
              color: Colors.grey, fontSize: 15),),
          centerTitle: true,),


        body: StreamBuilder(

          stream: Firestore.instance.collection("users").orderBy("profileName").snapshots(),


          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(


                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot users = snapshot.data.documents[index];


                    return Container(

                        child: Column(

                          children: <Widget>[


                            GestureDetector(


                              child: ListTile(


                                subtitle:Text(users['email'],) ,


                                title:Text(users['profileName'],overflow: TextOverflow.ellipsis,),




                                leading: Container(






                                  child: Image.network(users['url'],fit: BoxFit.cover,height: 100,width: 100,),
                                ),


                                trailing: users['blocked'] == false ? GestureDetector(

                                  onTap:() =>  users.reference.updateData({

                                    "blocked": true
                                  }),

                                  child: Container(

                                    color: Colors.redAccent,

                                    height: 30,

                                    width: 100,

                                    child: Center(child: Text("block",style: TextStyle(color: Colors.white),),),
                                  ),
                                ):
                                GestureDetector(

                                  onTap:() =>  users.reference.updateData({

                                    "blocked":false
                                  }),
                                  child: Container(

                                    color: Colors.green,

                                    height: 30,

                                    width: 100,

                                    child: Center(child: Text("unblock",style: TextStyle(color: Colors.white),),),
                                  ),
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
