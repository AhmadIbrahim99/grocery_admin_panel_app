import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/controllers/menuController.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/grid_product.dart';
import 'package:grocery_admin_panel_app/widgets/header.dart';
import 'package:grocery_admin_panel_app/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final menuControllerProvider = Provider.of<MenuController>(context);

    return Scaffold(
      key: menuControllerProvider.getGridScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) const Expanded(child: SideMenu()),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Header(
                    fct: () => menuControllerProvider.controllProductsMenu(),
                    title: 'All products',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Responsive(
                    mobile: ProductGridWidget(
                      isInMain: false,
                      crossAxisCount: size.width < 650 ? 2 : 4,
                      childAspectRatio:
                          size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                    ),
                    desktop: ProductGridWidget(
                      isInMain: false,
                      childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
