import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';




class AddMessages extends StatefulWidget {


  final ownerId;

  final username;

  final userUrl;

  final userId;







  AddMessages({this.userId,this.ownerId,this.username,this.userUrl});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddMessagesState();
  }
}



class AddMessagesState extends State<AddMessages>{

  final formKey = GlobalKey<FormState>();



  TextEditingController message = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  final String postId =  Uuid().v4();





  submitData() async{


    if(formKey.currentState.validate()){



      await messageReference.document(widget.ownerId).collection('userMessages').document(postId).setData({
        'postId' : postId,

        'timestamp':DateTime.now(),

        'username':widget.username,

        'message' : message.text,

        'phoneNumber' : phoneNumber.text,

        'url' : widget.userUrl,

        'userId' : widget.userId

      });
      phoneNumber.clear();
      message.clear();
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

                        labelText: "Type your phone number",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.phone,color: Colors.black,size: 20,)
                    ),
                  ),
                ),

                Padding(

                  padding: EdgeInsets.all(25),


                  child: TextFormField(


                    controller: message,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },

                    decoration: InputDecoration(

                        labelText: "Write your message",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.message,color: Colors.black,size: 20,)
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

                          child: Text("send",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
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
