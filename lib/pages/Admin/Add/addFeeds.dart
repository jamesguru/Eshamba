import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';



class AddFeed extends StatefulWidget{



  static const routeName = "AddFeed";


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddFeedState();
  }
}


class AddFeedState extends State<AddFeed>{



  final formKey = GlobalKey<FormState>();

  TextEditingController description = TextEditingController();
  TextEditingController subtitle = TextEditingController();

  TextEditingController id = TextEditingController();



  File image2;
  File image3;
  File image4;


  String imageUrl2;
  String imageUrl3;
  String imageUrl4;



  sendData() async{

    if(formKey.currentState.validate()){


      var storageImage1 =FirebaseStorage.instance.ref().child(image2.path);

      var task1 = storageImage1.putFile(image2);


      var imgUrl2 =await(await task1.onComplete).ref.getDownloadURL();

      var storageImage2 =FirebaseStorage.instance.ref().child(image3.path);

      var task2 = storageImage2.putFile(image3);

      var storageImage3 =FirebaseStorage.instance.ref().child(image4.path);

      var task3 = storageImage3.putFile(image4);

      var imgUrl3 =await(await task2.onComplete).ref.getDownloadURL();

      var imgUrl4 =await(await task3.onComplete).ref.getDownloadURL();

      await Firestore.instance.collection("Feed").add({




        "description": description.text,

        'approved':false,

        "subtitle" : subtitle.text,

        'img1' : imgUrl2,

        'img2': imgUrl3,

        'img3' : imgUrl4,

        'timestamp' : DateTime.now(),

        'id': id.text

      });


      description.clear();

      subtitle.clear();


      Navigator.pop(context);

    }else{


      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Fill the forms they are empty"),));



    }



  }



  Future getImage1() async{



    var img1 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {

      image2 =img1;
    });
  }


  Future getImage2() async{



    var img2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {

      image3 =img2;
    });
  }

  Future getImage3() async{



    var img3 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {

      image4 =img3;
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      backgroundColor: Colors.grey,


      appBar: AppBar(backgroundColor: Colors.grey,centerTitle: true,title: Text("Add the Seller",style: TextStyle(color: Colors.black,fontSize: 28,fontFamily: "Georgia"),),),

      body: ListView(


        children: <Widget>[


          Form(

            key: formKey,


            child: Column(


              children: <Widget>[


                Text("Select first image of the feed"),
                Padding(


                    padding: EdgeInsets.all(20),


                    child: InkWell(


                      onTap: () => getImage1(),


                      child: CircleAvatar(

                        backgroundColor: Colors.black,

                        radius: 70,


                        backgroundImage: image2 != null ? FileImage(image2) :null,
                      ),
                    )
                ),


                Text("Select second image of the feed"),


                Padding(


                    padding: EdgeInsets.all(20),


                    child: InkWell(


                      onTap: () => getImage2(),


                      child: CircleAvatar(

                        backgroundColor: Colors.black,

                        radius: 70,


                        backgroundImage: image3 != null ? FileImage(image3) :null,
                      ),
                    )
                ),

                Text("Select third image of the feed"),


                Padding(


                    padding: EdgeInsets.all(20),


                    child: InkWell(


                      onTap: () => getImage3(),


                      child: CircleAvatar(

                        backgroundColor: Colors.black,

                        radius: 70,


                        backgroundImage: image4 != null ? FileImage(image4) :null,
                      ),
                    )
                ),


                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: subtitle,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration(

                        labelText: "Write the subtitle",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.person_pin,color: Colors.green,size: 40,)
                    ),
                  ),




                ),

                Padding(

                  padding: EdgeInsets.only(left:70.0,top: 25),


                  child: TextFormField(


                    maxLines: null,


                    controller: id,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration.collapsed(

                      hintText: "Write the id of AD",
                      hintStyle: TextStyle(color: Colors.black),


                      focusColor: Colors.grey,


                      hoverColor: Colors.grey,


                      fillColor: Colors.grey,




                    ),
                  ),




                ),








                Padding(

                  padding: EdgeInsets.only(left:70.0,top: 25),


                  child: TextFormField(


                    maxLines: null,


                    controller: description,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration.collapsed(

                      hintText: "Write the description of the feeds",
                      hintStyle: TextStyle(color: Colors.black),


                      focusColor: Colors.grey,


                      hoverColor: Colors.grey,


                      fillColor: Colors.grey,


                    ),
                  ),




                ),



                Padding(

                    padding: EdgeInsets.all(25),


                    child: GestureDetector(

                      onTap: () => sendData(),

                      child: Container(

                          height: 30,

                          width: 100,

                          color: Colors.deepPurple,

                          child: Center(


                            child: Text("upload",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          )
                      ),
                    )
                )




              ],
            ),


          ),






        ],
      ),
    );
  }
}