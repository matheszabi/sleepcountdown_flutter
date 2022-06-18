import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  int daysToSleep = 0;
  DateFormat formatter = DateFormat("dd.MMMM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10), //apply padding to some sides only
                  child: Text(
                    'The selected date value:\n${formatter.format(selectedDate)}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                    child: const Text('Select a Day "to"'),
                    onPressed: () {
                      if (kDebugMode) {
                        print('Chooser selected');
                      }
                      showDatePicker();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 50), //apply padding to some sides only
                  child: Text(
                    'Days needed to sleep:\n $daysToSleep',
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
        ));
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != selectedDate) {
                  setState(() {
                    selectedDate = value;
                    DateTime endOfSelDay = DateTime(selectedDate.year,
                        selectedDate.month, selectedDate.day, 23, 59, 59, 999);
                    Duration difference =
                        endOfSelDay.difference(DateTime.now());

                    daysToSleep = difference.inDays;
                  });
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2022,
              maximumYear: 2030,
            ),
          );
        });
  }
}
