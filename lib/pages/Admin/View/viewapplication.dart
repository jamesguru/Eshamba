import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/pages/Admin/View/viewapplicationdetails.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;





class ViewApplication extends StatelessWidget{


  circularProgress() {
    return Container(


      padding: EdgeInsets.only(top: 12.0),


      child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),) ,

      alignment: Alignment.center,
    );
  }



  Scaffold viewImage(dynamic image){


    return Scaffold(


      body: Container(

        child: Image.network(image,fit: BoxFit.cover,),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


        appBar: AppBar(elevation: 0.0,backgroundColor:Colors.white,title: Text("Applications",style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true),


        body: StreamBuilder(

          stream: Firestore.instance.collection("Application").orderBy('timestamp',descending: true).snapshots(),


          builder: (context,snapshot){



            if(snapshot.hasData){



              return ListView.builder(


                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index){








                    DocumentSnapshot Application = snapshot.data.documents[index];


                    return Container(

                        child: Column(

                          children: <Widget>[


                            GestureDetector(


                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){




                                return ViewApplicationDetails(id: Application['id'],type:Application['type'],details: Application['description'],name: Application['name'],phoneNumber: Application['phoneNumber'],);
                              })),





                              child: ListTile(





                                leading: Text(Application['name']),

                                trailing: Text(tAgo.format(Application['timestamp'].toDate())),


                                subtitle: Text(Application['phoneNumber'],),



                                title: Text(Application["type"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),),
                              ),




                            ),


                            IconButton(icon: Icon(Icons.delete,size: 25,color: Colors.redAccent,),onPressed: () => Application.reference.delete(),),

                            Container(

                              width: 250,

                              child: Divider( color: Colors.grey,),
                            ),

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