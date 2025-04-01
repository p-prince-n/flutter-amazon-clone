import 'package:amazon/Providers/user_provider.dart';
import 'package:amazon/common/Widgets/bottom_bar.dart';
import 'package:amazon/common/Widgets/custom_button.dart';
import 'package:amazon/common/Widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/constants/utils_alert.dart';
import 'package:amazon/features/Address/Services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-form';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressServices _addressServices = AddressServices();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final _addressKey = GlobalKey<FormState>();
  String usedAddress = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _houseController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
  }

  void onPayResult([String? add]) {
    print(add);
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      _addressServices.setUserAddress(
          context: context, address: add ?? usedAddress);
    }
    _addressServices.setUserOrder(
        context: context,
        address: add ?? usedAddress,
        totalAmount: double.parse(widget.totalAmount));
    setState(() {});
  }

  void payPressed(String providerAddress) {
    print('$usedAddress, $providerAddress');
    bool isForm = _houseController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressKey.currentState!.validate()) {
        final curadd =
            '${_houseController.text}, ${_areaController.text}, ${_cityController.text} - ${_pincodeController.text}';
        onPayResult(curadd);
        return;
      } else {
        throw Exception('Enter Address');
      }
    }
    if (providerAddress.isNotEmpty) {
      usedAddress = providerAddress;
    }
    if (usedAddress.isEmpty) {
      showSnackBar(context, 'No address selected.');
      return;
    }

    onPayResult();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            Form(
              key: _addressKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _houseController,
                      hintValue: 'Flat, House, Building no. ',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: _areaController,
                      hintValue: 'Area / Street',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: _pincodeController,
                      hintValue: 'Pincode',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: _cityController,
                      hintValue: 'City / Town',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                color: Color.fromARGB(255, 29, 201, 192),
                text: 'Place Order',
                onTap: () {
                  payPressed(address);
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => BottomBar()),
                        (route) => false);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
