import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/app_text.dart';
import '../../widgets/izs_checkbox.dart';
import '../../widgets/izs_flat_button.dart';

class MyListView extends StatelessWidget {
  final List<dynamic> data;
  final double borderRadius = 8.0;

  MyListView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> keys = data.isNotEmpty ? data[0].keys.where((key) => key != 'id').toList() : [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: data.length + 2, // +1 for the header and +1 for the footer
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildHeader(keys);
            } else if (index == data.length + 1) {
              return _buildFooter();
            } else {
              return _buildRow(data[index - 1], keys);
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader(List<String> keys) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.captionColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(0),
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(0),
        ),
        border: Border.all(color: Colors.grey, width: 2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...keys.map((key) => Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: AppText(text: key),
            ),
          )).toList(),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AppText(text: 'Attendance'),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(dynamic rowData, List<String> keys) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...keys.map((key) => Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: Text(rowData[key].toString()),
            ),
          )).toList(),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: IzsCheckBox(
              isChecked: true,
              width: 50,
              size: 20,
              iconSize: 8,
              selectedColor: AppColors.primaryColor,
              onChange: (value) {
                // Handle checkbox state change
              },
              cardText: '',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.captionColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          bottomLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(0.0),
          bottomRight: Radius.circular(borderRadius),
        ),
        border: Border.all(color: Colors.grey, width: 2.0),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IzsCheckBox(
                isChecked: true,
                size: 20,
                iconSize: 8,
                width: 80,
                selectedColor: AppColors.primaryColor,
                onChange: (value) {
                  // Handle checkbox state change
                },
                cardText: 'Check All',
              ),
              IzsFlatButton(
                width: 120,
                height: 40,
                isResponsive: false,
                color: AppColors.primaryColor,
                text: 'Submit',
                textSize: 20,
                textColor: Colors.black,
                borderRadius: 8,
                onPressed: () {
                  // Handle button press
                },
                borderColor: AppColors.primaryColor,
                borderWidth: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
