import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class BuyerReviewAdd extends StatefulWidget {


  final String buyerId;


  final String name;



  BuyerReviewAdd({this.buyerId,this.name});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuyerReviewAddState();
  }
}



class BuyerReviewAddState extends State<BuyerReviewAdd>{

  final formKey = GlobalKey<FormState>();



  TextEditingController review = TextEditingController();
  TextEditingController location = TextEditingController();





  submitData() async{


    if(formKey.currentState.validate()){




      await Firestore.instance.collection("Reviews").document(widget.buyerId).collection("PersonalReviews").add({



        "name" : widget.name,


        "location" : location.text,


        "review" : review.text,

        "timestamp": DateTime.now()



      });




      location.clear();

      review.clear();


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






      appBar: AppBar( elevation: 0,title:  Text("Write about your buyer",style: TextStyle(color: Colors.black,fontFamily: "Georgia",fontSize: 18),),backgroundColor: Colors.grey,),


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


                    controller: review,


                    cursorColor: Colors.black,

                    validator: (value){


                      if(value.isEmpty){

                        return "Value is empty";
                      }else{


                        return null;
                      }


                    },


                    decoration: InputDecoration(

                        labelText: "Leave honest review",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.question_answer,color: Colors.black,size: 40,)
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


                      child: Center( child: Text("Add Review",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),)
                    ),
                  ),
                )





              ],
            ),


          ),






        ],
      ),

    );
  }
}