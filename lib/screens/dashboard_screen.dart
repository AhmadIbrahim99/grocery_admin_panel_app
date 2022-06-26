import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/consts/constss.dart';
import 'package:grocery_admin_panel_app/controllers/menuController.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/button.dart';
import 'package:grocery_admin_panel_app/widgets/grid_product.dart';
import 'package:grocery_admin_panel_app/widgets/order_widget.dart';
import 'package:grocery_admin_panel_app/widgets/product_widget.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/header.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    Color color = Utils(context).getColor;
    final menuProvider = Provider.of<MenuController>(context);

    return Scaffold(
      body: SingleChildScrollView(
          controller: ScrollController(),
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(
                fct: () => menuProvider.controllDashBoardMenu(),
              ),
              TextWidget(
                text: 'Latest Products',
                color: color,
                textSize: 16,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ButtonsWidget(
                      onPressed: () {},
                      text: 'View All',
                      icon: Icons.store,
                      backGroundColor: Colors.blue,
                    ),
                    Spacer(),
                    ButtonsWidget(
                      onPressed: () {},
                      text: 'Add Product',
                      icon: Icons.add,
                      backGroundColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: defaultPadding,
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
              const SizedBox(
                height: defaultPadding,
              ),
              const OrdersList(),
            ],
          )),
    );
  }
}
