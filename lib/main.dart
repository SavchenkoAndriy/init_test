import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/data_state.dart';
import '../state/navigation_state.dart';
import '../ui/navigation.dart';
import 'constants/page_route.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<NavigationState>(
          create: (_) => NavigationState(initPageName: CustomPageRoute.pageNames[0]),
        ),
        ChangeNotifierProvider<DataState>(create: (_) => DataState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Navigation(),
    );
  }
}
