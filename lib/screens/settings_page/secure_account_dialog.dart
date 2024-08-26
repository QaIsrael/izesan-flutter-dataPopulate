import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/viewmodels/base_model.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';

class SecureAccountDialog extends StatefulWidget {
  final double _opacity;
  final String _textMessage;
  final Function onYesPressed;
  final Function onNoPressed;
  final String _title;
  final Function _alertHandlerCallback;
  final bool isLoading;
  final bool showSingleButton;
  final String buttonText;
  final bool showCloseIcon;
  final bool tapToClose;

  const SecureAccountDialog({
    Key? key,
    required Function(SecureDialogBoxHandler handler) alertHandleCallback,
    String message = "",
    double opacity = 0.9,
    required this.onYesPressed,
    required this.onNoPressed,
    required String title,
    this.isLoading = false,
    required this.buttonText,
    required this.showCloseIcon,
    this.showSingleButton = false,
    required this.tapToClose,
  })  : _textMessage = message,
        _title = title,
        _opacity = opacity,
        _alertHandlerCallback = alertHandleCallback,
        super(key: key);

  @override
  State createState() => _SecureAccountDialogState();
}

class _SecureAccountDialogState extends State<SecureAccountDialog> {
  bool _isShowing = false;

  @override
  void initState() {
    super.initState();
    SecureDialogBoxHandler errorHandler = SecureDialogBoxHandler();

    errorHandler.show = show;
    errorHandler.dismiss = dismiss;
    widget._alertHandlerCallback(errorHandler);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isShowing) return const Stack();
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: widget._opacity,
            child: ModalBarrier(
              dismissible: widget.tapToClose,
              color: Colors.black,
              // onDismiss: ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.tapToClose == false) InkWell(
                  onTap: () {
                    widget.onNoPressed();
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: AppColors.captionColor,
                      ),
                    ),
                  ),
                ) else   Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.maybePop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: AppColors.captionColor,
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(minHeight: 220),
                  height: 270,
                  width: 324,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        addVerticalSpace(24),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: const BoxDecoration(
                              color: AppColors.greenTint,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: const SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: Icon(
                              Icons.lock,
                              size: 40,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        addVerticalSpace(16),
                        Align(
                            alignment: Alignment.center,
                            child: AppLargeText(
                              text: widget._title,
                              size: 17,
                              color: Colors.white,
                            )),
                        addVerticalSpace(8),
                        AppText(
                          text: widget._textMessage,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                        // addVerticalSpace(24),
                      ],
                    ),
                  ),
                ),
                // Consumer<VerifyViewModel>(
                //   builder: (BuildContext context, value, _) {
                //     final bool isLoading = widget.isLoading;
                //     // const String buttonText = 'Yes, Cancel';
                //     final Color buttonColor = isLoading
                //         ? AppColors.dividerColor
                //         : AppColors.primaryColor;
                //     return IzsFlatButton(
                //       isLoading: isLoading,
                //       width: double.maxFinite,
                //       height: 52,
                //       isResponsive: false,
                //       color: buttonColor,
                //       text: widget.buttonText,
                //       textSize: 14,
                //       textColor: Colors.white,
                //       borderRadius: 8,
                //       onPressed: () {
                //         // (value.viewStatus != ViewStatus.Loading)
                //         //     ? widget.onYesPressed()
                //         //     : null;
                //       },
                //       borderColor: AppColors.primaryColor,
                //       borderWidth: 0,
                //     );
                //   },
                // )
              ],
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
class SecureDialogBoxHandler {
  late Function show;
  late Function dismiss;
}
