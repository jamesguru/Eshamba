import 'package:eshamba_updated/pages/User/HomePage.dart';

import 'package:eshamba_updated/Widget/ProgressWidget.dart';

import 'package:eshamba_updated/Widget/PostWidget.dart';
import 'package:flutter/material.dart';

class PostScreenPage extends StatelessWidget {


  final String postId;


  final String userId;



  PostScreenPage({this.postId,this.userId});



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(


      future: timelineReference.document(userId).collection("timeLinePosts").document(postId).get(),


      builder: (context,dataSnapshot){


        if(!dataSnapshot.hasData){


          return circularProgress();
        }


        Post post = Post.fromDocument(dataSnapshot.data);


        print(post);



        return Center(

          child: Scaffold(


            appBar: AppBar(title: Text("Full post", style: TextStyle(color: Colors.grey),),),


            body: ListView(

              children: <Widget>[

                Container(

                  child: post,


                )
              ],
            ),
          ),
        );
      },

    );
  }


}
