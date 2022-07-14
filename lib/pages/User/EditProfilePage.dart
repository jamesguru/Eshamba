import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:eshamba_updated/models/user.dart';




class EditProfilePage extends StatefulWidget{


  final String currentOnlineUserId;

  EditProfilePage({this.currentOnlineUserId});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditProfilePageState();
  }
}


class EditProfilePageState extends State<EditProfilePage>{


  TextEditingController profileNameTextEditingController= TextEditingController();

  TextEditingController bioTextEditingController = TextEditingController();


  final _scaffoldGlobalKey= GlobalKey<ScaffoldState>();

  bool loading = false;

  User user;

  bool _biovalid=true;

  bool _profileNameProfileValid= true;


  void initState(){

    super.initState();

    getAndDisplayUserInformation();
  }

  getAndDisplayUserInformation() async{


    setState(() {
      loading =true;
    });

    DocumentSnapshot documentSnapshot = await usersReference.document(widget.currentOnlineUserId).get();

    user = User.fromDocument(documentSnapshot);

    profileNameTextEditingController.text = user.profileName;

    bioTextEditingController.text=user.bio;


    setState(() {
      loading = false;
    });


  }
  updateUserData(){


    setState(() {
      profileNameTextEditingController.text.trim().length < 3 || profileNameTextEditingController.text.isEmpty ? _profileNameProfileValid = false : _profileNameProfileValid=true;
      bioTextEditingController.text.trim().length > 150 ? _biovalid =false :_biovalid= true;

    });

    if(_biovalid && _profileNameProfileValid){

      usersReference.document(widget.currentOnlineUserId).updateData({

        "ProfileName" : profileNameTextEditingController.text,

        "bio" : bioTextEditingController.text
      });

       SnackBar successSnackBar = SnackBar(content: Text("Profile has been updated Successfully."),);


       _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);
    }


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      key: _scaffoldGlobalKey,


      appBar: AppBar(


        elevation:0,


        backgroundColor: Colors.white,


        iconTheme: IconThemeData(color: Colors.white),


        title:  Text("Edit Profile",),


        actions: <Widget>[


          IconButton(icon: Icon(Icons.done, color: Colors.deepPurple,size: 30.0,),onPressed: ()=>Navigator.pop(context),),



        ],
      ),


      body: loading ? circularProgress(): ListView(

        children: <Widget>[

          Container(

            child: Column(

              children: <Widget>[

                Padding(

                  padding: EdgeInsets.only(top: 15.0,bottom: 7.0),


                  child: CircleAvatar(

                    radius: 52.0,

                    backgroundImage: CachedNetworkImageProvider(user.url),
                  ),
                ),


                Padding(

                  padding: EdgeInsets.all(16.0),


                  child: Column(children: <Widget>[

                    createProfileNameTextFormField(),

                    createBioTextFormField(),
                  ],),
                ),



                Padding(

                    padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),


                    child: GestureDetector(

                      onTap: () => updateUserData(),

                      child: Container(

                        color: Colors.deepPurple,

                        height: 30,

                        width: 100,

                        child: Center(

                          child: Text("update",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                ),

                Padding(

                  padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),


                  child: GestureDetector(

                    onTap: () => logOut(),

                    child: Container(

                      color: Colors.redAccent,

                      height: 30,

                      width: 100,

                      child: Center(

                        child: Text("Logout",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                )
              ],
            ),


          )
        ],
      ),




    );



  }

  logOut() async{


    await gSignIn.signOut();

  }





  Column createProfileNameTextFormField(){

    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,


      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(top: 13.0),

          child: Text("Profile Name", style: TextStyle(color: Colors.grey),),



        ),


        TextFormField(


          style: TextStyle(color: Colors.black),

          controller: profileNameTextEditingController,

          decoration: InputDecoration(

            hintText: " Write your profile name here",

            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(

                color: Colors.black38,

              )
            ),

            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(

                color: Colors.black,


              ),


            ),

            hintStyle: TextStyle(color: Colors.black),

            errorText: _profileNameProfileValid? null : "Profile name is too short"
          ),
        )
      ],
    );



  }

  Column createBioTextFormField(){

    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,


      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(top: 13.0),

          child: Text("What you plant", style: TextStyle(color: Colors.grey),),



        ),


        TextFormField(


          style: TextStyle(color: Colors.blueGrey),

          controller: bioTextEditingController,

          decoration: InputDecoration(

              hintText: " Write your where about here",

              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(

                    color: Colors.grey,

                  )
              ),

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(

                  color: Colors.white,


                ),


              ),

              hintStyle: TextStyle(color: Colors.grey),

              errorText: _biovalid? null : "Bio is too long"
          ),
        )
      ],
    );



  }
}