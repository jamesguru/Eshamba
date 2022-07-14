import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:timeago/timeago.dart' as tAgo;

class CommentsPage extends StatefulWidget {

  final String postId;

  final String postOwnerId;

  final String postImageUrl;



  CommentsPage({this.postId,this.postOwnerId,this.postImageUrl});


  @override
  CommentsPageState createState() => CommentsPageState(postId: postId,postOwnerId:postOwnerId,postImageUrl:postImageUrl);
}

class CommentsPageState extends State<CommentsPage> {

  final String postId;

  final String postOwnerId;

  final String postImageUrl;

  TextEditingController commentTextEditingController = TextEditingController();

  CommentsPageState({this.postId,this.postOwnerId,this.postImageUrl});
  displayComments(){


    return StreamBuilder(


      stream: commentsReference.document(postId).collection("comments").orderBy("timestamp",descending: true).snapshots(),




      builder: (context,dataSnapshot){


        if(!dataSnapshot.hasData){


          return circularProgress();
        }

        List<Comment> comments =[];

        dataSnapshot.data.documents.forEach((document){

          comments.add(Comment.fromDocument(document));
        });



        return ListView(children: comments,);


      },
    );
  }


  saveComment(){


    commentsReference.document(postId).collection("comments").add({

      "username" : currentUser.profileName,

      "comment" : commentTextEditingController.text,

      "timestamp" :DateTime.now(),

      "url" : currentUser.url,

      "userId" : currentUser.id
    });



    bool isNotPostOwnerId = postOwnerId != currentUser.id;

    print(postId);



    if(isNotPostOwnerId){


      activityFeedReference.document(postOwnerId).collection("feedItems").add({


        "type" : "comment",

        "commentData" : commentTextEditingController.text,

        "postId" : postId,


        "userId" : currentUser.id,

        "username": currentUser.profileName,

        "userProfileImg":currentUser.url,

        "url":postImageUrl,

        "timestamp" : DateTime.now(),





      });
    }




    commentTextEditingController.clear();



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.white,


      appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0, title: Text("Comments",style: TextStyle(color: Colors.black,fontSize: 18),),centerTitle: true,),

      body: Column(

        children: <Widget>[

          Expanded(child: displayComments(),),

          Divider(),

          ListTile(

            title: TextFormField(

              controller: commentTextEditingController,

              decoration: InputDecoration(

                  labelText: "write about the post",

                  labelStyle: TextStyle(color: Colors.black),

                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),

                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))
              ),

              style: TextStyle(color: Colors.black),
            ),

            trailing: GestureDetector(

              onTap: () => saveComment(),

              child: Container(


                height: 30,

                width: 100,


                color: Colors.deepPurple,

                child: Center(

                  child: Text("comment",style: TextStyle(color: Colors.white),),
                )
              ),
            )
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {


  final String username;


  final String userId;

  final String url;

  final String comment;

  final Timestamp timestamp;


  Comment({this.username,this.userId,this.url,this.comment,this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot documentSnapshot){

    return Comment(


      username:  documentSnapshot["username"],

      userId: documentSnapshot["userId"],

      url: documentSnapshot["url"],

      comment: documentSnapshot["comment"],

      timestamp: documentSnapshot["timestamp"],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: EdgeInsets.only(bottom: 10.0),

      child: Container(

        color: Colors.white,

        child: Column(


          children: <Widget>[



            ListTile(


              title: Text(username + ": " + comment ,style: TextStyle(color: Colors.black),),


              leading: CircleAvatar(

                backgroundImage: CachedNetworkImageProvider(url),

                backgroundColor: Colors.grey,


              ),


              subtitle: Text(tAgo.format(timestamp.toDate()),style: TextStyle(color: Colors.blueGrey),),



            )
          ],
        ),


      ),
    );
  }
}
