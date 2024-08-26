import 'dart:async';

import 'package:izesan/utils/helper_widgets.dart';

import 'package:izesan/widgets/izs_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/local_store.dart';
import '../../utils/validator.dart';
import '../../widgets/app_text.dart';
import '../../widgets/izs_flat_button.dart';
import '../../widgets/text_field.dart';

// import '../History/simple_list_dropdown.dart';
import '../settings_page/secure_account_dialog.dart';

class ManageClasses extends StatefulWidget {
  const ManageClasses({Key? key}) : super(key: key);

  @override
  _ManageClassesState createState() => _ManageClassesState();
}

class _ManageClassesState extends State<ManageClasses>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController filterSearchController = TextEditingController();

  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  late SecureDialogBoxHandler _securePaymentHandler;

  final ValueNotifier<List> classListData = ValueNotifier<List>([]);
  final _formkey = GlobalKey<FormState>();

  // late OverlayEntry overlayEntry;
  // late OverlayEntry overlayTransactionEntry;
  // late OverlayEntry searchOverlayEntry;
  // late Box<ClassesModel> classesBox;
  // late OrderHistory orderHistory;
  Future<List>? classesData;

  List classes = [];
  // Track the currently expanded index
  int _currentlyExpandedIndex = -1;
  FocusNode searchFocus = FocusNode();

  List orderData = [];
  List prevSearchedList = [];
  final ErrorState _errorStateCtrl = locator<ErrorState>();

  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  final List<ClassData> classList = [
    ClassData(
      number: 1,
      className: 'primary 5',
      language: 'Yoruba',
      arms: ['Primary 5a', 'Primary 5b'],
    ),
    ClassData(
      number: 2,
      className: 'primary',
      language: 'Igbo',
      arms: ['Primary 1a', 'Primary 1b'],
    ),
    ClassData(
      number: 3,
      className: 'primary two',
      language: 'Igbo',
      arms: ['Primary 2a', 'Primary 2b'],
    ),
    ClassData(
      number: 4,
      className: 'primary four',
      language: 'Hausa',
      arms: ['Primary 4a', 'Primary 4b'],
    ),
    ClassData(
      number: 5,
      className: 'Free Trial',
      language: 'Yoruba',
      arms: ['Free Trial 1', 'Free Trial 2'],
    ),
  ];

  int _page = 1;
  int _numberPages = 1;
  bool isLoadingMore = false;
  late List<bool> _expanded;
  late ValueNotifier<List<bool>> _isExpandedNotifier;


  @override
  void initState() {
    super.initState();
    _expanded = List.generate(classList.length, (_) => false);
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);

    _isExpandedNotifier = ValueNotifier(List.generate(classList.length, (_) => false));
    // if (!mounted) return;
    // classesData = Future.delayed(Duration.zero, () {
    //   return getClasses().then((value) {
    //     getClassData();
    //     return value;
    //   });
    // });

    _scrollController.addListener(_scrollListener);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),

      // Adjust the duration as needed
    );
  }

  @override
  void dispose() {
    searchFocus.dispose();
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  _showErrorMessage(event) {
    // if(mounted){
    //   var error = Provider.of<ClassesModel>(context, listen: false);
    //   if (error.errorMessage != null) {
    //     return CustomToastQueue.showCustomToast(
    //       context,
    //       error.errorMessage.toString(),
    //       Icons.close,
    //       AppColors.redTint, const Duration(seconds: toastDuration),
    //       'error'
    //     );
    //   }
    // }
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
                          const IzsHeaderText(text: 'Class Configuration'),
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
                                    onFocus: searchFocus,
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
                      )),
                  addVerticalSpace(16),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        IzsFlatButton(
                          width: 120,
                          height: 40,
                          isResponsive: false,
                          color: AppColors.warningColor,
                          text: 'Add Class',
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
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        if (_currentlyExpandedIndex != index) {
                          // Collapse the previously expanded panel
                          if (_currentlyExpandedIndex != -1) {
                            classList[_currentlyExpandedIndex].isExpanded = false;
                          }
                          // Expand the tapped panel
                          classList[index].isExpanded = true;
                          _currentlyExpandedIndex = index;
                        } else {
                        // Collapse the panel if it's already expanded
                          classList[index].isExpanded = false;
                        if (!isExpanded) {
                          _currentlyExpandedIndex = -1;
                        }
                      }
                    });
                    },
                    children: classList.map<ExpansionPanel>((ClassData data) {
                      // int index = classList.indexOf(data);
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Column(
                            children: [
                              ListTile(
                                leading: AppText(text:'${data.number} '),
                                title: AppText(text:data.className),
                                trailing: SizedBox(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(text:data.language),
                                      addHorizontalSpace(24),
                                      IzsFlatButton(
                                        width: 120,
                                        height: 40,
                                        isResponsive: false,
                                        color: AppColors.warningColor,
                                        text: 'Delete Class',
                                        textSize: 14,
                                        textColor: Colors.white,
                                        borderRadius: 8,
                                        onPressed: () {
                                          // _handleLogin();
                                        },
                                        borderColor: Theme.of(context).cardColor,
                                        borderWidth: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          );
                        },
                        body: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:32.0, right: 64),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const AppText(text: 'Class Arm', color: Colors.green,),
                                  IzsFlatButton(
                                    width: 150,
                                    height: 40,
                                    isResponsive: false,
                                    color: AppColors.warningCaption,
                                    text: 'Add Class Arm',
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
                            ),
                            ...data.arms.map((arm) => ListTile(
                              title: Padding(
                                padding:
                                const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  arm,
                                  style: const TextStyle(
                                      color: Colors.green),
                                ),
                              ),
                            )).toList(),
                          ]
                        ),

                        canTapOnHeader: true,
                        isExpanded: data.isExpanded//expandedList[index],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///onChange call to function to filter through the list and search for meter
  Future<void> _classesSearch(String search) async {
    // if (search.isEmpty) {
    //   setState(() => classes = orderData);
    // } else {
    //   final results = orderData
    //       .where((item) => item.name!.contains(search))
    //       .toList();
    //   setState(() => classes = results);
    // }
  }

  void toggleLoadingIndicator() {
    if (isLoadingMore) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Widget buildLoadingIndicator() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final slidePosition = Tween<Offset>(
          begin: const Offset(0, -1), // Slide in from the top
          end: const Offset(0, 0),
        ).animate(_animationController);

        final fadeValue = Tween<double>(
          begin: 0.0, // Fully transparent
          end: 1.0,
        ).animate(_animationController);

        return SlideTransition(
          position: slidePosition,
          child: FadeTransition(
            opacity: fadeValue,
            child: isLoadingMore
                ? Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.all(2.0),
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  }

  void _gotoHistoryDetail(id) async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      HapticFeedback.heavyImpact().then((value) async {
        setState(() {
          isLoadingMore = !isLoadingMore;
          toggleLoadingIndicator();
          _page++; // increase the page number
        });
        await getClassesPagination(); // fetch the next page of data
        setState(() {
          isLoadingMore = false;
        });
      });
    }
  }

  Future getClassesPagination() async {}

  // Future<dynamic> getClasses() async {
  //   Box<ClassesModel> historyBox =
  //   await Hive.openBox<ClassesModel>('classes_box_list');
  //
  //   List<ClassesModel> data = historyBox.values.toList();
  //
  //   if (historyBox.values.isEmpty) {
  //     return getClassData();
  //   }
  //   if (historyBox.values.toList().isNotEmpty) {
  //     setState(() {
  //       classes = data;
  //       orderData = data;
  //     });
  //     return data;
  //   }
  // }

  // Future openBox() async {
  //   historyBox = await Hive.openBox<ClassesModel>('history_box_list');
  // }

  Future getClassData() async {
    // isLoadingMore = false;
    // final res = await context.read<ManageClassModel>().getUserTransaction(_page);
    // if(res == null || res.isEmpty){
    //   return classListData.value = <ClassesModel>[];
    // }
    // if (res != null) {
    //   if(res['data'].isEmpty){
    //     return classListData.value = <ClassesModel>[];
    //   }
    //   setState(() {
    //     _numberPages = res['meta']['pages'];
    //   });
    //   putClassesData(res['data']);
    //   final updatedData = await getClasses();
    //   classListData.value = updatedData ?? <ClassesModel>[];
    //   return updatedData;
    // }

    // List data = <dynamic>[
    //   {'name': 'dih'},
    //   {'name': 'dih'},
    //   {'name': 'dih'},
    //   {'name': 'dih'},
    //   {'name': 'dih'},
    //   {'name': 'dih'},
    //   {'name': 'dih'},
    // ];
    // setState(() {
    //   classes = data;
    // });
    // return classListData.value = data;
  }

// Future getClasses() async {
// if (_numberPages > 1 && _numberPages >= _page) {
//   final res = await context.read<ManageClassModel>().getUserTransaction(_page);
//   if(res == null) {
//     return classListData.value = <ClassesModel>[];
//   }
//   if(res != null){
//     //Filter data before adding the new data
//     filterNewPaginatedData(res);
//     // putPaginationClassData(res['data']);
//   }
// }

//   List data = <dynamic>[{'name':'dih'},{'name':'dih'}, {'name':'dih'},];
//   setState((){
//     classes = data;
//   });
//   return classListData.value = data;
// }
//
// Future<void> putClassesData(data) async {
//   // historyBox = await Hive.openBox<ClassesModel>('classes_box_list'); // Initialize the variable
//   // await historyBox.clear();
//   // List<ClassesModel> histData = [];
//   //
//   // try {
//   //   for (var item in orderHistory) {
//   //     ClassesModel classesModel = ClassesModel(
//   //       id: item['id'],
//   //       email: item['email'],
//   //       phone: item['phone'],
//   //       name: item['name'],
//   //     );
//   //     histData.add(ClassesModel);
//   //   }
//   //   historyBox.addAll(histData);
//   //   await getClasses();
//   // } catch (e, stackTrace) {
//   //   if (kDebugMode) {
//   //     print('Error saving data to Hive: $e');
//   //     print(stackTrace);
//   //   }
//   // }
// }
//
// Future<void> putPaginationClassData(orderHistory) async {
//   // historyBox = await Hive.openBox<ClassesModel>('history_box_list'); // Initialize the variable
//   // List<ClassesModel> historyDataList = [];
//   //
//   // try {
//   //   for (var item in orderHistory) {
//   //     ClassesModel classesModel = ClassesModel(
//   //       id: item['id'],
//   //       email: item['email'],
//   //       phone: item['phone'],
//   //       name: item['name'],
//   //
//   //     );
//   //     historyDataList.add(ClassesModel);
//   //   }
//   //   List<dynamic> existingRecords = historyBox.values.toList();
//   //   //Check and compare existing data with new data
//   //   final filteredData = historyDataList.where((record) => !existingRecords.contains(record)).toList();
//   //   await historyBox.addAll(filteredData);
//   //   await getClasses();
//   // } catch (e, stackTrace) {
//   //   print('Error saving data to Hive: $e');
//   //   print(stackTrace);
//   // }
// }
//
//
// void _tabRefreshList() {
// }
//
// Future<void> _refreshList() async {
// }
}

class ClassData {
  final int number;
  final String className;
  final String language;
  final List<String> arms;
  bool isExpanded;


  ClassData({
    this.isExpanded = false,
    required this.number,
    required this.className,
    required this.language,
    required this.arms,
  });
}
