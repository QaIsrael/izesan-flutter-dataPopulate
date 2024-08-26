import 'dart:async';

import 'package:izesan/locator.dart';
import 'package:izesan/screens/settings_page/change_email_screen.dart';
import 'package:izesan/services/error_state.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/toast.dart';
import 'package:izesan/utils/validator.dart';
import 'package:izesan/viewmodels/base_model.dart';
import 'package:izesan/viewmodels/home_page_model.dart';
import 'package:izesan/viewmodels/settings_model.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/card.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:izesan/widgets/text_button.dart';
import 'package:izesan/widgets/text_field.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/local_store.dart';
import '../../widgets/izs_header_text.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin{
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String name = 'Please enter your name here';
  String? email = '';
  String? phoneNumber = '';
  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  late Stream<Map<String, dynamic>> userDetails = const Stream.empty();
  final double spacing = 32.0;

  @override
  void initState() {
    // _getUserDetailsLocalStorage();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   userDetails = Stream<Map<String, dynamic>>.fromFuture(getMeDetails())
    //       .map((response) => response);
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    countryController.dispose();
    phoneController.dispose();
  }

  _showErrorMessage(event) {
    if(mounted){
      var error = Provider.of<SettingsModel>(context, listen: false);
      if (error.errorMessage != null) {
        return CustomToastQueue.showCustomToast(
            context,
            error.errorMessage.toString(),
            Icons.close,
            AppColors.redTint, const Duration(seconds: 5),
            'error'
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth > 800 ? 800 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      //   // leading: IconButton(
      //   //   onPressed: () {
      //   //     Navigator.pop(context);
      //   //   },
      //   //   icon: const Icon(
      //   //     Icons.west,
      //   //     color: AppColors.captionColor,
      //   //   ),
      //   // ),
      // ),
      body: StreamBuilder<Map<String, dynamic>>(
          stream: userDetails,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            // final responseData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 90,
                    color: Theme.of(context).primaryColor,
                    child: SizedBox(),
                  ),
                  addVerticalSpace(spacing),
                  Container(
                    width: screenWidth * 0.8,
                    height: 50,
                    padding: const EdgeInsets.only(left: 24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                        child: IzsHeaderText(text: 'Profile'))),
                  addVerticalSpace(spacing),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      width: containerWidth,
                      height: 400,
                      child: ColoredCard(
                        borderRadius: 16,
                        borderColor: AppColors.primaryColor,
                        cardColor: Theme.of(context).cardColor,
                        border: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            addVerticalSpace(spacing),
                            SizedBox(
                              width: containerWidth * 0.85,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IzsTextField(
                                      keyboardType: TextInputType.text,
                                      labelText: "Albert Dihweng",
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[a-z A-Z]")),
                                      ],
                                      textController: nameController,
                                      hintText: 'Name',//snapshot.hasData ? responseData!['name'] : name,
                                      autoFocus: true,
                                      textInputAction: TextInputAction.next,
                                      validate: Validator.noEmptyText,
                                    ),
                                  ),
                                  addHorizontalSpace(24),
                                  Expanded(
                                    child: IzsTextField(
                                      readOnly: true,
                                      textInputType: TextInputType.emailAddress,
                                      labelText: "Country",
                                      textController: countryController,
                                      hintText: 'Nigeria',
                                      //snapshot.hasData ? responseData!['phone'] : phoneNumber,
                                      autoFocus: true,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            addVerticalSpace(spacing),
                            SizedBox(
                              width: containerWidth * 0.85,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IzsTextField(
                                      readOnly: true,
                                      textInputType: TextInputType.emailAddress,
                                      labelText: "Email",
                                      textController: emailController,
                                      hintText: 'albert@izwsan.com', //snapshot.hasData ? responseData!['email'] : email,
                                      autoFocus: true,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                  addHorizontalSpace(24),
                                  Expanded(
                                    child: IzsTextField(
                                      readOnly: true,
                                      textInputType: TextInputType.emailAddress,
                                      labelText: "Phone Number",
                                      textController: phoneController,
                                      hintText: '09099474330',//snapshot.hasData ? responseData!['phone'] : phoneNumber,
                                      autoFocus: true,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
      //   child: Selector<SettingsModel, ViewStatus>(
      //       selector: (_, model) => model.viewStatus,
      //       builder: (_, viewStatus, child) {
      //         return IzsFlatButton(
      //           width: double.maxFinite,
      //           height: 52,
      //           isLoading: viewStatus == ViewStatus.Loading,
      //           formKey: _formkey,
      //           isResponsive: false,
      //           color: viewStatus == ViewStatus.Loading
      //               ? AppColors.dividerColor
      //               : AppColors.primaryColor,
      //           text: 'Save Changes',
      //           textSize: 14,
      //           textColor: Colors.white,
      //           borderRadius: 12,
      //           onPressed: () {
      //             viewStatus == ViewStatus.Loading
      //                 ? null
      //                 : _handleSaveName(nameController.text);
      //           },
      //           borderColor: Theme.of(context).cardColor,
      //           borderWidth: 0,
      //         );
      //       }),
      // ),
    );
  }

  Future _handleSaveName(String name) async {
    final bool isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
      final res = await context.read<SettingsModel>().changeName(name);
      if(!mounted)return;
      if (res != null) {
        CustomToastQueue.showCustomToast(
          context,
          res.toString(),
          Icons.check,
          AppColors.successTint, const Duration(seconds: 5),
          'success'
        );
        // return Toast.showSuccessNotification(res, this);
      } else {
        errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
      }
    }
  }

  Future<Map<String, dynamic>> getMeDetails() async {
    var res = await context.read<HomePageModel>().getMeDetails();
    return res;
  }

  String getInitials(String fullName, [int limitTo = 2]) {
    if (fullName.isEmpty) {
      return fullName;
    }
    List<String> nameParts = fullName.split(" ");
    String initials = "";
    for (String part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase();
      }
    }
    return initials;
  }

  Future _getUserDetailsLocalStorage() async {
    final value = await LocalStoreHelper.getMeDetails();
    // setState(() {
    //   name =
    //   (value!.name!.isEmpty ? value.phone : value.name)!; //.split(' ')[0];
    //   email = value.email!.isEmpty ? '' : value.email;
    //   phoneNumber = value.phone!.isEmpty ? '' : value.phone;
    // });
    return null;
  }

}
