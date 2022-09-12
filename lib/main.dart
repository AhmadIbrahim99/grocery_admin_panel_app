import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/controllers/menuController.dart';
import 'package:grocery_admin_panel_app/inner_screens/add_product.dart';
import 'package:grocery_admin_panel_app/provider/dark_theme_provider.dart';
import 'package:grocery_admin_panel_app/screens/dashboard_screen.dart';
import 'package:grocery_admin_panel_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  final Future<FirebaseApp> _firebaseInitilization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitilization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text('An Error occured'),
                ),
              ),
            );
          }
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
                routes: {
                  UploadProductForm.routeName: (context) =>
                      const UploadProductForm(),
                },
              ),
            ),
          );
        });
  }
}
