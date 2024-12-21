import 'package:flutter/material.dart';
import 'package:grocery_app/customWidgets/singleAddressWidget.dart';
import 'package:grocery_app/utils/constants.dart';

class SingleAddressScreen extends StatelessWidget {
  Map<String,dynamic> address;
  SingleAddressScreen({super.key,required this.address});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBgColor,
        ),
        backgroundColor: kBgColor,
        body: Padding(padding: EdgeInsets.all(15),
        child: ListView(
                  children: [
                    SingleAddressWidget(title: 'Name',value: address['name'],),
                    const Divider(),
                    SingleAddressWidget(title: 'Phone Number',value: address['phone'],),
                    const Divider(),
                    SingleAddressWidget(title: 'Address',value: '${address['address1']}, ${address['address2']}',),
                    const Divider(),
                    SingleAddressWidget(title: 'City',value: address['city'],),
                    const Divider(),
                    SingleAddressWidget(title: 'State', value: address['state']),
                    const Divider(),
                    SingleAddressWidget(title: 'Country', value: address['country'])
                  ],
                ),),
      ),
    );
  }
}