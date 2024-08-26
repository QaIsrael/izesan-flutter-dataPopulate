import 'dart:async';

import 'package:izesan/locator.dart';
import 'package:izesan/services/error_state.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/utils/route_name.dart';
import 'package:izesan/utils/toast.dart';
import 'package:izesan/utils/validator.dart';
import 'package:izesan/viewmodels/base_model.dart';
import 'package:izesan/viewmodels/settings_model.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:izesan/widgets/izs_header_text.dart';
import 'package:izesan/widgets/text_field.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../widgets/izs_header_text.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> with TickerProviderStateMixin{
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final _formkey = GlobalKey<FormState>();
  String email = '';
  TextEditingController emailController = TextEditingController();
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;

  Future _getUserDetailsLocalStorage() async {
    return null;
  }

  @override
  void initState() {
    super.initState();
    _getUserDetailsLocalStorage();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) =>
                      Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addVerticalSpace(20),
                            IzsHeaderText(
                                text: remoteConfig
                                    .getString('change_email_text')),
                            addVerticalSpace(32),
                            IzsTextField(
                              textInputType: TextInputType.emailAddress,
                              labelText: remoteConfig
                                  .getString('verify_email_label_text'),
                              textController: emailController,
                              hintText: email,
                              autoFocus: true,
                              textInputAction: TextInputAction.done,
                              validate: Validator.email,
                            ),
                            const Spacer(),
                            Selector<SettingsModel, ViewStatus>(
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
                                    text: remoteConfig
                                        .getString('verify_email_btn_text'),
                                    textSize: 14,
                                    textColor: Colors.white,
                                    borderRadius: 12,
                                    onPressed: () {
                                      viewStatus == ViewStatus.Loading
                                          ? null
                                          : _handleSendOtp(
                                              emailController.text);
                                    },
                                    borderColor: Theme.of(context).cardColor,
                                    borderWidth: 0,
                                  );
                                }),
                          ],
                        ),
                      )),
            ),
          ),
        ),
      ),
    );
  }

  Future _handleSendOtp(String email) async {
    final bool isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
      final res = await context.read<SettingsModel>().changeEmail(email);
      if (res != null) {
        // return await Navigator.of(context).pushNamedAndRemoveUntil(
        //     RouteName.emailSuccess, (Route<dynamic> route) => false);
      } else {
        errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
      }
    }
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
