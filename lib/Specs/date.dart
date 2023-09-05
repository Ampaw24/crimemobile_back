// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'colors.dart';

class ContainerWithDatePicker extends StatefulWidget {
  @override
  _ContainerWithDatePickerState createState() =>
      _ContainerWithDatePickerState();
}

class _ContainerWithDatePickerState extends State<ContainerWithDatePicker> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 335,
            height: 45,
            decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                style: BorderStyle.solid,
                color: GREY,
                width: 1,
              ),
            ),
            child: TextField(
              controller: dateController,
              readOnly: true,
              style: TextStyle(fontWeight: FontWeight.w700, color: DEEPGREY),
              decoration: InputDecoration(
                  hintText: 'Choose Date',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  focusedBorder: InputBorder.none,
                  disabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ),
      ],
    );
  }
}
