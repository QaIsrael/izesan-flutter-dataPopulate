import 'package:izesan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:izesan/widgets/izs_caption_text.dart';

import '../utils/helper_widgets.dart';

class IzsTextField extends StatelessWidget {
  final Icon? icon;
  final TextInputType? textInputType;
  final TextInputType? keyboardType;
  final String labelText;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController textController;
  final bool autoFocus;
  // FormFieldValidator<String>? validate;
  final String? Function(String?)? validate;
  final bool isPassword;
  final bool readOnly;
  final String? prefixText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputAction textInputAction;
  final int? maxLines;
  final double? minLines;
  final double? height;
  final FocusNode? onFocus;
  final bool? enabled;
  final bool? showCursor;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? capitalization;
  final Color? labelTextColor;
  final Function(bool)? onFieldFocusChanged;

  const IzsTextField(
      {Key? key,
      this.icon,
      this.onFocus,
      this.readOnly = false,
      this.isPassword = false,
      this.enabled = true,
      this.showCursor = true,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.contentPadding,
      this.textInputType,
      this.labelText = '',
      this.capitalization = TextCapitalization.words,
      required this.textController,
      required this.autoFocus,
      this.validate,
      this.onSaved,
      this.onChanged,
      this.maxLines,
      this.minLines,
      this.height,
      this.hintText,
      this.prefixText,
      this.suffixIcon,
      this.keyboardType,
      this.inputFormatters,
      this.onFieldFocusChanged,
      this.labelTextColor = AppColors.textColorSecondary,
      this.obscureText = false,
      required this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    onFocus?.addListener(() {
      if (onFieldFocusChanged != null) {
        onFieldFocusChanged!(onFocus!.hasFocus);
      }
    });
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText != '' ? IzsCaptionText(
            text: labelText,
            color: labelTextColor,
          ) : const SizedBox(),
          labelText != '' ? addVerticalSpace(8) : const SizedBox(),
          Center(
            child: SizedBox(
              height: height,
              child: TextFormField(
                clipBehavior: Clip.hardEdge,
                readOnly: readOnly,
                maxLines: obscureText == true ? 1 : maxLines,
                controller: textController,
                textCapitalization: capitalization!,
                validator: validate,
                onSaved: onSaved,
                onChanged: onChanged,
                enabled: enabled,
                showCursor: showCursor,
                // onFieldSubmitted: onFieldSubmitted,
                cursorColor: AppColors.primaryColor,
                cursorHeight: 16.0,
                textInputAction: textInputAction,
                inputFormatters: inputFormatters,
                keyboardType: textInputType,
                obscureText: obscureText,
                focusNode: onFocus,
                onEditingComplete: onEditingComplete,
                decoration: InputDecoration(
                  hoverColor: Colors.orange.withOpacity(0.2),
                  iconColor: Colors.black.withOpacity(0.6),
                    errorStyle: const TextStyle(
                        // fontSize: 0,
                          color: Colors.red,
                        height: 0.7),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.errorColor, width: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 16),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 0.9),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.disabledColor, width: 0.9),
                        borderRadius: BorderRadius.circular(12)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(width: 0.09),
                    ),
                    filled: true,
                    hintText: hintText,
                    prefixText:
                        prefixText, // Add the Naira symbol as prefixText
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      // height: 1,
                      color: AppColors.warningCaption,
                    ),
                    prefixIconColor: Colors.red,
                    fillColor: Colors.orange.withOpacity(0.09),
                    suffixIcon: suffixIcon,
                  suffixIconColor: Colors.red
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
