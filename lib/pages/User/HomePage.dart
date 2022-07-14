import 'package:eshamba_updated/pages/User/TimeLineScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:eshamba_updated/pages/Admin/AdminMainpageScreen.dart';
import 'package:eshamba_updated/pages/User/profile.dart';
import 'BuyerScreen.dart';
import 'Notifications.dart';

import 'package:eshamba_updated/models/user.dart';


 User currentUser;


 final StorageReference storageReference = FirebaseStorage.instance.ref().child("Posts Pictures");

final postsReference = Firestore.instance.collection("userpoststest");


final usersReference = Firestore.instance.collection("users");

final messageReference = Firestore.instance.collection("messages");

final commentsReference = Firestore.instance.collection("comments");
final timelineReference =Firestore.instance.collection('timelineUsers');

final applicationReference =Firestore.instance.collection('Application');


final activityFeedReference = Firestore.instance.collection("feed");

final GoogleSignIn gSignIn = GoogleSignIn();



class HomePage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}


class HomePageState extends State<HomePage>{



  bool isSignedIn = false;
  PageController pageController;


  final _scaffoldKey =GlobalKey<ScaffoldState>();




  int getPageIndex =0;




  void initState(){



  super.initState();

  pageController =PageController();


  gSignIn.onCurrentUserChanged.listen((gSignInAccount){



    controlSignIn(gSignInAccount);
  },onError: (error){


    print(error);


  });


  gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount){


    controlSignIn(gSignInAccount);

  }).catchError((error){

    print("error");

  });
}


  controlSignIn(GoogleSignInAccount signInAccount) async{



    if(signInAccount != null){


      await saveUserInfoToFirestore();



      setState(() {

        isSignedIn = true;

      });
    }else{



      setState(() {



        isSignedIn =false;
      });
    }





  }


  saveUserInfoToFirestore() async{


    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;


    DocumentSnapshot documentSnapshot = await usersReference.document(gCurrentUser.id).get();


    if(!documentSnapshot.exists){



      usersReference.document(gCurrentUser.id).setData({


        "id": gCurrentUser.id,


        "bio": " ",


        "profileName": gCurrentUser.displayName,




        "url":gCurrentUser.photoUrl,


        "email": gCurrentUser.email,






        'blocked':false,


      });




      documentSnapshot =await usersReference.document(gCurrentUser.id).get();


    }else if(gCurrentUser.email == "jameskagunga15@gmail.com"){



      Navigator.push(context, MaterialPageRoute(builder: (context){




        return AdminMainPageScreen();
      }));




    }



    currentUser = User.fromDocument(documentSnapshot);


    if(currentUser.blocked == true){


      Navigator.pop(context);

      buildSignedInScreen();

      showBlocked(context);


    }

    print(gCurrentUser.email + "email is hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");


  }


  showBlocked(mContext){

    return showDialog(


        context: mContext,
        builder: (context){


          return SimpleDialog(

            backgroundColor: Colors.red,

            title: Text(" Your account has been blocked contact Admin: ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            children: <Widget>[



              SimpleDialogOption(


                child: Text("Email : eshamba@gmail.com",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

              ),

              SimpleDialogOption(


                child: Text("You have violated terms of Eshamba",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

              )
            ],
          );
        }
    );




  }


  void loginUser(){


    gSignIn.signIn();


  }



  void logoutUser(){

  gSignIn.signOut();


  }





  Scaffold buildSignedInScreen(){




    return Scaffold(

      body: Container(


        decoration: BoxDecoration(

          gradient: LinearGradient(

              begin: Alignment.bottomRight,

              end: Alignment.topLeft,
              colors: [

                Theme.of(context).primaryColor,


                Theme.of(context).accentColor,
              ]
          ),

        ),

        alignment: Alignment.center,



        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,


          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[


            Text('E shamba',style: TextStyle(

              fontSize: 80.0,

              fontFamily: 'Signatra',


              color: Colors.white,

            ),),


            SizedBox(height: 150,),

            GestureDetector(



              onTap: loginUser,


              child: Container(


                width: 270.0,

                height: 65.0,



                decoration: BoxDecoration(


                    image: DecorationImage(




                        image: AssetImage('assets/images/google_signin_button.png'),

                        fit: BoxFit.cover
                    )
                ),
              ),
            )



          ],
        ),
      ),

    );
  }








  void dispose(){


    pageController.dispose();
    super.dispose();
  }


  onTapChangePage(int pageIndex){


    pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 5), curve: Curves.bounceInOut);


  }

  whenPageChanges(int pageIndex){


    setState(() {


      this.getPageIndex = pageIndex;

    });


  }

  Scaffold buildHomePageScreen(){




    return Scaffold(


      key: _scaffoldKey,

      body: PageView(

        children: <Widget>[


          TimeLine(gCurrentUser: currentUser,),

          Buyer(),


          NotificationPage(),


          Profile(userProfileId: currentUser.id),



        ],


        controller: pageController,


        physics: NeverScrollableScrollPhysics(),

        onPageChanged: whenPageChanges,

      ),


      bottomNavigationBar: BottomNavigationBar(


          currentIndex: getPageIndex,

          onTap: onTapChangePage,

          backgroundColor: Colors.green,

          selectedItemColor: Colors.blueGrey,


          unselectedItemColor: Colors.blueGrey,

          items: [


            BottomNavigationBarItem(icon: Icon(Icons.home,size: 20,)),

            BottomNavigationBarItem(icon: Icon(Icons.search, size: 20,),),


            BottomNavigationBarItem(icon: Icon(Icons.favorite,size: 20,),),



            BottomNavigationBarItem(icon: Icon(Icons.person,size: 20,),),


          ]
      ),

    );
  }






  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    if(isSignedIn){


      return buildHomePageScreen();
    }else{



      return buildSignedInScreen();
    }

  }
}