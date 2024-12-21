import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/view-model/accountScreenViewModel.dart';
import 'package:provider/provider.dart';

class UserDetailsWidget extends StatelessWidget {
  String title;
  String value;
  UserDetailsWidget({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(bottom: 10),
      
      child: Row(
        children: [
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp
              ),),
              Text(value,style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp
              ),),

            ],
          ),
          const Spacer(),
          IconButton(onPressed: (){
          
            final accountView=  Provider.of<AccountScreenViewModel>(context,listen: false);
            accountView.showEditProfileDialogue(context);
          }, icon:const Icon(Icons.edit))
        ],
      ),
    );
  }
}