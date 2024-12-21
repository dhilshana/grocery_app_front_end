import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/customWidgets/addressDetailsWidget.dart';
import 'package:grocery_app/screens/singleAddressScreen.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/addressViewModel.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
@override
void initState(){
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp){
    final addressView = Provider.of<AddressViewModel>(context,listen: false);
    addressView.viewAddressUiHandler(context);
  });
}

  @override
  Widget build(BuildContext context) {

    final addresView = context.watch<AddressViewModel>();
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title:const Text('Delivery Address'),
        backgroundColor: kBgColor,
        toolbarHeight: 80.h,
        actions: [
          TextButton(onPressed: (){
            addresView.deleteAddress(context);
          }, child: Text('Delete All',style: TextStyle(
            color: kGreenColor
          ),))
        ],
      ),
      backgroundColor: kBgColor,
      body: Padding(padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Expanded(
            child:addresView.address.length>0? ListView.builder(
              itemCount:addresView.address.length ,
              itemBuilder: (context, index) {
                
                Map<String,dynamic> address = {
                  'id':addresView.address[index].id,
                  'name':addresView.address[index].contactName,
                  'phone':addresView.address[index].phoneNumber,
                  'address1':addresView.address[index].streetAddress1,
                  'address2':addresView.address[index].streetAddress2,
                  'city':addresView.address[index].city,
                  'state':addresView.address[index].state,
                  'country':addresView.address[index].country,
                };
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleAddressScreen(address: address,)));
                  },
                  child: AddressDetailsWidget(address: address));
              },):Center(child: Text('No Address'),)
          ),
          Container(
            decoration: BoxDecoration(
                color: kGreenColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(
                        3, 3), // Positive values for bottom-right shadow
                    blurRadius: 5, // Adjust for smoothness
                    color: kShadowColor,
                    spreadRadius: 2, // Adjust for size of shadow
                  ),
                ]),
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  addresView.addAddressButtonUiHandler(context);
                },
                child:Text(
                  'Add Another Address',
                  style: TextStyle(color: kWhiteColor, fontSize: 18.sp),
                )),
          ),
        ],
      )
      ),
    ));
  }
}