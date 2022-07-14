import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';






class RemoveBuyer extends StatelessWidget{

  static const routeName = 'RemoveBuyer';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(


        appBar: AppBar(backgroundColor:Colors.white,title: Text("Remove account",style: TextStyle(color: Colors.black38,fontSize: 15,),),centerTitle: true,elevation: 0.0,),


        body: StreamBuilder(

          stream: Firestore.instance.collection("marketplace").snapshots(),


          builder: (context,snapshot){



            if(snapshot.hasData){



              return ListView.builder(


                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index){








                    DocumentSnapshot marketplace =snapshot.data.documents[index];


                    return Container(

                        child: Column(

                          children: <Widget>[


                            GestureDetector(





                              child: ListTile(





                                leading: CircleAvatar(



                                  radius: 30,






                                  backgroundImage: NetworkImage(marketplace["img"]),



                                ),


                                trailing: GestureDetector(

                                  onTap: () => marketplace.reference.delete(),


                                  child: Icon(Icons.delete,size: 30,color: Colors.red,)
                                ),



                                title: Text(marketplace["name"],style: TextStyle(fontSize: 18,fontFamily: "Gorgia",fontWeight: FontWeight.bold,color: Colors.green),),
                              ),




                            ),

                            Divider( color: Colors.grey,)

                          ],
                        )
                    );
                  });
            }else{



              return circularProgress();
            }
          },



        )
    );
  }








}