import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/profileViewModel.dart';
import 'package:provider/provider.dart';

class DpWidget extends StatelessWidget {
  String name;
  String email;
  DpWidget({super.key,required this.name,required this.email});

  @override
  Widget build(BuildContext context) {

   
 
    return Container(
      padding:const EdgeInsets.only(bottom: 10),
      
      child: Row(
        children: [
          CircleAvatar(radius: 25.r,),
          kWidthinFavouriteItem,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp
              ),),
              Text(email,style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp
              ),),

            ],
          ),
          const Spacer(),
          IconButton(onPressed: (){
          final profileView =
                  Provider.of<ProfileViewModel>(context, listen: false);
              profileView.showEditProfileDialogue(context);
          }, icon:const Icon(Icons.edit))
        ],
      ),
    );
  }
}