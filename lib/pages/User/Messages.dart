import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;
import 'package:eshamba_updated/pages/User/profile.dart';





class Messages extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


        appBar: AppBar(backgroundColor: Colors.white,

            elevation: 0.0,
            title: Text("Messages", style: TextStyle(
                fontSize: 18, color: Colors.deepPurple),),
            centerTitle: true),


        body: StreamBuilder(

          stream: messageReference.document(currentUser.id).collection("userMessages").orderBy("timestamp",descending: true).limit(10).snapshots(),


          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(


                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot messages = snapshot.data
                        .documents[index];


                    return Column(


                      children: <Widget>[


                    Container(





                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight:Radius.circular(30.0),topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(0.0) ,bottomRight:Radius.circular(30.0)),color: Colors.deepPurple,),


                    width: 350,

                    child: Column(

                    children: <Widget>[


                    GestureDetector(


                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(userProfileId: messages['userId']))),


                    child: ListTile(


                    leading: CircleAvatar(


                    radius: 30,


                    backgroundImage: NetworkImage(
                    messages["url"]),


                    ),


                    subtitle: Text(messages['message'],style: TextStyle(color: Colors.white),),


                    trailing: Text(tAgo.format(messages["timestamp"].toDate()),style: TextStyle(color: Colors.white),),




                    title: Text(messages["username"],




                    style: TextStyle(

                    color: Colors.white,

                    fontWeight: FontWeight.bold,
                    ),),
                    ),


                    ),


                    Text(messages['phoneNumber'],style: TextStyle(color: Colors.white),),



                    ],
                    )
                    ),


                        Container(

                          width: 300,


                          child: Divider(),
                        )


                    ],
                    );
                  });
            } else{
              return Container(


                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.center,


                  children: <Widget>[


                    Icon(Icons.notifications_off,size: 200,color: Colors.deepPurple,),

                    SizedBox(height: 20,),


                    Text("No Messages", style: TextStyle(color: Colors.redAccent,fontSize: 30),)
                  ],
                ),
              );
            }
          },


        )
    );
  }


}
