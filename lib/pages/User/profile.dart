import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/Widget/PostTileWidget.dart';
import 'package:eshamba_updated/Widget/PostWidget.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:eshamba_updated/models/user.dart';
import 'package:flutter/rendering.dart';
import 'package:eshamba_updated/pages/User/EditProfilePage.dart';
import 'package:eshamba_updated/pages/User/AddMessages.dart';

class Profile extends StatefulWidget{


  final String userProfileId;



  Profile({this.userProfileId});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }

}


class ProfileState extends State<Profile>{


  final String currentOnlineUserId = currentUser?.id;

  bool loading = false;

  int countPost = 0;


  List<Post> postsLists =[];

   String postOrientation = "grid";





  void initState(){

    super.initState();

    getAllProfilePost();
  }

  createProfileTopView(){

    return FutureBuilder(

      future: usersReference.document(widget.userProfileId).get(),


      builder: (context,dataSnapshot){

        if(!dataSnapshot.hasData){

          return circularProgress();
        }


        User user = User.fromDocument(dataSnapshot.data);


        return Padding(

          padding: EdgeInsets.all(17.0),

          child: Column(children: <Widget>[


            Row(

              children: <Widget>[

                CircleAvatar(

                  radius: 40.0,


                  backgroundColor: Colors.grey,


                 backgroundImage: CachedNetworkImageProvider(user.url),
                ),

                Expanded(

                  flex: 1,

                  child: Column(

                    mainAxisSize: MainAxisSize.max,

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[


                      Padding(


                        padding: EdgeInsets.all(30.0),

                        child: Text("$countPost Posts", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey,fontSize: 20.0),),
                      ),

                      createButton()

                    ],
                  ),
                )
              ],
            ),

            Container(

              alignment: Alignment.centerLeft,


              padding: EdgeInsets.only(top: 7.0),



              child: Text(user.profileName,style: TextStyle(fontSize: 18.0),),


            ),

            Container(

              alignment: Alignment.centerLeft,


              padding: EdgeInsets.only(top: 3.0),



              child: Text(user.bio),


            ),




          ],),
        );
      },
    );


  }



  goToAddMessages(){


    Navigator.push(context, MaterialPageRoute(builder: (context) => AddMessages(ownerId: widget.userProfileId,username: currentUser.profileName,userUrl: currentUser.url,userId: currentUser.id,)));


  }




  editUserProfile(){


    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(currentOnlineUserId:currentOnlineUserId)));
  }

  createButton(){


    bool ownProfile = currentOnlineUserId == widget.userProfileId;

    if(ownProfile){

      return createButtonTitleAndFunction(title:"Edit Profile", performFunction: editUserProfile);
    }else{


      return createButtonTitleAndFunction(title: 'Send a message', performFunction: goToAddMessages );


    }


  }


  Container createButtonTitleAndFunction({String title,Function performFunction}){



    return Container(

      padding: EdgeInsets.only(top: 3.0),

      child: FlatButton(


        onPressed: performFunction,

        child: Container(
          width: 245.0,

          height: 30.0,

         child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


          alignment: Alignment.center,


          decoration: BoxDecoration(

            color: Colors.deepPurple,


            border: Border.all(color: Colors.deepPurple),

            borderRadius: BorderRadius.circular(5.0)
          ),
        ),
      ),
    );


  }



  @override
  Widget build(BuildContext context) {


    bool ownProfile = currentOnlineUserId == widget.userProfileId;



    // TODO: implement build
    return Scaffold(
      body: ListView(

        children: <Widget>[

          createProfileTopView(),

          //createListAndGridPostOrientation(),
         ownProfile?  Text("                       My Posts", style: TextStyle(fontSize: 30,fontFamily: "Signatra"),): Text('                          Posts',style: TextStyle(fontSize: 30,fontFamily: "Signatra"),),

          displayProfilePost(),




        ],
      ),
    );
  }
  displayProfilePost(){

    if(loading){

      return circularProgress();

    }else if(postsLists.isEmpty){

      return Container(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Padding(

              padding: EdgeInsets.all(20.0),

              child: Icon(Icons.photo_library,color: Colors.grey,size: 200.0,),


            ),

            Padding(

              padding: EdgeInsets.only(top: 0.0),

              child: Text("No posts", style: TextStyle(color: Colors.deepPurple,fontSize: 20.0,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      );


    }else if(postOrientation == "grid"){


      List<GridTile> gridTileList= [];
      postsLists.forEach((eachPost) {

        gridTileList.add(GridTile(child: PostTile(eachPost),));


        return GridView.count(
            crossAxisCount: 3,

          childAspectRatio: 1.0,

          mainAxisSpacing: 1.5,

          crossAxisSpacing: 1.5,

          shrinkWrap: true,

          physics: NeverScrollableScrollPhysics(),


          children: gridTileList,


        );
      });


    }else if(postOrientation == "list"){


      return Column( children: postsLists,);


    }

    return Column(



      children: postsLists,
    );


  }

  getAllProfilePost() async{

    setState(() {
      loading = true;
    });


    QuerySnapshot querySnapshot = await timelineReference.document(widget.userProfileId).collection("timeLinePosts").orderBy("timestamp",descending: true).getDocuments();


    setState(() {
      loading = false;

      countPost = querySnapshot.documents.length;

      postsLists =querySnapshot.documents.map((documentSnapshot) => Post.fromDocument(documentSnapshot)).toList();
    });


  }

  createListAndGridPostOrientation(){


    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: <Widget>[

        IconButton(
          onPressed: () => setOrientation("grid"),

          icon: Icon(Icons.grid_on),

          color: postOrientation == "grid" ? Colors.redAccent: Colors.grey,
        ),

        IconButton(
          onPressed: () => setOrientation("list"),

          icon: Icon(Icons.list),

          color: postOrientation == "list" ? Colors.redAccent: Colors.grey,
        )


      ],
    );
  }


  setOrientation(String orientation){


    setState(() {


      this.postOrientation = orientation;
    });


  }
}