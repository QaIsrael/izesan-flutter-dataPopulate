import 'package:flutter/material.dart';

import '../utils/helper_widgets.dart';
import 'app_text.dart';

class IzsCheckBox extends StatefulWidget {
  final bool isChecked;
  final double size;
  final double iconSize;
  final double? width;
  final Color selectedColor;
  final Function onChange;
  final String cardText;

  const IzsCheckBox(
      {Key? key,
        required this.isChecked,
        required this.size,
        required this.iconSize,
        required this.selectedColor,
        this.width = 90,
        required this.onChange,
        required this.cardText})
      : super(key: key);

  @override
  State<IzsCheckBox> createState() => _IzsCheckBoxState();
}

class _IzsCheckBoxState extends State<IzsCheckBox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChange(_isSelected);
        });
      },
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(microseconds: 500),
            decoration: BoxDecoration(
                color: _isSelected ? widget.selectedColor : Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
                border: _isSelected
                    ? null
                    : Border.all(color: Colors.grey, width: 2.0)),
            width: widget.size,
            height: widget.size,
            child: _isSelected
                ? const Icon(
              Icons.check_sharp,
              color: Colors.white,
              size: 14,
            )
                : null,
          ),
          addHorizontalSpace(8),
          SizedBox(
            width: widget.width,
            child: AppText(
              text: widget.cardText,
              size: 12,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
