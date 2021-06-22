import 'package:covid_prediction_app_ios/utils/enums.dart';
import 'package:covid_prediction_app_ios/view/pages/table_page.dart';
import 'package:covid_prediction_app_ios/viewmodels/table_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets("when radio button is pressed table content is changing ",
      (WidgetTester tester) async {
    // ASSEMBLE
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: TablePage(),
        ),
      ),
    );

    final radioButton1 =
        find.byKey(Key(formatTotalCasesEnum(TotalCases.Infected)));
    final radioButton2 =
        find.byKey(Key(formatTotalCasesEnum(TotalCases.Recovered)));
    final radioButton3 =
        find.byKey(Key(formatTotalCasesEnum(TotalCases.Deaths)));

    final list = find.byElementType(ListView);
    expect(list, findsOneWidget);
  });
}
