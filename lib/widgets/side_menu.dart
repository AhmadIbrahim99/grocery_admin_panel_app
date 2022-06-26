import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_admin_panel_app/inner_screens/all_products.dart';
import 'package:grocery_admin_panel_app/inner_screens/all_orders.dart';
import 'package:grocery_admin_panel_app/provider/dark_theme_provider.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/screens/main_screen.dart';
import 'package:grocery_admin_panel_app/services/dark_theme_pref.dart';
import 'package:grocery_admin_panel_app/services/global_methods.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getThem;
    final color = Utils(context).getColor;
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('assets/images/groceries.png'),
          ),
          DrawerListTile(
              title: 'Main',
              press: () {
                if (!Responsive.isDesktop(context)) Navigator.pop(context);

                GlobalMethods.navigateToReplacement(
                  ctx: context,
                  name: const MainScreen(),
                );
              },
              icon: Icons.home_filled),
          DrawerListTile(
              title: 'View All Products',
              press: () => GlobalMethods.navigateToReplacement(
                    ctx: context,
                    name: const AllProducts(),
                  ),
              icon: Icons.store),
          DrawerListTile(
              title: 'View All Order',
              press: () => GlobalMethods.navigateToReplacement(
                    ctx: context,
                    name: const AllOrders(),
                  ),
              icon: IconlyBold.bag2),
          SwitchListTile(
              title: const Text('Theme'),
              secondary: Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              value: theme,
              onChanged: (value) =>
                  setState(() => themeState.setDarkTheme = value))
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key, required this.title, required this.press, required this.icon})
      : super(key: key);
  final String title;
  final VoidCallback press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getThem;
    final color = theme ? Colors.white : Colors.black;
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        size: 18,
      ),
      title: TextWidget(text: title, color: color, textSize: 18),
    );
  }
}
