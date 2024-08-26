import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  final String text;
  final double? textSize;
  final double? textWidth;
  final Widget child;
  final Widget secondChild;
  final Function onPress;
  final Color? color; // Provide the text color
  final double? space; // Add space between the image and text

  const TextWithIcon({
    Key? key,
    required this.text,
    required this.child,
    this.secondChild = const SizedBox.shrink(),
    required this.onPress,
    this.color,
    this.space,
    this.textSize,
    this.textWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
         onPress();
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                    height: 30,
                    child: child),
                addHorizontalSpace(space ?? 16),
                SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: AppText(
                    text: text,
                    fontWeight: FontWeight.w400,
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                    size: textSize ?? 14.0,
                    color: color ?? Theme.of(context).primaryColorDark, // Use color if provided, else use default
                  ),
                ),
              ],
            ),
            // Expanded(child: Container()),
            SizedBox(
                  width: 90,
              child: Align(
                alignment: Alignment.centerRight,
                child: secondChild,
              ),
            )
          ]);
        }
      ),
    );
  }
}
