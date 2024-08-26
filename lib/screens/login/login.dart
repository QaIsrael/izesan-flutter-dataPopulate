import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/constants.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:izesan/widgets/text_field.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../model/school_user.dart';
import '../../services/error_state.dart';
import '../../utils/analytic_provider.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';
import '../../utils/toast.dart';
import '../../utils/validator.dart';
import '../../viewmodels/auth_model.dart';
import '../../viewmodels/base_model.dart';
import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';
import '../../widgets/izs_app_nav_bar.dart';
import '../../widgets/izs_gradient_button.dart';
import '../../widgets/modal_error_box.dart';
import '../settings_page/secure_account_dialog.dart';

class Login extends StatefulWidget {
  final Map<String, dynamic> name;

  const Login({super.key, required this.name});


  @override
  _LoginState createState() => _LoginState();
}

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }

class _LoginState extends State<Login>  with TickerProviderStateMixin{

  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController teacherController = TextEditingController();
  final TextEditingController studentController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  final ValueNotifier _authorized = ValueNotifier("Not Authorized");
  final ValueNotifier<String> _selectedUserTypeNotifier = ValueNotifier<String>('School');

  String _checkBioValue = "";
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;

  late AlertDialogBoxHandler _alertHandler;
  late SecureDialogBoxHandler _securePaymentHandler;
  late String userName = '';
  late String phoneNumber = '';
  bool isVisible = true;
  bool saveLogin = false;
  bool _obscureText = true;
  int loginBtnCount = 0;

  @override
  void initState() {
    super.initState();
    context.read<AuthViewModel>().clearError();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
  }

  @override
  void dispose() {
    super.dispose();
    _authorized.dispose();
    passwordController.dispose();
    userNameController.dispose();
    studentController.dispose();
    teacherController.dispose();
    _selectedUserTypeNotifier.dispose();
  }

