import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izesan/utils/helper_widgets.dart';

import '../../utils/colors.dart';
import '../../widgets/app_text.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            // Set the left margin here
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 50,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.west,
                  size: 24,
                  color: AppColors.captionColor,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screenSize.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const AppText(text:'1/5'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.orange),
                    onPressed: () {
                      // Navigate to next page
                    },
                  ),
                ],
              ),
            ),
            addVerticalSpace(24),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              width: screenSize.width * 0.3,
              height: screenSize.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppText(
                    text:'Owó',
                    fontWeight: FontWeight.bold,
                    size: 34,
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_circle_fill, color: Colors.green, size: 30),
                    onPressed: () {
                      // Play sound
                    },
                  ),
                  addVerticalSpace(10),
                  const AppText(
                    text: '00:00:00', size: 24,
                  ),
                  addVerticalSpace(30),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: const Icon(Icons.mic, color: Colors.white, size: 30),
                      onPressed: () {
                        // Start recording
                      },
                    ),
                  ),
                  addVerticalSpace(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.stop, color: Colors.grey),
                        onPressed: () {
                          // Stop recording
                        },
                      ),
                      addVerticalSpace(20),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Upload recording
                        },
                        icon: Icon(Icons.upload),
                        label: Text('Upload'),
                      ),
                      addVerticalSpace(20),
                      IconButton(
                        icon: Icon(Icons.play_arrow, color: Colors.grey),
                        onPressed: () {
                          // Play recording
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}