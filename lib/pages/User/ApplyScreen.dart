
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';




class ApplyScreen extends StatefulWidget {




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ApplyScreenState();
  }
}



class ApplyScreenState extends State<ApplyScreen>{

  final formKey = GlobalKey<FormState>();



  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController description = TextEditingController();


  final String postId =  Uuid().v4();





  submitData() async{


    if(formKey.currentState.validate()){



      await Firestore.instance.collection("Application").add({
        'postId' : postId,
        'timestamp':DateTime.now(),
        'name':name.text,
        'id':id.text,

        'phoneNumber': phoneNumber.text,

        'description':description.text,

        'type':type.text





      });
      name.clear();
      id.clear();
      type.clear();
      description.clear();

      phoneNumber.clear();

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

      appBar: AppBar( elevation: 0,title:  Text("Apply to be in market place",style: TextStyle(color: Colors.black,),),backgroundColor: Colors.grey,),


      body: ListView(


        children: <Widget>[


          Form(

            key: formKey,
            child: Column(
              children: <Widget>[

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

                        labelText: "Type your full name",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.person,color: Colors.black,size: 20,)
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

                        labelText: "Write id number",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.perm_identity,color: Colors.black,size: 20,)
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

                        labelText: "Write your phone number",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.phone,color: Colors.black,size: 20,)
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

                        labelText: "Write the type of account(Buyer,Seller etc)",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.perm_identity,color: Colors.black,size: 20,)
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

                        labelText: "Write little description about you",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.details,color: Colors.black,size: 20,)
                    ),
                  ),

                ),

                GestureDetector(


                  onTap: () => submitData(),

                  child: Padding(

                    padding: EdgeInsets.all(25),


                    child:Container(


                      height: 30,

                      width: 100,

                      color: Colors.deepPurple,


                      child: Center(

                        child: Text("Apply",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      )
                    ),
                  ),
                )


              ],
            ),
          ),
        ],
      ),

    );
  }}
