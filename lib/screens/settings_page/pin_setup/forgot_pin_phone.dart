import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/utils/route_name.dart';
import 'package:izesan/utils/validator.dart';
import 'package:izesan/viewmodels/base_model.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:izesan/widgets/izs_header_text.dart';
import 'package:izesan/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/settings_model.dart';

class ForgotPinPhone extends StatefulWidget {
  const ForgotPinPhone({Key? key}) : super(key: key);

  @override
  State<ForgotPinPhone> createState() => _ForgotPinPhoneState();
}

class _ForgotPinPhoneState extends State<ForgotPinPhone> {
  final _formKey = GlobalKey<FormState>();
  String phone = '';
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    _getUserDetailsLocalStorage();
    super.initState();
  }

  Future _getUserDetailsLocalStorage() async {
    final value = await LocalStoreHelper.getMeDetails();
    late String names = value!.phone!;
    if (value != null) {
      phoneNumberController.text = value.phone!;
      setState(() {
        phone = (names.isEmpty ? value.phone : value.phone)!;
      });
    }
  }

  String truncatePhoneNumber(String phoneNum) {
    if (phoneNum.length <= 4) {
      return phoneNum; // Return the original number if it's already shorter or equal to 4 characters
    }

    String maskedDigits = "*" * (phoneNum.length - 4);
    String lastFour = phoneNum.substring(phoneNum.length - 4);
    return maskedDigits + lastFour;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Semantics(
        label: 'Phone Verify',
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            bottomOpacity: 0.0,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.west,
                color: AppColors.captionColor,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(20),
                      Semantics(
                        label: 'Header Text',
                        child: const IzsHeaderText(
                          text: "Reset PIN.",
                        ),
                      ),
                      addVerticalSpace(32),

                      const AppText(text: 'An OTP will be sent to your phone',
                        size: 14,
                        color: AppColors.textColorLightTheme,
                      ),
                      addVerticalSpace(24),
                      // Semantics(
                      //   label: 'Enter phone input field',
                      //   child: TextField(
                      //       textInputType: TextInputType.number,
                      //       labelText: "Phone Number",
                      //       hintText: truncatePhoneNumber(phone),
                      //       textController: phoneNumberController,
                      //       autoFocus: true,
                      //       enabled: false,
                      //       showCursor: false,
                      //       validate: Validator.phone,
                      //       textInputAction: TextInputAction.done),
                      // ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: Image.asset(
                                  "assets/icons/warning-icon.png",
                                  color: AppColors.captionColor,
                                  fit: BoxFit.contain),
                            ),
                            addHorizontalSpace(8),
                            const SizedBox(
                                width: 250,
                                child: AppText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    size: 14,
                                    text:
                                        "You have to take your number off DND to get the OTP"))
                          ],
                        ),
                      ),
                      addVerticalSpace(16),
                      Selector<SettingsModel, ViewStatus>(
                          selector: (_, model) => model.viewStatus,
                          builder: (_, viewStatus, child) {
                            return IzsFlatButton(
                              width: double.maxFinite,
                              height: 52,
                              isLoading: viewStatus == ViewStatus.Loading,
                              formKey: _formKey,
                              isResponsive: false,
                              color: viewStatus == ViewStatus.Loading
                                  ? AppColors.dividerColor
                                  : AppColors.primaryColor,
                              text: 'Send OTP',
                              textSize: 14,
                              textColor: Colors.white,
                              borderRadius: 12,
                              onPressed: () {
                                // viewStatus == ViewStatus.Loading
                                //     ? null
                                //     : _handleSendOtp(phoneNumberController.text);
                              },
                              borderColor: Theme.of(context).cardColor,
                              borderWidth: 0,
                            );
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future _handleSendOtp(String phone) async {
  //   final bool isValid = _formKey.currentState!.validate();
  //   if (isValid) {
  //     _formKey.currentState!.save();
  //     final res =
  //         await context.read<SettingsModel>().startPinVerification(phone);
  //     if(!mounted)return;
  //     if (res != null) {
  //       return await Navigator.of(context)
  //           .pushNamed(RouteName.forgotPin, arguments: {'phone': phone});
  //     }
  //   }
  // }
}
