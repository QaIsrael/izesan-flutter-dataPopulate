import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'app_text.dart';

class ModalAlertBox extends StatefulWidget {
  final double _opacity;
  final String _textMessage;
  final Function onYesPressed;
  final Function onNoPressed;
  final String _title;
  final String? positiveText;
  final String? negativeText;
  final Function _alertHandlerCallback;
  final double cardHeight;
  final double cardWidth;


  const ModalAlertBox({
    Key? key,
    required Function(AlertDialogBoxHandler handler) alertHandleCallback,
    String message = "",
    double opacity = 0.7,
    required this.onYesPressed,
    required this.onNoPressed,
    required this.cardHeight,
    required this.cardWidth,
    required String title,
    required this.positiveText,
    required this.negativeText,
  })  : _textMessage = message,
        _title = title,
        _opacity = opacity,
        // _positiveText = positiveText,
        // _negativeText = negativeText,
        _alertHandlerCallback = alertHandleCallback,
        super(key: key);

  @override
  State createState() => _ModalAlertBoxState();
}

class _ModalAlertBoxState extends State<ModalAlertBox> {
  bool _isShowing = false;

  @override
  void initState() {
    super.initState();
    AlertDialogBoxHandler errorHandler = AlertDialogBoxHandler();

    errorHandler.show = show;
    errorHandler.dismiss = dismiss;
    widget._alertHandlerCallback(errorHandler);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isShowing) return Stack();
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: widget._opacity,
            child: const ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: Theme.of(context).cardColor,
              elevation: 0.0,
              // margin:
              //     const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              child: Container(
                constraints: const BoxConstraints(minHeight: 190),
                height: widget.cardHeight, //170,
                width: widget.cardWidth,//324,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              'assets/images/biometric.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          addVerticalSpace(24),
                          AppLargeText(
                            text: widget._title,
                            size: 24,
                            // color: AppColors.,
                          ),
                          addVerticalSpace(8),
                          SizedBox(
                            width: 280,
                            child: AppText(
                              textAlign: TextAlign.center,
                              text: widget._textMessage,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          addVerticalSpace(24),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IzsFlatButton(
                            width: double.maxFinite,
                            height: 52,
                            isResponsive: false,
                            color: AppColors.primaryColor,
                            text: widget.positiveText!,
                            textSize: 14,
                            textColor: AppColors.textColor2,
                            borderRadius: 6,
                            onPressed: () {
                              widget.onYesPressed();
                            },
                            borderColor: AppColors.captionColor,
                            borderWidth: 0,
                          ),
                          addVerticalSpace(16),
                          IzsFlatButton(
                            width: double.maxFinite,
                            height: 52,
                            isResponsive: false,
                            color: Colors.transparent,
                            text: widget.negativeText!,
                            textSize: 14,
                            textColor: AppColors.primaryColor,
                            borderRadius: 6,
                            onPressed: () {
                              widget.onNoPressed();
                            },
                            borderColor: Colors.transparent,
                            borderWidth: 0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void show() {
    setState(() => _isShowing = true);
  }

  void dismiss() {
    setState(() => _isShowing = false);
  }
}

// handler class
class AlertDialogBoxHandler {
  late Function show;
  late Function dismiss;
}
