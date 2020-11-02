import 'package:flutter/material.dart';
import 'package:radio_basic/app/core/parse_server_instance.dart';
import 'package:radio_basic/app/core/injection_container.dart' as injection;
import 'package:radio_basic/app/features/home_page/presentation/pages/home_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ParseServerInstance.initParse();
  await injection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio Basic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageScreen(),
    );
  }
}
