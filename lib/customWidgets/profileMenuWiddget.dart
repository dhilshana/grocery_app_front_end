import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constants.dart';

class ProfileMenuWidget extends StatelessWidget {
  String title;
  Icon icon;
  ProfileMenuWidget({super.key,required this.title,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
    
      child: Row(
        children: [
          icon,
          kWidthinFavouriteItem,
          Text(title),
          Spacer(),
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}