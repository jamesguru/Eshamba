import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';



class AddBuyer extends StatefulWidget{



  static const routeName = 'AddBuyer';


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddBuyerState();
  }
}


class AddBuyerState extends State<AddBuyer>{




  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController img = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController item = TextEditingController();

  TextEditingController type = TextEditingController();

  TextEditingController phoneNumber= TextEditingController();



  File image;

  String imageUrl;


  sendData() async{

    if(formKey.currentState.validate()){


      var storageImage =FirebaseStorage.instance.ref().child(image.path);

      var task = storageImage.putFile(image);


      var imgUrl =await(await task.onComplete).ref.getDownloadURL();

      await Firestore.instance.collection("marketplace").add({

        'name' : name.text,

        'approved': false,

        "Pay":false,

        "description": description.text,

        "img":imgUrl,

        "id": id.text,

        "subtitle" : subtitle.text,

        "item" : item.text,

        "type" : type.text,

        "phoneNumber":phoneNumber.text


      });


      id.clear();

      name.clear();
      item.clear();

      description.clear();

      subtitle.clear();

      Navigator.pop(context);




    }else{


      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Fill the forms they are empty"),));



    }



  }

  Future getImage() async{



    var img = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {

      image =img;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      backgroundColor: Colors.grey,


      appBar: AppBar(elevation:0,backgroundColor: Colors.grey,centerTitle: true,title: Text("Add the Buyers",style: TextStyle(color: Colors.black,fontSize: 28,fontFamily: "Georgia"),),),

      body: ListView(


        children: <Widget>[


          Form(

            key: formKey,


            child: Column(


              children: <Widget>[


                Padding(


                    padding: EdgeInsets.all(20),


                    child: InkWell(


                      onTap: () => getImage(),


                      child: CircleAvatar(

                        backgroundColor: Colors.black,

                        radius: 70,


                        backgroundImage: image != null ? FileImage(image) :null,
                      ),
                    )
                ),


                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: name,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration(

                        labelText: "Write the name of Buyer here",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.person_pin,color: Colors.black,size: 40,)
                    ),
                  ),




                ),

                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: item,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration(

                        labelText: "Write the item here",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.details,color: Colors.black,size: 40,)
                    ),
                  ),




                ),

                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: phoneNumber,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration(

                        labelText: "Write the phone number",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.details,color: Colors.black,size: 40,)
                    ),
                  ),




                ),


                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: id,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration(

                        labelText: "Write the id no of the Buyer here",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.person_pin,color: Colors.black,size: 40,)
                    ),
                  ),




                ),



                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: type,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration(

                        labelText: "Write the type of account here",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.details,color: Colors.black,size: 40,)
                    ),
                  ),




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

                        labelText: "write subtitle or small description about Buyer",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.person_pin,color: Colors.black,size: 40,)
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

                      hintText: "Write the description of the Buyer",
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