  _showErrorMessage(event) {
    if(mounted){
      var error = Provider.of<AuthViewModel>(context, listen: false);
      if(error.errorMessage != null) {

        return CustomToastQueue.showCustomToast(
          context,
          error.errorMessage.toString(),
          Icons.close,
          Colors.white,
          const Duration(seconds: toastDuration),
          'error'
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const LoginNavBar(
                width: double.maxFinite,
                height: 80,
              ),
              Container(
                width: 900,
                height: 550,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [generateBoxShadow(context)],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFA0522D),
                          boxShadow: [generateBoxShadow(context)],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 20,
                              right: 240,
                              child: Container(
                                width: 250,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  boxShadow: [generateBoxShadow(context)],
                                  borderRadius:  BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child:  AppLargeText(
                                    text: 'Welcome back!',
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 300, // Adjust size as needed
                                height: 300,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle, // Make the container circular
                                  color: Colors.orange, // Background color
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 29.0,
                                      left: 70,
                                      child: Center(
                                        child: SvgPicture.asset('assets/images/female_teacher.svg',
                                          width: 270,
                                          height: 270,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right side enter input field
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addVerticalSpace(20),
                            const Row(
                              children: [
                                AppText(
                                  text:'Login',
                                  color: AppColors.warningCaption,
                                  fontWeight: FontWeight.bold,
                                  size: 24,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.warningCaption,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            addVerticalSpace(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: ['School', 'Student','Teacher' ].map((userType) {
                                return ValueListenableBuilder<String>(
                                  valueListenable: _selectedUserTypeNotifier,
                                  builder: (context, selectedUserType, child) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                      child: IzsFlatButton(
                                        width: 100,
                                        height: 40,
                                        isResponsive: false,
                                        color: selectedUserType == userType ? AppColors.primaryColor : AppColors.warningColor,
                                        text: userType,
                                        textSize: 14,
                                        textColor: Colors.white,
                                        borderRadius: 8,
                                        onPressed: () {
                                          _selectedUserTypeNotifier.value = userType;
                                        },
                                        borderColor: Theme.of(context).cardColor,
                                        borderWidth: 0,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            addVerticalSpace(32),
                            // Dynamic Input Fields
                            ValueListenableBuilder<String>(
                              valueListenable: _selectedUserTypeNotifier,
                              builder: (context, selectedUserType, child) {
                                return _buildInputFields(selectedUserType);
                              },
                            ),
                            SecureAccountDialog(
                              isLoading: false,
                              message: 'It seems you are having a challenge \ngetting the correct password',
                              opacity: 0.95,
                              title: 'Reset Your Password',
                              alertHandleCallback: (SecureDialogBoxHandler handler) {
                                _securePaymentHandler = handler;
                              },
                              onNoPressed: () {
                                _securePaymentHandler.dismiss();
                              },
                              onYesPressed: () {
                                // _handleSendOtp();
                              },
                              buttonText: 'Reset Password',
                              showCloseIcon: true,
                              tapToClose: false,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields(String userType) {
    switch (userType) {
      case 'School':
        return Column(
          children: [
            const AppText(
                text:'Sign in to your account to continue.',
                color: Colors.orange
            ),
            addVerticalSpace(16),
            IzsTextField(
                textInputType: TextInputType.emailAddress,
                labelText: "",
                textController: userNameController,
                autoFocus: false,
                validate: Validator.emailValidate,
                isPassword: false,
                hintText: 'Enter Email',

                textInputAction: TextInputAction.done),
            addVerticalSpace(24),
            Semantics(
              label: 'Password form Input',
              child: IzsTextField(
                  textInputType: TextInputType.visiblePassword,
                  labelText: '',
                  textController: passwordController,
                  autoFocus: false,
                  validate: Validator.loginPasswordValidation,
                  isPassword: true,
                  obscureText: _obscureText,
                  hintText: 'Enter Password',
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  suffixIcon: InkWell(
                    hoverColor: Colors.orange.withOpacity(0.1),
                    highlightColor: Colors.orange.withOpacity(0.1),
                    focusColor: Colors.brown.withOpacity(0.5),
                    radius: 8.0,
                    child: _obscureText
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
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  textInputAction: TextInputAction.done),
            ),
            addVerticalSpace(20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Selector<AuthViewModel, ViewStatus>(
                    selector: (_, model) => model.viewStatus,
                    builder: (_, viewStatus, child) {
                      return Column(
                        children: [
                          Semantics(
                            label: 'School/Admin Login Button',
                            child: IzsGradientButton(
                              width: 200,
                              height: 48,
                              isLoading: viewStatus == ViewStatus.Loading,
                              formKey: _formKey,
                              isResponsive: false,
                              color: viewStatus == ViewStatus.Loading
                                  ? AppColors.dividerColor
                                  : AppColors.primaryColor,
                              text: 'Sign In',
                              textSize: 14,
                              textColor: Colors.white,
                              borderRadius: 8,
                              onPressed: () {
                                viewStatus == ViewStatus.Loading
                                    ? null
                                    : _handleSchoolLogin(userNameController.text,
                                    passwordController.text);
                              },
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                            ),
                          ),
                          addVerticalSpace(10),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.help,
                                  size: 16.0,
                                  color: AppColors.captionColor,
                                ),

                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        );
      case 'Teacher':
        return Column(
          children: [
            const AppText(
                text:'Sign in to your account to continue.',
                color: Colors.orange
            ),
            addVerticalSpace(16),
            IzsTextField(
                textInputType: TextInputType.emailAddress,
                labelText: "",
                textController: teacherController,
                autoFocus: false,
                validate: Validator.noEmptyText,
                isPassword: false,
                hintText: 'Enter Teachers ID',
                textInputAction: TextInputAction.done),
            addVerticalSpace(24),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Selector<AuthViewModel, ViewStatus>(
                    selector: (_, model) => model.viewStatus,
                    builder: (_, viewStatus, child) {
                      return Column(
                        children: [
                          Semantics(
                            label: 'Login Button',
                            child: IzsGradientButton(
                              width: 200,
                              height: 48,
                              isLoading: viewStatus == ViewStatus.Loading,
                              formKey: _formKey,
                              isResponsive: false,
                              color: viewStatus == ViewStatus.Loading
                                  ? AppColors.dividerColor
                                  : AppColors.primaryColor,
                              text: 'Sign In',
                              textSize: 14,
                              textColor: Colors.white,
                              borderRadius: 8,
                              onPressed: () {
                                viewStatus == ViewStatus.Loading
                                    ? null
                                    : _handleTeacherLogin(teacherController.text);
                              },
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                            ),
                          ),
                          addVerticalSpace(10),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.help,
                                  size: 16.0,
                                  color: AppColors.captionColor,
                                ),

                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        );
      case 'Student':
        return Column(
          children: [
            const AppText(
                text:'Sign in to your account to continue.',
                color: Colors.orange
            ),
            addVerticalSpace(16),
            IzsTextField(
                textInputType: TextInputType.emailAddress,
                labelText: "",
                textController: studentController,
                autoFocus: false,
                validate: Validator.noEmptyText,
                isPassword: false,
                hintText: 'Enter Student ID',
                textInputAction: TextInputAction.done),
            addVerticalSpace(24),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Selector<AuthViewModel, ViewStatus>(
                    selector: (_, model) => model.viewStatus,
                    builder: (_, viewStatus, child) {
                      return Column(
                        children: [
                          Semantics(
                            label: 'Login Button',
                            child: IzsGradientButton(
                              width: 200,
                              height: 48,
                              isLoading: viewStatus == ViewStatus.Loading,
                              formKey: _formKey,
                              isResponsive: false,
                              color: viewStatus == ViewStatus.Loading
                                  ? AppColors.dividerColor
                                  : AppColors.primaryColor,
                              text: 'Sign In',
                              textSize: 14,
                              textColor: Colors.white,
                              borderRadius: 8,
                              onPressed: () {
                                viewStatus == ViewStatus.Loading
                                    ? null
                                    : _handleStudent(studentController.text);

                              },
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                            ),
                          ),
                          addVerticalSpace(10),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.help,
                                  size: 16.0,
                                  color: AppColors.captionColor,
                                ),

                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        );
      case 'Parent':
        return Column(
          children: [
            const AppText(
                text:'Sign in to your account to continue.',
                color: Colors.orange
            ),
            addVerticalSpace(16),
            IzsTextField(
                textInputType: TextInputType.emailAddress,
                labelText: "",
                textController: studentController,
                autoFocus: false,
                validate: Validator.noEmptyText,
                isPassword: false,
                hintText: 'Enter Parent ID',
                textInputAction: TextInputAction.done),
            addVerticalSpace(24),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Selector<AuthViewModel, ViewStatus>(
                    selector: (_, model) => model.viewStatus,
                    builder: (_, viewStatus, child) {
                      return Column(
                        children: [
                          Semantics(
                            label: 'Login Button',
                            child: IzsGradientButton(
                              width: 200,
                              height: 48,
                              isLoading: viewStatus == ViewStatus.Loading,
                              formKey: _formKey,
                              isResponsive: false,
                              color: viewStatus == ViewStatus.Loading
                                  ? AppColors.dividerColor
                                  : AppColors.primaryColor,
                              text: 'Sign In',
                              textSize: 14,
                              textColor: Colors.white,
                              borderRadius: 8,
                              onPressed: () {
                                viewStatus == ViewStatus.Loading
                                    ? null
                                    : _handleParentLogin(studentController.text);
                              },
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                            ),
                          ),
                          addVerticalSpace(10),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(
                                //   Icons.help,
                                //   size: 16.0,
                                //   color: AppColors.captionColor,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  Future _handleSchoolLogin(String userName, String password) async{
    context.read<AuthViewModel>().clearError();
    FocusManager.instance.primaryFocus?.unfocus();
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      final res = await context.read<AuthViewModel>().login(userName, password);
      if (res == null) {return null;}
      if (res != null && res['message'] == 'Login Successful') {
        Future.microtask(() {
          _handleGotoDashboard();
        });
      }
    }
  }

  Future _handleTeacherLogin(String userName) async{
    context.read<AuthViewModel>().clearError();
    FocusManager.instance.primaryFocus?.unfocus();
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      final res = await context.read<AuthViewModel>().teacherLogin(userName);
      if (res == null) {
        return null;
      }
      if (res != null && res['message'] == 'Login Successful') {
        Future.microtask(() {
          _handleGotoDashboard();
          // context.read<AnalyticsProvider>().logLoginEvent();
        });
        // return await getUserDetails();
      }
    }
  }

  Future _handleStudent(String userName) async{
    context.read<AuthViewModel>().clearError();
    FocusManager.instance.primaryFocus?.unfocus();
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      final res = await context.read<AuthViewModel>().studentLogin(userName);
      if (res == null) {
        return null;
      }
      if (res != null && res['message'] == 'Login Successful') {
        Future.microtask(() {
          _handleGotoDashboard();
        });
      }
    }
  }

  Future _handleParentLogin(String userName) async{
    context.read<AuthViewModel>().clearError();
    FocusManager.instance.primaryFocus?.unfocus();
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      final res = await context.read<AuthViewModel>().parentLogin(userName);
      if (res == null) {
        return null;
      }
      if (res != null && res['message'] == 'Login Successful') {
        Future.microtask(() {
          _handleGotoDashboard();
          // context.read<AnalyticsProvider>().logLoginEvent();
        });
        // return await getUserDetails();
      }
    }
  }

  Future<Object?> _handleGotoDashboard() async {
    var userType = _selectedUserTypeNotifier.value;
    if(userType == 'School') {
      return  Navigator.of(context).pushNamed(RouteName.dashboard, arguments: {});
    } else if(userType == 'Teacher') {
      return  Navigator.of(context).pushNamed(RouteName.teachersDashboard, arguments: {});
    } else if(userType == 'Student' || userType == 'Parent') {
      return  Navigator.of(context).pushNamed(RouteName.studentDashboard, arguments: {});
    } else {
      return null;
    }
  }

}
