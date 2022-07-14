import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class RemoveUser extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(

        backgroundColor: Colors.white,


        appBar: AppBar(

          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Remove users", style: TextStyle(
              color: Colors.grey, fontSize: 25),),
          centerTitle: true,),


        body: StreamBuilder(

          stream: Firestore.instance.collection("users").orderBy("profileName",descending: true).snapshots(),


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




                                trailing: GestureDetector(

                                    onTap: () => users.reference.delete(),


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
