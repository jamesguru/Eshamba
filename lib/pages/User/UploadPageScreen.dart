import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshamba_updated/models/user.dart';
import 'package:eshamba_updated/pages/User/TimeLineScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as ImD;
import 'package:eshamba_updated/pages/User/HomePage.dart';
import 'package:eshamba_updated/Widget/ProgressWidget.dart';
import 'package:eshamba_updated/pages/User/PostBuyscreen.dart';


class UploadPage extends StatefulWidget{

  final User currentUser;

UploadPage({this.currentUser});

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UploadPageState();
  }
}



class UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>{


  File file;

  bool uploading = false;

  String postId = Uuid().v4();



  TextEditingController descriptionTextEditingController = TextEditingController();

  TextEditingController locationTextEditingController = TextEditingController();




  captureImageWithCamera() async{


    Navigator.of(context).pop();

    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 680,maxWidth: 970);


    setState(() {


      setState(() {


        this.file = imageFile;


      });

    });

  }

  pickImageFromGallery() async{


    Navigator.of(context).pop();

    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);


    setState(() {


      setState(() {


        this.file = imageFile;

      });
    });

  }

  takePicture(mContext){


    return showDialog(
        context: mContext,
    builder: (context){


          return SimpleDialog(

              title: Text(" New Post",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            children: <Widget>[


              SimpleDialogOption(


                child: Text("take a picture with camera",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


                onPressed: captureImageWithCamera,
              ),


              SimpleDialogOption(


                child: Text("take picture on your gallery",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


                onPressed: pickImageFromGallery,
              ),


              SimpleDialogOption(


                child: Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        }
        );
  }

  displayUploadScreen(){



    return Container(

      color: Colors.blueGrey,

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,


        children: <Widget>[


          Icon(Icons.add_a_photo,color: Colors.white, size: 200,),


          Padding(

              padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),


              child: GestureDetector(

                onTap: () => takePicture(context),

                child: Container(

                  color: Colors.redAccent,

                  height: 30,

                  width: 100,

                  child: Center(

                    child: Text("Sell",style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
          ),

         Padding(


           padding: EdgeInsets.all(10),


           child: GestureDetector(

             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){


               return PostBuyScreen( ownerId: widget.currentUser.id,username: widget.currentUser.profileName, userUrl: widget.currentUser.url,userId: widget.currentUser.id,);

             })),


             child: Container(

               color: Colors.green,

               height: 30,

               width: 100,

               child: Center(

                 child: Text("Buy",style: TextStyle(color: Colors.white),),
               ),
             ),
           ),
         )
        ],

      ),

    );
  }


  removeImage(){
    setState(() {
      locationTextEditingController.clear();
      descriptionTextEditingController.clear();
      file = null;
    });
  }
  getCurrentUserLocation() async{


   // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


    //List<Placemark> placeMarks= await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);


    //Placemark mPlaceMark = placeMarks[0];



    //String completeAdressInfo = '${mPlaceMark.subThoroughfare}, ${mPlaceMark.thoroughfare}, ${mPlaceMark.subLocality}, ${mPlaceMark.locality},${mPlaceMark.subAdministrativeArea},${mPlaceMark.administrativeArea},${mPlaceMark.postalCode},${mPlaceMark.country}';


   // String specificAddress = '${mPlaceMark.locality},${mPlaceMark.country}';



    //locationTextEditingController.text = completeAdressInfo;



  }


  compressPhoto() async{


    final tDirectory = await getTemporaryDirectory();

    final path = tDirectory.path;


    ImD.Image mImageFile = ImD.decodeImage(file.readAsBytesSync());

    final compressedImageFile = File('$path/img_$postId.jpg')..writeAsBytesSync(ImD.encodeJpg(mImageFile,quality: 60));



    setState(() {


      file = compressedImageFile;
    });



  }




  controlUploadAndSave() async{



    setState(() {


      uploading = true;

    });


    await compressPhoto();


    String downloadUrl = await uploadPhoto(file);




    savePostInfoToFirestore(url: downloadUrl, location:locationTextEditingController.text,description: descriptionTextEditingController.text);


    locationTextEditingController.clear();

    descriptionTextEditingController.clear();

    setState(() {

      file = null;

      uploading =false;

      postId = Uuid().v4();


    });

  }


  savePostInfoToFirestore({String url , String location, String description}){


    postsReference.document(postId).setData({



      'postId' : postId,

      'ownerId' : widget.currentUser.id,

      'timestamp':DateTime.now(),

      'likes' :{},

      'username':widget.currentUser.profileName,

      'description' : description,

      'location' : location,

      'url' : url,
    });


    timelineReference.document(widget.currentUser.id).collection('timeLinePosts').document(postId).setData({



      'postId' : postId,

      'ownerId' : widget.currentUser.id,

      'timestamp':DateTime.now(),

      'likes' :{},

      'username':widget.currentUser.profileName,

      'description' : description,

      'location' : location,

      'url' : url,
    });

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return TimeLine();
    }));

  }

  Future<String> uploadPhoto(mImageFile) async{



    StorageUploadTask mStorageUploadTask = storageReference.child("post_$postId.jpg").putFile(mImageFile);


    StorageTaskSnapshot storageTaskSnapshot = await mStorageUploadTask.onComplete;

    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadUrl;

  }

  displayUploadFormScreen(){

    return Scaffold(


      appBar: AppBar(

        backgroundColor: Colors.white,

        elevation: 0,


        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: removeImage,),


        title: Text("New Post",style: TextStyle(fontSize: 24.0, color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Georgia"),),


        actions: <Widget>[


          FlatButton(

            onPressed: uploading ? null : () => controlUploadAndSave(),


            child: Text("upload/post",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 18),),
          )
        ],

      ),



      body: ListView(


        children: <Widget>[



          uploading ? linearProgress() : Text(""),


          Container(

            width: MediaQuery.of(context).size.width * 0.8,

            height: 230,

            child: Center(



              child: AspectRatio(





                aspectRatio: 16/9,



                child: Container(


                  decoration: BoxDecoration(

                    image: DecorationImage(


                      image: FileImage(file),fit: BoxFit.cover



                    )
                  ),
                ),
              ),
            ),
          ),


          Padding(

            padding: EdgeInsets.only(top: 12.0),

          ),
          ListTile(

            leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.currentUser.url),),


            title: Container(

              width: 250.0,

              child: TextField(


                style: TextStyle(color: Colors.black),


                cursorColor: Colors.black,


                controller: descriptionTextEditingController,

                decoration: InputDecoration(

                  hintText: "Describe what you are selling/ leave contact",

                  hintStyle: TextStyle( color: Colors.black),

                  border: InputBorder.none
                ),


              ),
            ),
          ),

          Divider(),


          ListTile(

            leading: Icon(Icons.person_pin,color: Colors.black,size: 37.0,),


            title: Container(

              width: 250.0,

              child: TextField(


                style: TextStyle(color: Colors.deepPurple),


                controller: locationTextEditingController,

                decoration: InputDecoration(

                    hintText: "Write or take location",

                    hintStyle: TextStyle( color: Colors.black),

                    border: InputBorder.none
                ),


              ),
            ),
          ),


           Container(

             width: 220.0,

             height: 110.0,


             alignment: Alignment.center,
             
             

             child: RaisedButton.icon(

               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),

               onPressed: getCurrentUserLocation,
               icon: Icon(Icons.location_on,size: 30,color: Colors.white,),
               label: Text("Take location",style: TextStyle(color: Colors.white),)
               ,color: Colors.deepPurple,),
           )
        ],
      ),
    );


  }
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return file == null ?displayUploadScreen() : displayUploadFormScreen();
  }
}