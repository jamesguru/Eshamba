import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';





class ViewMarketplace extends StatelessWidget {


  circularProgress() {
    return Container(


      padding: EdgeInsets.only(top: 12.0),


      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),),

      alignment: Alignment.center,
    );
  }




  Scaffold viewImage(dynamic image) {
    return Scaffold(


      body: Container(

        child: Image.network(image, fit: BoxFit.cover,),
      ),
    );
  }


  updateInfo() {
    Firestore.instance.collection("marketplace").getDocuments().then((
        snapshot) {
      snapshot.documents.first.reference.updateData({


        "approved": true
      });
    });
  }


  updateInfo1() {
    Firestore.instance.collection("marketplace").getDocuments().then((
        snapshot) {
      snapshot.documents.first.reference.updateData({


        "approved": false
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      backgroundColor: Colors.white,


        appBar: AppBar(backgroundColor: Colors.white,

            elevation: 0,
            title: Text("marketplace", style: TextStyle(
                color: Colors.blueGrey, fontSize:15),),
            centerTitle: true),


        body: StreamBuilder(

          stream: Firestore.instance.collection("marketplace").snapshots(),


          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(


                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot marketplace = snapshot.data
                        .documents[index];


                    return Container(

                        child: Column(

                          children: <Widget>[


                            GestureDetector(


                              child: ListTile(


                                leading: CircleAvatar(


                                  radius: 30,


                                  backgroundImage: NetworkImage(
                                      marketplace["img"]),


                                ),


                                trailing: marketplace['approved'] == false
                                    ? GestureDetector(

                                  onTap:() =>  marketplace.reference.updateData({

                                    "approved": true
                                  }),

                                  child: Container(

                                    color: Colors.green,

                                    height: 30,

                                    width: 100,

                                    child: Center(child: Text("approved",style: TextStyle(color: Colors.white),),),
                                  ),
                                ):
                                GestureDetector(

                                  onTap:() =>  marketplace.reference.updateData({

                                    "approved": false
                                  }),

                                  child: Container(

                                    color: Colors.redAccent,

                                    height: 30,

                                    width: 100,

                                    child: Center(child: Text('Not approved',style: TextStyle(color: Colors.white),),),
                                  ),
                                ),

                                title: Text(marketplace["name"],
                                  style: TextStyle(fontSize: 18,

                                      fontWeight: FontWeight.bold,
                                      ),),
                              ),


                            ),

                            Divider(color: Colors.grey,)

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