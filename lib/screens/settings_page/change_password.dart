import 'dart:async';

import 'package:izesan/utils/toast.dart';
import 'package:izesan/viewmodels/settings_model.dart';
import 'package:izesan/widgets/alert_dialog_btn.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/text_field.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/helper_widgets.dart';
import '../../utils/local_store.dart';
import '../../utils/validator.dart';
import '../../viewmodels/base_model.dart';
import '../../widgets/izs_flat_button.dart';
import '../../widgets/izs_header_text.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    with TickerProviderStateMixin {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final _storage = const FlutterSecureStorage();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final Validator validator = Validator();
  int passwordStrength = 0;
  Color passwordStrengthColor = Colors.grey;
  AnimationController? _controller;
  Animation<double>? _animation;
  final double _progressValue = 0;
  OverlayEntry? overlayEntry;

  bool _obscurePwd = true;
  bool _obscureNewPwd = true;
  bool _obscureConfirmPwd = true;
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  String weakPwdLoader = '';

  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: passwordStrength / 8)
        .animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strengthText = passwordStrength == 0
        ? 'Password Strength:'
        : passwordStrength <= 3
            ? 'Password Strength: Weak'
            : passwordStrength <= 5
                ? 'Password Strength: Fair'
                : 'Password Strength: Strong';
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 28),
              child: Column(
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IzsHeaderText(
                            text:
                                remoteConfig.getString('change_password_text')),
                        addVerticalSpace(32),
                        IzsTextField(
                          textInputType: TextInputType.emailAddress,
                          labelText:
                              remoteConfig.getString('enter_pwd_label_text'),
                          textController: passwordController,
                          autoFocus: false,
                          validate: Validator.noEmptyText,
                          isPassword: true,
                          obscureText: _obscurePwd,
                          textInputAction: TextInputAction.next,
                          suffixIcon: InkWell(
                            child: _obscurePwd
                                ? const Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.captionColor,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility_off_sharp,
                                    size: 20,
                                    color: AppColors.captionColor,
                                  ),
                            onTap: () {
                              setState(() {
                                _obscurePwd = !_obscurePwd;
                              });
                            },
                          ),
                        ),
                        addVerticalSpace(24),
                        IzsTextField(
                          textInputType: TextInputType.emailAddress,
                          labelText:
                              remoteConfig.getString('new_pwd_label_text'),
                          textController: newPasswordController,
                          autoFocus: false,
                          // validate: Validator.password,
                          isPassword: true,
                          obscureText: _obscureNewPwd,
                          textInputAction: TextInputAction.next,
                          suffixIcon: InkWell(
                            child: _obscureNewPwd
                                ? const Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.captionColor,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility_off_sharp,
                                    size: 20,
                                    color: AppColors.captionColor,
                                  ),
                            onTap: () {
                              setState(() {
                                _obscureNewPwd = !_obscureNewPwd;
                              });
                            },
                          ),
                          onChanged: ((value) {
                            // validationCheck(value!);
                          }),
                        ),
                        addVerticalSpace(24),
                        IzsTextField(
                          textInputType: TextInputType.emailAddress,
                          labelText:
                              remoteConfig.getString('confirm_pwd_label_text'),
                          textController: confirmPasswordController,
                          autoFocus: false,
                          validate: (value) {
                            if (newPasswordController.text != value) {
                              return 'Passwords do not match';
                            } else {
                              return null;
                            }
                          },
                          isPassword: true,
                          obscureText: _obscureConfirmPwd,
                          textInputAction: TextInputAction.done,
                          suffixIcon: InkWell(
                            child: _obscureConfirmPwd
                                ? const Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.captionColor,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility_off_sharp,
                                    size: 20,
                                    color: AppColors.captionColor,
                                  ),
                            onTap: () {
                              setState(() {
                                _obscureConfirmPwd = !_obscureConfirmPwd;
                              });
                            },
                          ),
                          //
                        ),
                        addVerticalSpace(12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TweenAnimationBuilder(
                                tween: Tween<double>(
                                    begin: _animation!.value,
                                    end: _progressValue),
                                duration: const Duration(milliseconds: 500),
                                builder: (BuildContext context, double value,
                                    Widget? child) {
                                  return Container(
                                    height: 5.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Colors.grey[300],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: LinearProgressIndicator(
                                        value: passwordStrength / 6,
                                        backgroundColor: Colors.transparent,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                passwordStrengthColor),
                                      ),
                                    ),
                                  );
                                }),
                            addVerticalSpace(5),
                            AppText(
                              text: strengthText,
                              size: 12,
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                        addVerticalSpace(150),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Selector<SettingsModel, ViewStatus>(
                selector: (_, model) => model.viewStatus,
                builder: (_, viewStatus, child) {
                  return IzsFlatButton(
                    width: double.maxFinite,
                    height: 52,
                    isLoading: viewStatus == ViewStatus.Loading &&
                        weakPwdLoader.contains('strongPwdLoader'),
                    isResponsive: false,
                    color: viewStatus == ViewStatus.Loading
                        ? AppColors.dividerColor
                        : AppColors.primaryColor,
                    text: remoteConfig.getString('save_changes_btn_text'),
                    textSize: 14,
                    textColor: Colors.white,
                    borderRadius: 12,
                    onPressed: () {
                      _formkey.currentState!.validate();
                      viewStatus == ViewStatus.Loading
                          ? null
                          : onProceedPressed();
                    },
                    borderColor: Theme.of(context).cardColor,
                    borderWidth: 0,
                  );
                }),
          ),
        ),
      ),
    );
  }

  void onProceedPressed() {
    String oldPassword =
        passwordController.text; // get the password from the text field
    String newPassword =
        newPasswordController.text; // get the password from the text field
    int strength =
        passwordStrength; // get the password strength using your validation function

    if (strength < 4) {
      // Password is weak, show the consent modal
      // showOverlay(context);
    } else {
      _handleChangePassword(oldPassword, newPassword);
      // Password is fair or strong, proceed with the function
      // ...
    }
  }


  Future<dynamic> _handleChangePassword(
      String password, String newPassword) async {
    setState(() {
      weakPwdLoader = 'strongPwdLoader';
    });
    final bool isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();

      final res =
          await context.read<SettingsModel>().changePwd(password, newPassword);
      if (res == null) {
        return null;
      }
      if (res) {
        passwordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        await deleteFssData();
        if (!mounted) return;
        return CustomToastQueue.showCustomToast(
            context,
            'Password changed successfully',
            Icons.check,
            AppColors.successTint,
            const Duration(seconds: 5),
            'success');
      } else {
        if (!mounted) return;
        var error = Provider.of<SettingsModel>(context, listen: false);
        if (error.errorMessage != null) {
          return CustomToastQueue.showCustomToast(
              context,
              error.errorMessage.toString(),
              Icons.close,
              AppColors.redTint,
              const Duration(seconds: 5),
              'error');
          // return Toast.showErrorNotification(error.errorMessage.toString(), this);
        }
      }
    }
  }

  Future<void> deleteFssData() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      rethrow;
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
