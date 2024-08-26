import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/izs_caption_text.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String imageLink;
  final String titleText;
  final String subtitleText;
  final double? imgHeight;
  final double? imgWidth;
  final bool isTitleAvailable;

  const EmptyState(
      {Key? key,
      required this.subtitleText,
      required this.imageLink,
      this.isTitleAvailable = true,
      this.imgHeight,
      this.imgWidth,
      this.titleText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        addVerticalSpace(10),
        SizedBox(
          width: imgWidth ?? 120,
          height: imgHeight ?? 120,
          child: Image.asset(imageLink),
        ),
        titleText != ''
            ? Column(
                children: [
                  addVerticalSpace(12),
                  AppLargeText(
                    text: titleText,
                    textAlign: TextAlign.center,
                  ),
                  addVerticalSpace(8),
                ],
              )
            : const SizedBox(height: 20),
        SizedBox(
          width: 260,
          child: IzsCaptionText(
            textAlign: TextAlign.center,
            maxLines: 2,
            overFlow: TextOverflow.ellipsis,
            text: subtitleText,
            textTheme: Theme.of(context).textTheme,
          ),
        )
      ],
    );
  }
}
