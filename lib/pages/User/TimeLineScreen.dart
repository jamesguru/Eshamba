import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/models/user.dart';
import 'package:eshamba_updated/pages/User/Messages.dart';
import 'package:eshamba_updated/pages/User/UploadPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/Widget/PostWidget.dart';
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:eshamba_updated/pages/User/FeedsPage.dart';


class TimeLine extends StatefulWidget {



final User gCurrentUser;


TimeLine({this.gCurrentUser});


  static const routeName = 'timeline';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return TimeLineState();
  }
}


class TimeLineState extends State<TimeLine>{

  List<Post> posts;





  final _scaffoldKey =GlobalKey<ScaffoldState>();


  retrieveTimeLine() async{






    QuerySnapshot querySnapshot =await postsReference.orderBy('timestamp',descending: true).getDocuments();
    List<dynamic> allPosts =querySnapshot.documents.map((document) => Post.fromDocument(document)).toList();




    setState(() {

      print(this.posts);
      this.posts = allPosts;

      print(this.posts);
    });



  }







  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveTimeLine();


  }



  createUserTimeLine(){


    if (posts == null){


      return circularProgress();



    }else{



      return ListView(children:posts,);





    }
  }



 @override
  Widget build(BuildContext context) {
    // TODO: implement build





    return Scaffold(

      key: _scaffoldKey,



      appBar: AppBar(

        backgroundColor: Colors.white,

        elevation: 0,

        title: Text("E shamba",style: TextStyle(color: Colors.blueGrey,fontSize: 35,fontFamily: "signatra"),),



        actions: <Widget>[


          GestureDetector(

            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> Messages())),


            child: Icon(Icons.notifications_active, size: 22.5, color: Colors.deepPurple,),

          ),


          SizedBox(width: 20,),

          GestureDetector(

            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> Feed())),


            child:  Icon(Icons.near_me, size: 30.5, color: Colors.black38,),

          ),






          SizedBox(width: 10,),

        ],








      ),


      body: RefreshIndicator(child: createUserTimeLine(),onRefresh: () => retrieveTimeLine(),),


      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.deepPurple,
        child: GestureDetector(
          onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context){


            return UploadPage( currentUser: widget.gCurrentUser,);


          })) ,

          child: Icon(Icons.add_a_photo,size: 25,color: Colors.white,),
        ),
      ),
    );
  }
}