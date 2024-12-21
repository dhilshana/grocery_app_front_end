import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constants.dart';

class SingleAddressWidget extends StatelessWidget {
        String title;
  String value;
  SingleAddressWidget({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {

    return Container(
    
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(
            fontSize: 18
          ),),
          kHeightInTextField,
          Text(value,style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20
          ),),
        ],
      ),
    );
  }
}