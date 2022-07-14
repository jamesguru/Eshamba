
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';




class PostBuyScreen extends StatefulWidget {


  final ownerId;

  final username;

  final userUrl;

  final userId;





  PostBuyScreen({this.ownerId,this.username,this.userUrl, this.userId});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostBuyScreenState();
  }
}



class PostBuyScreenState extends State<PostBuyScreen>{

  final formKey = GlobalKey<FormState>();



  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();

  final String postId =  Uuid().v4();





  submitData() async{


    if(formKey.currentState.validate()){


      await postsReference.document(postId).setData({



        'postId' : postId,

        'ownerId' : widget.userId,

        'timestamp':DateTime.now(),

        'likes' : {},

        'username':widget.username,

        'description' : description.text,

        'location' : location.text,

        'url' : null,
      });

      await timelineReference.document(widget.userId).collection('timeLinePosts').document(postId).setData({
        'postId' : postId,

        'ownerId' : widget.userId,

        'timestamp':DateTime.now(),

        'likes' : {},

        'username':widget.username,

        'description' : description.text,

        'location' : location.text,

        'url' : null,

      });
      location.clear();
      description.clear();
      Navigator.pop(context);

    }else{

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Fill the forms they are empty"),));
    }
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Colors.grey,

      appBar: AppBar( elevation: 0,title:  Text("Write your location and what you are selling",style: TextStyle(color: Colors.black,fontSize: 14),),backgroundColor: Colors.grey,),


      body: ListView(


        children: <Widget>[


          Form(

            key: formKey,
            child: Column(
              children: <Widget>[

                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: location,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration(

                        labelText: "Type your location",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.location_on,color: Colors.black,size: 40,)
                    ),
                  ),
                ),

                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: description,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },

                    decoration: InputDecoration(

                        labelText: "Write what you want to buy and include your contact for get backs",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.comment,color: Colors.black,size: 40,)
                    ),
                  ),

                ),

                Padding(

                    padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),


                    child: GestureDetector(

                      onTap: () => submitData(),

                      child: Container(

                        color: Colors.deepPurple,

                        height: 30,

                        width: 100,

                        child: Center(

                          child: Text("Post",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ],
      ),

    );
  }}
