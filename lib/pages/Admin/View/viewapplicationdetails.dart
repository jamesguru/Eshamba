import 'package:flutter/material.dart';




class ViewApplicationDetails extends StatelessWidget{


  final String name;

  final String id;

  final String phoneNumber;

  final String type;

  final String details;


  ViewApplicationDetails({this.phoneNumber,this.id,this.name,this.details,this.type});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(title: Text(name),backgroundColor: Colors.white,elevation: 0.0,),


      body: ListView(


        children: <Widget>[


          Container(

            margin: EdgeInsets.all(20),

            width: 200,


            child: Text( "Name: $name"),
          ),

          SizedBox(height: 10,),

          Container(

            margin: EdgeInsets.all(20),

            width: 200,


            child: Text( "Id number :$id"),
          ),

          SizedBox(height: 10,),

          Container(

            margin: EdgeInsets.all(20),

            width: 200,


            child: Text(" Phone number: $phoneNumber"),
          ),

          SizedBox(height: 10,),

          Container(

            margin: EdgeInsets.all(20),

            width: 200,


            child: Text('Type of Account: $type'),
          ),

          SizedBox(height: 10,),

          Container(

            margin: EdgeInsets.all(20),

            width: 250,


            child: Text(' Description: $details'),
          )





        ],
      ),



    );
  }


}