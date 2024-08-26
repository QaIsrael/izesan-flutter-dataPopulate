import 'package:flutter/material.dart';
import 'package:izesan/utils/colors.dart';
import '../widgets/app_text.dart';

class IzsCustomToast extends StatefulWidget {
  final String message;
  final IconData iconData;
  final Color backgroundColor;
  final Duration duration;
  final String type;

  IzsCustomToast({
    Key? key,
    required this.message,
    required this.iconData,
    this.backgroundColor = Colors.white,
    this.duration = const Duration(milliseconds: 4000),
    required this.type,
  }) : super(key: key);

  @override
  _IzsCustomToastState createState() => _IzsCustomToastState();
}

class _IzsCustomToastState extends State<IzsCustomToast> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool isDisposed = false;
  bool _isVisible = true;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInToLinear,
    ));

    _startAnimations();

    // Automatically dismiss the toast after the specified duration
    // Future.delayed(widget.duration, () {
    //   if (mounted) {
    //     _dismissToast();
    //   }
    // });
  }

  @override
  void dispose() {
    isDisposed = true;
    _animationController.dispose();
    overlayEntry?.remove();
    super.dispose();
  }

  void _startAnimations() async {
    await _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 5000));
    if(mounted){
      await _animationController.reverse();
      await Future.delayed(const Duration(milliseconds:400));
    }
  }

  void _dismissToast() async {
    if (_isVisible && _animationController.status == AnimationStatus.completed) {
      setState(() {
        _isVisible = false;
      });
      await _animationController.reverse();
      return overlayEntry?.remove();
    }
    // await _animationController.reverse();
    // return overlayEntry?.remove();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.up, //swipe up to dismiss
      onDismissed: (_) => _dismissToast(),
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          height: screenHeight * 0.08,
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          color: Colors.white,//widget.backgroundColor,
          child: Row(
            children: [
              Container(
                width: 26.0,
                height: 26.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: (widget.type == 'error')
                      ? AppColors.errorColor2
                      : AppColors.successTextTint,
                ),
                child: Icon(
                  widget.iconData,
                  size: 20,
                  color: widget.backgroundColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppText(
                  text:widget.message,
                  fontWeight: FontWeight.w700,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  size: 14,
                  color: (widget.type == 'error')
                      ? AppColors.errorColor2
                      : AppColors.successTextTint,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomToastQueue {
  static final List<OverlayEntry> _toastQueue = [];

  static void showCustomToast(
      BuildContext context,
      String message,
      IconData iconData,
      Color backgroundColor,
      Duration duration,
      String type,
      ) {
    OverlayEntry? entry; // Declare the entry variable

     entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            // Remove the overlay entry when tapped
            if (entry!.mounted) {
              _toastQueue.remove(entry);
              entry.remove();
            }
          },
          child: IzsCustomToast(
            message: message,
            iconData: iconData,
            backgroundColor: Colors.white,//backgroundColor,
            duration: const Duration(milliseconds: 5000),
            type: type,
          ),
        ),
      ),
    );

    if (_toastQueue.isNotEmpty) {
      // Remove any existing entries from the queue
      for (var existingEntry in _toastQueue) {
        if (existingEntry.mounted) {
          existingEntry.remove();
        }
      }
      _toastQueue.clear();
    }

    _toastQueue.add(entry);
    Overlay.of(context).insertAll(_toastQueue);

    // Automatically dismiss the toast after the specified duration
    Future.delayed(duration, () {
      if (entry!.mounted) {
        _toastQueue.remove(entry);
        entry.remove();
      }
    });
  }
}

