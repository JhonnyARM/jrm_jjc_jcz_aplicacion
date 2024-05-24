import 'package:flutter/material.dart';
import '../switch_widget.dart';
import '../time_picker_widget.dart';

class SwitchTimePickerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch y TimePicker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchWidget(),
            SizedBox(height: 20),
            TimePickerWidget(),
          ],
        ),
      ),
    );
  }
}