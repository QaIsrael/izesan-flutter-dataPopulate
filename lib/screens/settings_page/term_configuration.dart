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
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:izesan/widgets/text_button.dart';
import 'package:izesan/widgets/text_field.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/local_store.dart';
import '../../widgets/izs_header_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin{
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name = 'Please enter your name here';
  String? email = '';
  String? phoneNumber = '';
  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  late Stream<Map<String, dynamic>> userDetails = const Stream.empty();

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
    setState(() {
      name =
          (value!.name!.isEmpty ? value.phone : value.name)!; //.split(' ')[0];
      email = value.email!.isEmpty ? '' : value.email;
      phoneNumber = value.phone!.isEmpty ? '' : value.phone;
    });
    return null;
  }



  @override
  void initState() {
    _getUserDetailsLocalStorage();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userDetails = Stream<Map<String, dynamic>>.fromFuture(getMeDetails())
          .map((response) => response);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StreamBuilder<Map<String, dynamic>>(
          stream: userDetails,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            final responseData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(20),
                      IzsHeaderText(
                          text: remoteConfig.getString('profile_text')),
                      addVerticalSpace(32),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryColorDarkTheme,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: SizedBox(
                                  height: 35,
                                  width: 24,
                                  child: Center(
                                    child: AppLargeText(
                                      text: getInitials(
                                          snapshot.hasData
                                              ? responseData!['name']
                                              : name,
                                          2),
                                      size: 25,
                                    ),
                                  ),
                                )),
                          ),
                          addVerticalSpace(17),
                        ],
                      ),
                      addVerticalSpace(24),
                      Form(
                        key: _formkey,
                        child: IzsTextField(
                          keyboardType: TextInputType.text,
                          labelText: "Name",
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-z A-Z]")),
                          ],
                          textController: nameController,
                          hintText:
                              snapshot.hasData ? responseData!['name'] : name,
                          autoFocus: true,
                          textInputAction: TextInputAction.next,
                          validate: Validator.noEmptyText,
                        ),
                      ),
                      addVerticalSpace(24),
                      IzsTextField(
                        readOnly: true,
                        textInputType: TextInputType.emailAddress,
                        labelText: "Phone Number",
                        textController: emailController,
                        hintText: snapshot.hasData
                            ? responseData!['phone']
                            : phoneNumber,
                        autoFocus: true,
                        textInputAction: TextInputAction.done,
                      ),
                      addVerticalSpace(24),
                      IzsTextField(
                        readOnly: true,
                        textInputType: TextInputType.emailAddress,
                        labelText: "Email",
                        textController: emailController,
                        hintText:
                            snapshot.hasData ? responseData!['email'] : email,
                        autoFocus: true,
                        textInputAction: TextInputAction.done,
                      ),
                      addVerticalSpace(8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangeEmailScreen(),
                                ));
                          },
                          child: izsTextButton(
                            width: 92,
                            height: 16,
                            text: remoteConfig.getString('change_email_text'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
        child: Selector<SettingsModel, ViewStatus>(
            selector: (_, model) => model.viewStatus,
            builder: (_, viewStatus, child) {
              return IzsFlatButton(
                width: double.maxFinite,
                height: 52,
                isLoading: viewStatus == ViewStatus.Loading,
                formKey: _formkey,
                isResponsive: false,
                color: viewStatus == ViewStatus.Loading
                    ? AppColors.dividerColor
                    : AppColors.primaryColor,
                text: 'Save Changes',
                textSize: 14,
                textColor: Colors.white,
                borderRadius: 12,
                onPressed: () {
                  viewStatus == ViewStatus.Loading
                      ? null
                      : _handleSaveName(nameController.text);
                },
                borderColor: Theme.of(context).cardColor,
                borderWidth: 0,
              );
            }),
      ),
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
}
