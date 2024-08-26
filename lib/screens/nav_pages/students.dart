import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/validator.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:izesan/widgets/izs_header_text.dart';
import 'package:izesan/widgets/text_field.dart';

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController filterSearchController = TextEditingController();
  final ValueNotifier<List> studentListData = ValueNotifier<List>([]);
  final _formkey = GlobalKey<FormState>();
  int _page = 1;
  int _numberPages = 1;
  bool isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  // late SecureDialogBoxHandler _securePaymentHandler;

  final List<StudentData> studentList = [
    StudentData(
      username: 'Dihweng',
      language: 'Igbo',
      studentId: 'TE/4824',
      studentClass: 'Primary',
      classArm: 'Primary 1a',
    ),
    StudentData(
      username: 'Adebayo',
      language: 'Yoruba',
      studentId: 'TE/4513',
      studentClass: 'Yoruba Primary 5',
      classArm: 'Yoruba Primary 5',
    ),
    StudentData(
      username: 'Juse',
      language: 'Yoruba',
      studentId: 'TE/4272',
      studentClass: 'Primary 5',
      classArm: 'ARM 1',
    ),
    StudentData(
      username: 'Bako',
      language: 'Yoruba',
      studentId: 'TE/4271',
      studentClass: 'Primary 5',
      classArm: 'ARM 1',
    ),
    StudentData(
      username: 'Ad',
      language: 'Yoruba',
      studentId: 'TE/4125',
      studentClass: 'Primary 5',
      classArm: 'ARM 1',
    ),
    StudentData(
      username: 'Demo',
      language: 'Yoruba',
      studentId: 'TE/3465',
      studentClass: 'Free Trial',
      classArm: 'Free Trial',
    ),
    StudentData(
      username: 'Ayo',
      language: 'Yoruba',
      studentId: 'TE/3463',
      studentClass: 'Primary 5',
      classArm: 'Yorùbá',
    ),
    StudentData(
      username: 'Yoruba Jr Class',
      language: 'Hausa',
      studentId: 'TE/3448',
      studentClass: 'New Primary 2 B',
      classArm: 'New Primary 2 B',
    ),
    StudentData(
      username: 'Campbell',
      language: 'Igbo',
      studentId: 'TE/3207',
      studentClass: 'Primary 5',
      classArm: 'ARM 1',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth > 800 ? 800 : screenWidth * 0.9;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: screenWidth * 0.9,
                      height: 50,
                      margin: const EdgeInsets.only(left: 24, top: 24.0, right: 24.0),
                      padding: const EdgeInsets.only(left: 24, right: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const IzsHeaderText(text: 'Students Configuration'),
                          Flexible(
                            child: Semantics(
                              label: 'Search input field for classes',
                              child: SizedBox(
                                height: 36,
                                width: screenWidth * 0.4,
                                child: IzsTextField(
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    textController: searchController,
                                    autoFocus: false,
                                    validate: Validator.password,
                                    isPassword: false,
                                    hintText: 'Search',
                                    height: 35,
                                    // onFocus: searchFocus,
                                    suffixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey.shade500,
                                        size: 18
                                    ),
                                    onChanged: (value) {
                                      // _orderHistorySearch(value!);
                                    }),
                              ),
                            ),
                          ),

                        ],
                      )
                  ),
                  // addVerticalSpace(24),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IzsFlatButton(
                              width: 120,
                              height: 40,
                              isResponsive: false,
                              color: AppColors.warningColor,
                              text: 'Add Student',
                              textSize: 14,
                              textColor: Colors.white,
                              borderRadius: 8,
                              onPressed: () {
                                // _handleLogin();
                              },
                              borderColor: Theme.of(context).cardColor,
                              borderWidth: 0,
                            ),
                            addHorizontalSpace(24),
                            IzsFlatButton(
                              width: 150,
                              height: 40,
                              isResponsive: false,
                              color: AppColors.warningCaption,
                              text: 'Bulk Registration',
                              textSize: 14,
                              textColor: Colors.white,
                              borderRadius: 8,
                              onPressed: () {
                                // _handleGotoFreeVersion();
                              },
                              borderColor: AppColors.warningCaption,
                              borderWidth: 0,
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.download_for_offline_sharp, color: Colors.orange),
                          onPressed: () {
                            // Handle download action
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // Header Row
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(child: AppText(text: 'USERNAME', fontWeight: FontWeight.bold)),
                        Expanded(child: AppText(text: 'LANGUAGE', fontWeight: FontWeight.bold)),
                        Expanded(child: AppText(text: 'STUDENT ID', fontWeight: FontWeight.bold)),
                        Expanded(child: AppText(text: 'CLASS', fontWeight: FontWeight.bold)),
                        Expanded(child: AppText(text: 'CLASS ARM', fontWeight: FontWeight.bold)),
                        SizedBox(width: 180),
                      ],
                    ),
                  ),
                  const Divider(),
                  ...studentList.map((student) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                    child: Row(
                      children: [
                        Expanded(child: AppText(text: student.username)),
                        Expanded(child: AppText(text: student.language)),
                        Expanded(child: AppText(text: student.studentId)),
                        Expanded(child: AppText(text: student.studentClass)),
                        Expanded(child: AppText(text: student.classArm)),
                        SizedBox(
                          width: 180,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.file_download, color: Colors.orange),
                                onPressed: () {
                                  // Handle download action
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  // Handle edit action
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Handle delete action
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentData {
  final String username;
  final String language;
  final String studentId;
  final String studentClass;
  final String classArm;

  StudentData({
    required this.username,
    required this.language,
    required this.studentId,
    required this.studentClass,
    required this.classArm,
  });
}
