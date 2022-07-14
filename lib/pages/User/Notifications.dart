

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/pages/User/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:eshamba_updated/pages/User/PostScreen.dart';


import 'package:timeago/timeago.dart' as tAgo;

class NotificationPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotificationPageState();
  }
}


class NotificationPageState extends State<NotificationPage>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      backgroundColor: Colors.white,


      appBar: AppBar(title: Text("Notifications", style: TextStyle(color: Colors.black),),centerTitle: true,backgroundColor: Colors.white,elevation: 0.0,),



      body: Container(

        child: FutureBuilder(

          future: retrieveNotifications(),


          builder: (context, dataSnapshot){


            if(!dataSnapshot.hasData){

              return circularProgress();


            }

            return ListView( children: dataSnapshot.data,);
          },
        ),
      ),
    );
  }



  retrieveNotifications() async{


    QuerySnapshot querySnapshot = await activityFeedReference.document(currentUser.id).collection("feedItems").orderBy("timestamp",descending: true).limit(5).getDocuments();


    List<NotificationItem> notificationItems = [];


    querySnapshot.documents.forEach((document){

      notificationItems.add(NotificationItem.fromDocument(document));
    });


    return notificationItems;
  }
}



String notificationItemText;

Widget mediaPreview;


class NotificationItem extends StatelessWidget{



  final String username;
  final String type;
  final String commentData;
  final String postId;
  final String userId;
  final String userProfileImg;
  final String url;
  final Timestamp timestamp;






  NotificationItem({

    this.username,

    this.timestamp,

    this.url,

    this.postId,

    this.type,

    this.userId,

    this.commentData,

    this.userProfileImg,



});


  factory NotificationItem.fromDocument(DocumentSnapshot documentSnapshot){

    return NotificationItem(
      username: documentSnapshot['username'],

      type: documentSnapshot["type"],

      commentData: documentSnapshot["commentData"],

      postId: documentSnapshot["postId"],

      userId: documentSnapshot["userId"],

      userProfileImg: documentSnapshot["userProfileImg"],


      url: documentSnapshot["url"],

      timestamp:documentSnapshot["timestamp"]



    );
  }



  @override
  Widget build(BuildContext context) {


    configureMediaPreview(context);
    // TODO: implement build
    return Padding(


      padding: EdgeInsets.only(bottom: 5.0),


      child: Column(


        children: <Widget>[


          Container(


            color: Colors.white,


            child: ListTile(


              title: GestureDetector(


                onTap: () => displayUserProfile(context, userProfileId:userId),



                child: RichText(

                  overflow: TextOverflow.ellipsis,


                  text: TextSpan(


                      style: TextStyle(fontSize: 14.0, color: Colors.black),


                      children: [

                        TextSpan(text: username,style: TextStyle(fontWeight: FontWeight.bold)),


                        TextSpan(text: notificationItemText)
                      ]
                  ),

                ),
              ),




              subtitle: Text(tAgo.format(timestamp.toDate()),overflow: TextOverflow.ellipsis,),

              trailing: mediaPreview,
            ),


          ),


          Container(width: 250, child: Divider(),)
        ],
      ),
    );
  }


  configureMediaPreview(context){


    if(type == "comment" || type == "like"){

      mediaPreview = GestureDetector(

        //onTap: () => displayFullPost(context),

        child: Container(

          height: 50.0,

          width: 50.0,

          child: AspectRatio(aspectRatio: 16/9,


          child: Container(

            decoration: BoxDecoration(

              image: DecorationImage(fit: BoxFit.cover,image: CachedNetworkImageProvider(url))
            ),
          ),

          ),
        ),

      );
    }else{


      mediaPreview = Text(" ");
    }



    if( type == "like"){


      notificationItemText = "  approved your post";
    }


    else if( type == "comment"){


      notificationItemText = "   replied $commentData";
    }


    else{


      notificationItemText = " Error, unknown type = $type";
    }
  }


  displayFullPost(BuildContext context){

    Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreenPage(userId: userId, postId: postId,)));

  }


  displayUserProfile(BuildContext context, {String userProfileId}){
    
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userProfileId: userProfileId,)));


  }


}