import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/card.dart';
import 'package:izesan/widgets/line.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../../widgets/izs_header_text.dart';

class ContactPreferences extends StatefulWidget {
  const ContactPreferences({Key? key}) : super(key: key);

  @override
  State<ContactPreferences> createState() => _ContactPreferencesState();
}

class _ContactPreferencesState extends State<ContactPreferences> {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  bool saveSMS = true;
  bool saveEmail = true;
  bool saveNewsletters = true;

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: const Text("This is a Custom Toast"),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addVerticalSpace(20),
                        IzsHeaderText(
                            text: remoteConfig
                                .getString('contact_pref_title_text')),
                        addVerticalSpace(32),
                        AppLargeText(
                          text: remoteConfig.getString('receive_token_text'),
                          size: 14,
                        ),
                        addVerticalSpace(19),
                        SizedBox(
                          width: double.maxFinite,
                          // height: 120,
                          child: ColoredCard(
                            borderColor: Theme.of(context).primaryColor,
                            borderRadius: 16,
                            border: 0.0,
                            child: Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 58,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                              text: remoteConfig.getString(
                                                  'sms_contact_text')),
                                          Switch(
                                              activeColor:
                                                  AppColors.primaryColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  saveSMS = true;
                                                });
                                              },
                                              value: saveSMS)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Line(
                                    width: double.maxFinite,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                              text: remoteConfig.getString(
                                                  'email_contact_text')),
                                          Switch(
                                              activeColor:
                                                  AppColors.primaryColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  saveEmail = true;
                                                });
                                              },
                                              value: saveEmail)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        addVerticalSpace(31),
                        AppLargeText(
                          text: remoteConfig.getString('newsletters_text'),
                          size: 14,
                        ),
                        addVerticalSpace(16),
                        SizedBox(
                          width: double.maxFinite,
                          // height: 120,
                          child: ColoredCard(
                            borderColor: Theme.of(context).primaryColor,
                            borderRadius: 16,
                            border: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(12)),
                              height: 60,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 58,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                              text: remoteConfig.getString(
                                                  'email_contact_text')),
                                          Switch(
                                              activeColor:
                                                  AppColors.primaryColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  saveNewsletters = true;
                                                });
                                              },
                                              value: saveNewsletters)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // const Spacer(),
                        // IzsFlatButton(
                        //     width: double.maxFinite,
                        //     borderColor: AppColors.primaryColor,
                        //     text:
                        //         remoteConfig.getString('save_changes_btn_text'),
                        //     textSize: 14,
                        //     onPressed: () {},
                        //     borderRadius: 12)
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
