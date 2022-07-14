
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/pages/User/ApplyScreen.dart';
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:flutter/material.dart';
import './BuyersDetailedScreen.dart';
import 'package:eshamba_updated/models/product.dart';
import './SellersDetailedScreen.dart';





class Buyer extends StatefulWidget {


  static const routeName = 'Buyer';




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuyerState();
  }
}


class BuyerState extends State<Buyer> with AutomaticKeepAliveClientMixin<Buyer>
{


  TextEditingController searchTextEditingController = TextEditingController();

  Future<QuerySnapshot> futureSearchResult;
  bool search = true;

  controlSearching(String str){

    Future<QuerySnapshot> allusers =  Firestore.instance.collection("marketplace").where("item",isEqualTo: str.toLowerCase()).getDocuments();

    setState(() {

      futureSearchResult = allusers;



    });
  }

  emptyTextFormField(){


    searchTextEditingController.clear();


  }


  AppBar searchPageHeader(){


    return AppBar(

      backgroundColor: Colors.white,


      elevation: 0,


      title: TextFormField(

        style: TextStyle( color: Colors.black),

        controller: searchTextEditingController,

        decoration: InputDecoration(

          hintText: "search/tafuta",
            hoverColor: Colors.black,


            labelStyle: TextStyle(color: Colors.black),


          hintStyle: TextStyle(color: Colors.black),

          focusColor: Colors.black,



          enabledBorder: UnderlineInputBorder(

            borderSide: BorderSide(

              color: Colors.black,




            ),


          ),


            focusedBorder: UnderlineInputBorder(

              borderSide: BorderSide(color: Colors.black),







        ),

          filled: true,

          prefixIcon: Icon(Icons.search,color: Colors.black,size: 30.0,),

          suffixIcon: IconButton(icon: Icon(Icons.clear,color: Colors.black,),onPressed: emptyTextFormField,)
        ),


        onFieldSubmitted: controlSearching,


      ),




    );


  }


  
  
 displayBuyers(){


    return Scaffold(


      backgroundColor: Colors.white,


      body:StreamBuilder(

        stream: Firestore.instance.collection("marketplace").orderBy("name").snapshots(),


        builder: (context,snapshot){



          if(snapshot.hasData){



            return ListView.builder(





                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){








                  DocumentSnapshot marketplace =snapshot.data.documents[index];


                  return GestureDetector(



                    onTap: marketplace['type'] == 'Seller'? () => Navigator.push(context, MaterialPageRoute(builder: (context){



                      return SellersDetailedScreen(phoneNumber: marketplace['phoneNumber'],name2 : marketplace['name'],name: currentUser.profileName,details: marketplace['description'],img: marketplace['img'],sellerId: marketplace['id'],img1: marketplace['img1'],img2: marketplace['img2'],img3: marketplace['img3'],);
                    })) :() => Navigator.push(context, MaterialPageRoute(builder: (context){



                      return BuyersDetailedScreen(phoneNumber: marketplace['phoneNumber'],name2 : marketplace['name'],name: currentUser.profileName,details: marketplace['description'],img: marketplace['img'],buyerId: marketplace['id']);
                    })),


                    child: Column(


                      children: <Widget>[


                        Row(


                          mainAxisAlignment: MainAxisAlignment.spaceAround,


                          children: <Widget>[




                           Container(


                             height: 100,

                             width: 100,

                             color: Colors.grey[100],


                             child: marketplace['type'] == 'Seller'?Image.network(marketplace['img2'],height: 100, width: 100,fit: BoxFit.cover,):Image.network(marketplace['img'],height: 100,width: 100,fit: BoxFit.cover,),

                           ),

                            SizedBox(width: 6,),



                            Column(



                              children: <Widget>[

                                Padding(padding: EdgeInsets.all(10),


                                  child: Text(marketplace["name"],style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),

                                ),

                                Container(

                                  padding: EdgeInsets.all(5),


                                  width: 200,


                                  child: Text(marketplace["subtitle"],style: TextStyle(color: Colors.black),),
                                ),

                                Text(marketplace['item'],style: TextStyle(color: Colors.redAccent),overflow: TextOverflow.ellipsis,),


                                Row(


                                  children: <Widget>[


                                    Container(padding: EdgeInsets.all(5), color: Colors.blueGrey, child: Text(marketplace['type'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),),),



                                    SizedBox(width: 10,),

                                    marketplace['approved'] == true ? Icon(Icons.done,size: 40,color: Colors.blueGrey,) : Text(''),



                                  ],
                                ),




                              ],


                            ),

                          ],),


                        Container(


                          width: 250,

                          child: Divider(),
                        )



                      ],
                    )

                  );




                });
          }else{



            return circularProgress();
          }
        },



      ) ,



      floatingActionButton: FloatingActionButton( backgroundColor: Colors.redAccent, child: Text("Apply",style: TextStyle(color: Colors.white),)
        ,onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context){

          return ApplyScreen();
        })),),



    );


 }


  displayFoundBuyers(){

    return FutureBuilder(

      future: futureSearchResult,

      builder: (context,dataSnapshot){

        if(!dataSnapshot.hasData){



          return circularProgress();
        }

        List<ProductResult> searchProductResult =[];

        dataSnapshot.data.documents.forEach((document){

          Product eachProduct = Product.fromDocument(document);


          print(eachProduct.item);

          print(eachProduct.id);





          ProductResult userResult = ProductResult(eachProduct);


          searchProductResult.add(userResult);
        });


        return ListView(children: searchProductResult,);
      },



    );





  }



  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      appBar: searchPageHeader(),


      body: futureSearchResult == null ? displayBuyers() : displayFoundBuyers(),
    );
  }


  
}


class ProductResult extends StatelessWidget{


  final eachProduct;

  ProductResult(this.eachProduct);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      
      padding: EdgeInsets.all(5.0),


      child: Container(


        color: Colors.white54,



        child:Column(



          children: <Widget>[


            GestureDetector(




              onTap: eachProduct.type == "Buyer"? () => Navigator.push(context, MaterialPageRoute(

                builder: (context) => BuyersDetailedScreen(details: eachProduct.description, name:currentUser.profileName , name2: eachProduct.name, buyerId: eachProduct.id, img: eachProduct.img),
              )): () => Navigator.push(context, MaterialPageRoute(

                builder: (context) => SellersDetailedScreen(img3: eachProduct.img3,img2:eachProduct.img2,img1:eachProduct.img1,details: eachProduct.description, name:currentUser.profileName , name2: eachProduct.name, sellerId: eachProduct.id, img: eachProduct.img),
              )) ,


              child: ListTile(


                leading: CircleAvatar( backgroundColor: Colors.grey, backgroundImage: CachedNetworkImageProvider(eachProduct.img),),


                title: Text(eachProduct.name,style: TextStyle(color: Colors.black,fontSize: 18.0, fontWeight: FontWeight.bold),),


                subtitle: Text(eachProduct.item,style: TextStyle(color: Colors.black,fontSize: 13.0),),


                trailing:Text(eachProduct.type,style: TextStyle(color: Colors.deepPurple,fontSize: 13.0,fontWeight: FontWeight.bold),) ,





              ),

            ),


            Container(width: 200, child: Divider(),)


          ],
        ) ,
      ),


    );


  }


  
}