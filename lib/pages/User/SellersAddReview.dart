import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class SellerReviewAdd extends StatefulWidget {


  final String sellerId;


  final String name;



  SellerReviewAdd({this.sellerId,this.name});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SellerReviewAddState();
  }
}



class SellerReviewAddState extends State<SellerReviewAdd>{

  final formKey = GlobalKey<FormState>();



  TextEditingController review = TextEditingController();
  TextEditingController location = TextEditingController();





  submitData() async{


    if(formKey.currentState.validate()){




      await Firestore.instance.collection("Reviews").document(widget.sellerId).collection("PersonalReviews").add({



        "name" : widget.name,


        "location" : location.text,


        "review" : review.text,

        "timestamp": DateTime.now()



      });




      location.clear();

      review.clear();


      Navigator.pop(context);



    }else{




      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Jaza Pengo zote kwanza"),));
    }



  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      backgroundColor: Colors.grey,



      appBar: AppBar( elevation: 0,title:  Text("Ongeza kumhusu",style: TextStyle(color: Colors.black,fontFamily: "Georgia",fontSize: 18),),backgroundColor: Colors.grey,),


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

                        labelText: "Andika location yako",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.person_pin,color: Colors.black,size: 40,)
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

                        labelText: "Andika kumhusu muuzaji wako huyu",



                        labelStyle: TextStyle(color: Colors.black),

                        icon: Icon(Icons.person_pin,color: Colors.black,size: 40,)
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

                          child: Text("add Review",style: TextStyle(color: Colors.white),),
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
  }
}