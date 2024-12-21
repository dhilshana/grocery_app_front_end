import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/addressViewModel.dart';
import 'package:grocery_app/view-model/editAddressViewModel.dart';
import 'package:provider/provider.dart';

class EditAddressScreen extends StatefulWidget {
  Map<String,dynamic> address;
  EditAddressScreen({super.key,required this.address});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {

 TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the controllers with the passed data
    nameController.text = widget.address['name'];
    phoneController.text = widget.address['phone'];
    address1Controller.text = widget.address['address1'];
    address2Controller.text = widget.address['address2'];
    cityController.text = widget.address['city'];
    stateController.text = widget.address['state'];
    countryController.text = widget.address['country'];
  }
  @override
  Widget build(BuildContext context) {

    final editAddressView = context.watch<EditAddressViewModel>();
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: kBgColor,
      ),
      backgroundColor: kBgColor,
      body: Padding(padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Name',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'Phone',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'First Address',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: address1Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'Second Address',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: address2Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'City',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'State',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: stateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'Country',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: countryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
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
                    onPressed: () async{
                      
                      await editAddressView.editAddressUiHandler(
                        id: widget.address['id'], 
                        context: context, 
                        name: nameController.text, 
                        phone: phoneController.text, 
                        address1: address1Controller.text, 
                        address2: address2Controller.text, 
                        city: cityController.text, 
                        state: stateController.text, 
                        country: countryController.text);
                        final addressView = Provider.of<AddressViewModel>(context,listen: false);
                        addressView.viewAddressUiHandler(context);
                    },


                    
                    child:editAddressView.isLoading?CircularProgressIndicator(color: kWhiteColor,):  Text(
                      'Submit',
                      style: TextStyle(color: kWhiteColor, fontSize: 18.sp),
                    )),
              ),
              kSizedboxHeight,
          ],
        ),
      ),),
    ));
  }
}