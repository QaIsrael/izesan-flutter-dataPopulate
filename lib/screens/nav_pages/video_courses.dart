import 'dart:async';

import 'package:izesan/locator.dart';
import 'package:izesan/services/error_state.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/toast.dart';
import 'package:izesan/viewmodels/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/local_store.dart';

class VideoCourses extends StatefulWidget {
  const VideoCourses({super.key});

  @override
  State<VideoCourses> createState() => _VideoCoursesState();
}

class _VideoCoursesState extends State<VideoCourses> with TickerProviderStateMixin{
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();

  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;



  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
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
      body: const SizedBox(),
    );
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
