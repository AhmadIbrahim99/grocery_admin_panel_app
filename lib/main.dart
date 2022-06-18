import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/controllers/menuController.dart';
import 'package:grocery_admin_panel_app/provider/dark_theme_provider.dart';
import 'package:grocery_admin_panel_app/screens/dashboard_screen.dart';
import 'package:grocery_admin_panel_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvicer = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvicer.setDarkTheme =
        await themeChangeProvicer.darkThemPrefs.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeChangeProvicer),
        ChangeNotifierProvider(create: (_) => MenuController()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          title: 'Admin panel',
          debugShowCheckedModeBanner: false,
          theme: Styels.themeData(themeProvider.getDarkTheme, context),
          home: const MainScreen(),
        ),
      ),
    );
  }
}
