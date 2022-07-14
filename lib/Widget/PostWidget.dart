import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/models/user.dart';
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eshamba_updated/pages/User/CommentsPage.dart';
import 'package:timeago/timeago.dart' as tAgo;
import 'package:eshamba_updated/pages/User/profile.dart';






class Post extends StatefulWidget{

  final String postId;


  final String ownerId;

   final Timestamp timestamp;


  final dynamic likes;


  final String username;


  final  String description;


  final String location;


  final String url;



  Post({

    this.postId,

    this.ownerId,

    this.timestamp,

    this.likes,

    this.username,


    this.description,

    this.location,

    this.url

});




  factory Post.fromDocument(DocumentSnapshot documentSnapshot){



    return Post(

      postId: documentSnapshot["postId"],

      ownerId: documentSnapshot["ownerId"],


      timestamp: documentSnapshot["timestamp"],

      likes: documentSnapshot["likes"],




      username: documentSnapshot["username"],

      description: documentSnapshot["description"],


      location: documentSnapshot["location"],


      url: documentSnapshot["url"],

    );
  }



  int getTotalNumberOfLikes(likes){


    if(likes == null){



      return 0;
    }





    int counter = 0;


    likes.values.forEach((eachValue){

      if(eachValue == true){


        counter = counter + 1;
      }

    });



    return counter;
  }






  @override
  _PostState createState() => _PostState(


      postId:this.postId,

      ownerId: this.ownerId,

      timestamp: this.timestamp,

      likes:this.likes,

      username: this.username,


      description:this.description,

      location:this.location,

      url:this.url,

    likeCount:getTotalNumberOfLikes(this.likes)
  );
}



class _PostState extends State<Post>{


  final String postId;


  final String ownerId;

  final  Timestamp timestamp;


  final dynamic likes;


  final String username;


  final  String description;


  final String location;


  final String url;

  int likeCount;

  bool isLiked;

  bool showHeart= false;

  int  numberOfComment;

  final String currentOnlineUserId = currentUser?.id;



  _PostState({

    this.postId,

    this.ownerId,

    this.timestamp,

    this.likes,

    this.username,


    this.description,

    this.location,

    this.url,

    this.likeCount

  });


  void initState(){


    super.initState();

    getTotalComments();
  }





  @override
  Widget build(BuildContext context) {


    isLiked = (likes[currentOnlineUserId] == true);

    // TODO: implement build
    return Padding(


      padding: EdgeInsets.only(bottom: 12.0),

      child: Column(


        mainAxisSize: MainAxisSize.min,

        children: <Widget>[

          createPostHead(),

          url == null? Text(' '): createPostPicture(),

          createPostFooter()

      ],),
    );
  }



