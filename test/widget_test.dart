// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:sleepcountdown_flutter/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:sleepcountdown_flutter/MyHomePage.dart';

void main() {
  testWidgets('Testing my widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final f0 = find.byType(MyHomePage);
    expect(f0, findsOneWidget);
    //get the UI value
    MyHomePage myHomePage = tester.firstWidget(f0);
    expect(myHomePage.title, 'Count down Flutter');
    // get the model value:
    MyHomePageState homePageState0 = tester.state(f0) as MyHomePageState;
    expect(homePageState0.daysToSleep, 0);

    final f1 = find.textContaining("The selected date value:"); //label
    expect(f1, findsOneWidget);

    final f2 = find.textContaining("Days needed to sleep:"); //label
    expect(f2, findsOneWidget);

    final f3 = find.text('Select a Day "to"'); // Button
    expect(f3, findsOneWidget);

    // ensure not found:
    final f4Not = find.byType(CupertinoDatePicker);
    expect(f4Not, findsNothing);

    // Tap the button
    await tester.tap(f3);
    // wait for showCupertinoModalPopup()
    await tester.pumpAndSettle();

    final f4 = find.byType(CupertinoDatePicker);
    expect(f4, findsOneWidget);

    CupertinoDatePicker cupertinoDatePicker = tester.firstWidget(f4);
    DateTime initialDateTime = cupertinoDatePicker.initialDateTime;

    int curYear = initialDateTime.year;
    final f5 = find.text(curYear.toString()).last;
    expect(f5, findsOneWidget);

    // scroll down the year
    await tester.dragFrom(tester.getCenter(f5), const Offset(0.0, -50.0));

    // wait for all
    await tester.pumpAndSettle();

    // get reference for check:
    MyHomePageState homePageState1year = tester.state(f0) as MyHomePageState;
    int selYear = homePageState1year.selectedDate.year;

    expect(curYear < selYear, true);

    expect(homePageState1year.daysToSleep >= 365, true);

    // find and press  the OK button
    final f6 = find.text('OK');
    expect(f6, findsOneWidget);
    await tester.tap(f6);

    // wait for all
    await tester.pumpAndSettle();

    final f4NoMore = find.byType(CupertinoDatePicker);
    expect(f4NoMore, findsNothing);
  });
}
