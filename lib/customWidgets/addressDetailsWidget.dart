import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screens/editAddressScreen.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/addressViewModel.dart';
import 'package:provider/provider.dart';

class AddressDetailsWidget extends StatelessWidget {
  Map<String,dynamic> address;
  AddressDetailsWidget({super.key,required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
            BoxShadow(offset: Offset(3, 3), color: kShadowColor, blurRadius: 5)
          ]
      ),
      padding:const EdgeInsets.fromLTRB(10,10,0,10),
      margin: EdgeInsets.only(bottom: 10),
      
      child: Row(
        children: [
          
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address['name'],style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp
                ),),
                kHeightInTextField,
                Text(address['phone'],style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp
                ),),
                kHeightInTextField,
                Text('${address['address1']}, ${address['address2']}',
                overflow: TextOverflow.ellipsis, 
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp
                ),),
                kHeightInTextField,
                
                Text('${address['city']}, ${address['state']}, ${address['country']}',
                overflow: TextOverflow.ellipsis, 
                style: TextStyle(
                  
                  
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp
                ),),
                
            
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(onPressed:(){
                final addressView = Provider.of<AddressViewModel>(context,listen: false);
                addressView.deleteSingleAddress(addressId: address['id'], context: context);
              },
              icon: Icon(Icons.delete),),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAddressScreen(
                  address:address
                )));
              }, icon:const Icon(Icons.edit)),
            ],
          )
        ],
      ),
    );
  }
}