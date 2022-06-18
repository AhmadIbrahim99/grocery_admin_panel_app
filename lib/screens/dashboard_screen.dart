import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/consts/constss.dart';
import 'package:grocery_admin_panel_app/controllers/menuController.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/grid_product.dart';
import 'package:grocery_admin_panel_app/widgets/product_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/header.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final menuProvider = Provider.of<MenuController>(context);

    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Header(
                fct: () => menuProvider.controllDashBoardMenu(),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Responsive(
                        mobile: ProductGridWidget(
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                          crossAxisCount: size.width < 650 ? 2 : 4,
                        ),
                        desktop: ProductGridWidget(
                          childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ],
          )),
    );
  }
}
