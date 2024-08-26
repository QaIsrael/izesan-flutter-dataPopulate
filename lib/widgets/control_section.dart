import 'package:flutter/material.dart';

import 'app_large_text.dart';
import 'app_text.dart';

class ControlSection extends StatelessWidget {
  final String currentCategory;
  final List videos;
  final ValueChanged<Map<String, dynamic>> onVideoTap;

  ControlSection({
    required this.currentCategory,
    required this.videos,
    required this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: ListView.builder(
            itemCount: videos.length,
            shrinkWrap: true,
            clipBehavior: Clip.hardEdge,
            itemBuilder: (context, index) {
              return ListTile(
                selected: true,
                selectedColor: Colors.orange.withOpacity(0.2),
                hoverColor: Colors.orange.withOpacity(0.2),
                title: AppLargeText(text: videos[index]['title']!, size: 14),
                onTap: () {
                  onVideoTap(videos[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
