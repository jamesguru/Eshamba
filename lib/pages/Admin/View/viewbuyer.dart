import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




class ViewBuyer extends StatelessWidget{


  circularProgress() {
    return Container(


      padding: EdgeInsets.only(top: 12.0),


      child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),) ,

      alignment: Alignment.center,
    );
  }


  static const routeName = 'ViewBuyer';



  Scaffold viewImage(dynamic image){


    return Scaffold(


      body: Container(

        child: Image.network(image,fit: BoxFit.cover,),
      ),
    );
  }


  updateInfo(){


    Firestore.instance.collection("marketplace").getDocuments().then((snapshot){

      snapshot.documents.first.reference.updateData({


        "Pay" : true



      });

    });


  }


  updateInfo1(){


    Firestore.instance.collection("marketplace").getDocuments().then((snapshot){

      snapshot.documents.first.reference.updateData({


        "Pay" : false



      });

    });


  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


        appBar: AppBar(elevation: 0.0,backgroundColor:Colors.white,title: Text("marketplace",style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true),


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


                                trailing: marketplace['Pay'] == false ? GestureDetector(

                                  onTap:() =>  marketplace.reference.updateData({

                                    "Pay": true
                                  }),

                                  child: Container(

                                    color: Colors.redAccent,

                                    height: 30,

                                    width: 100,

                                    child: Center(child: Text("NotPayed",style: TextStyle(color: Colors.white),),),
                                  ),
                                ):
                                GestureDetector(

                                  onTap:() =>  marketplace.reference.updateData({

                                    "Pay": false
                                  }),

                                  child: Container(

                                    color: Colors.green,

                                    height: 30,

                                    width: 100,

                                    child: Center(child: Text("Payed",style: TextStyle(color: Colors.white),),),
                                  ),
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