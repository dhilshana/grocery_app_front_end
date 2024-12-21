import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/addAddressViewModel.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adress1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Enter a new delivery address',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
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
              kHeightInTextField,
              Text(
                'Street Address 1',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: adress1Controller,
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
              kHeightInTextField,
              Text(
                'Street Address 2',
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
              kHeightInTextField,
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
              kHeightInTextField,
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
              kHeightInTextField,
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
                    onPressed: () {
                     final addaddressView = Provider.of<AddAddressViewModel>(context,listen: false);
                     addaddressView.addAddressUiHandler(
                      context: context, 
                      name: nameController.text, 
                      phone: phoneController.text, 
                      address1: adress1Controller.text, 
                      address2: address2Controller.text, 
                      city: cityController.text, 
                      state: stateController.text, 
                      country: countryController.text);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: kWhiteColor, fontSize: 18.sp),
                    )),
              ),
             
            ],
          ),
        ),
      ),
    ));
  }
}