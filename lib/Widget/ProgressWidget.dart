import 'package:flutter/material.dart';

circularProgress() {
  return Container(


    padding: EdgeInsets.only(top: 12.0),


    child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurple),) ,

    alignment: Alignment.center,
  );
}

linearProgress() {
  return Container(


    padding: EdgeInsets.only(top: 12.0),


    child:LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurple),) ,

    alignment: Alignment.center,
  );
}
