import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoolProgressIndicator extends StatelessWidget{
  bool boolean;

  BoolProgressIndicator(this.boolean);

  @override
  Widget build(BuildContext context) {
    if(boolean)
      return CircularProgressIndicator();
    return SizedBox.shrink();
  }
}