  createPostHead(){

    return FutureBuilder(


      future: usersReference.document(ownerId).get(),


      builder: (context,dataSnapshot){

        if(!dataSnapshot.hasData){



          return circularProgress();
        }


        User user = User.fromDocument(dataSnapshot.data);

        bool isPostOwner = currentOnlineUserId == ownerId;

        return GestureDetector(


          onTap: () => displayUserProfile(context ,userProfileId: ownerId),


          child: ListTile(

            leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(user.url),backgroundColor: Colors.grey,),


            title: Text(user.profileName,style: TextStyle(fontWeight: FontWeight.bold),),


            subtitle: Text(location,),


            trailing: isPostOwner ? IconButton(icon: Icon(Icons.more_vert,color: Colors.black,),onPressed: () => controlPostDelete(context),) : Text(""),
          ),
        );
      },
    );


  }


  getTotalComments() async{

    QuerySnapshot querySnapshot = await commentsReference.document(postId).collection("comments").getDocuments();


    setState(() {

      numberOfComment = querySnapshot.documents.length;


    });



  }

  controlPostDelete(BuildContext mContext){


    return showDialog(


        context: mContext,

        builder: (context){




          return SimpleDialog(

            title: Text("What do you want",style: TextStyle(color: Colors.white),),

            children: <Widget>[


              SimpleDialogOption(

                child: Text("Delete this post",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


                onPressed: (){


                  Navigator.pop(context);


                  removeUserPost();
                },



              ),


              SimpleDialogOption(


                child: Text("cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


                onPressed: () => Navigator.pop(context),
              )





            ],
          );
        }



    );




  }


  removeUserPost() async{

    timelineReference.document(ownerId).collection("timeLinePosts").document(postId).get().then((document){


      if(document.exists){


        document.reference.delete();
      }


    });





    postsReference.document(postId).get().then((document){


      if(document.exists){


        document.reference.delete();


      }
    });


    storageReference.child("post_$postId.jpg").delete();

    QuerySnapshot querySnapshot = await activityFeedReference.document(ownerId).collection("feedItems").where("postId", isEqualTo: postId).getDocuments();


    querySnapshot.documents.forEach((document){


      if(document.exists){

        document.reference.delete();
      }
    });


    QuerySnapshot commentQuerySnapshot = await commentsReference.document(postId).collection("comments").getDocuments();

    commentQuerySnapshot.documents.forEach((document) {

      if(document.exists){

        document.reference.delete();
      }
    });




  }

  createPostPicture(){

    return GestureDetector(

      onDoubleTap: () => controlUserLikePost(),



      child: Stack(

        alignment: Alignment.center,



        children: <Widget>[

          Container( color: Colors.grey[400], height: 300,width: double.infinity,),



          Image.network(url,height: 350,width: double.infinity,fit: BoxFit.cover,colorBlendMode: BlendMode.darken,),


          Positioned(

            left: 0,

            bottom: 50,


            right: 270,


            top: 50,


            child: Container(
              
              
              decoration: BoxDecoration(
                
                
                borderRadius: BorderRadius.circular(0.0),


                //color: Colors.black38




              ),




              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,


                crossAxisAlignment: CrossAxisAlignment.start,


                children: <Widget>[

                  GestureDetector(

                      onTap: () => controlUserLikePost(),


                      child: isLiked ? Icon(Icons.favorite,size: 40,color: Colors.pink,): Icon(Icons.favorite_border,size: 40,color: Colors.pink,)

                  ),





                  SizedBox(height: 10,),

                  Text("$likeCount approvals ", style: TextStyle(color: Colors.white, fontSize: 14),),


                  SizedBox(height: 20,),





                  GestureDetector(

                    onTap: () => displayComments(context, postId:postId ,ownerId:ownerId, url:url),




                    child: Icon(Icons.comment,size: 30,color: Colors.white,),

                  ),
                  SizedBox(height: 10,),

                  Text(" $numberOfComment comments ", style: TextStyle(color: Colors.white, fontSize: 14),),

                ],
              ),
            ),




          ),




          showHeart ? Icon(Icons.favorite,size: 150.0,color: Colors.pink,) : Text(""),


        ],
      ),
    );
  }



  removeLike(){

    bool isNotPostOwner = currentOnlineUserId != ownerId;


    if(isNotPostOwner){


      activityFeedReference.document(ownerId).collection("feedItems").document(postId).get().then((document){

        if(document.exists){


          document.reference.delete();

        }


      });
    }
  }


  addLike(){


    bool isNotPostOwner = currentOnlineUserId !=ownerId;

    if(isNotPostOwner){


      activityFeedReference.document(ownerId).collection("feedItems").document(postId).setData({

        "type" : "like",

        "username" : currentUser.profileName,

        "userId" : currentUser.id,

        "timestamp" : DateTime.now(),

        "url" :url,

        "postId" : postId,

        "userProfileImg" : currentUser.url

      });
    }
  }

  controlUserLikePost(){



    bool _liked = likes[currentOnlineUserId] == true;

    if(_liked){

      postsReference.document(postId).updateData({"likes.$currentOnlineUserId":false});

      timelineReference.document(ownerId).collection("timeLinePosts").document(postId).updateData({"likes.$currentOnlineUserId":false});





      removeLike();



      setState(() {

        likeCount = likeCount - 1;

        isLiked =false;

        likes[currentOnlineUserId] = false;


      });



    }else if(!_liked){
      postsReference.document(postId).updateData({"likes.$currentOnlineUserId":true});
      timelineReference.document(ownerId).collection("timeLinePosts").document(postId).updateData({"likes.$currentOnlineUserId":true});


      addLike();



      setState(() {


        likeCount = likeCount + 1;

        isLiked = false;

        likes[currentOnlineUserId] = true;


        showHeart = true;
      });

      
      Timer(Duration(milliseconds: 800), (){


        setState(() {

          showHeart = false;

        });

      });

    }



  }


  createPostFooter(){


    return Column(


      crossAxisAlignment: CrossAxisAlignment.start,

      mainAxisAlignment: MainAxisAlignment.start,


      children: <Widget>[

        SizedBox(height: 5,),


        Container(


          width: 300,

          child:  Text(description,style: TextStyle(fontSize: 14),),
        ),


        SizedBox(height: 5,),



        Text(tAgo.format(timestamp.toDate()),style: TextStyle(color: Colors.blueGrey),),







        Container(


          width: 300,


          child: Divider(),
        ),






      ],
    );



  }

  displayComments(context, {String postId , String ownerId, String url}){



    Navigator.push(context, MaterialPageRoute(builder: (context){



      return CommentsPage(postId : postId, postOwnerId: ownerId, postImageUrl: url);
    }));



  }


  displayUserProfile(context ,{String userProfileId}){


    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userProfileId: ownerId,)));



  }
}