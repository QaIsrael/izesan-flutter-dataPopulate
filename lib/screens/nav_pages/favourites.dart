import 'dart:async';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:izesan/locator.dart';
import 'package:izesan/services/error_state.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/toast.dart';
import 'package:izesan/viewmodels/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/local_store.dart';
import '../../widgets/app_text.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> with TickerProviderStateMixin{
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();

  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  late String _selectedItem;
  FocusNode _focusNode = FocusNode();
  TextEditingController _typeAheadController = TextEditingController();
  List<String> _items = ['English', 'Spanish', 'French', 'Igbo', 'Yoruba', 'Japanese', 'Hausa', 'Tiv'];


  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _selectedItem != null) {
        _typeAheadController.clear();
      }
    });
  }

  @override
  void dispose() {
    _typeAheadController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _showErrorMessage(event) {
    if(mounted){
      var error = Provider.of<SettingsModel>(context, listen: false);
      if (error.errorMessage != null) {
        return CustomToastQueue.showCustomToast(
            context,
            error.errorMessage.toString(),
            Icons.close,
            AppColors.redTint, const Duration(seconds: 5),
            'error'
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: 'Favourites',
            size: 24,
            fontWeight: FontWeight.bold,
          ),
          addVerticalSpace(16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: 16),
                    child: Stack(
                        children: [
                          TypeAheadField(
                            controller: _typeAheadController,
                            suggestionsCallback: (pattern) {
                              return _items; // return the whole list
                                  // .where((item) =>
                                  // item.toLowerCase().contains(pattern.toLowerCase())).toList(); // return selectedItem
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: AppText(text:suggestion),
                                tileColor: Theme.of(context).cardColor,
                              );
                            },
                            onSelected: (Object? value) {
                              setState(() {
                                _selectedItem = value.toString();
                                _typeAheadController.text = value.toString();
                              });
                            },
                      ),
                      const Positioned(
                          top: 12,
                          right: 15,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.primaryColor,
                          ))
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
