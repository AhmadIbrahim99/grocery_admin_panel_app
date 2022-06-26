import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/controllers/menuController.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/grid_product.dart';
import 'package:grocery_admin_panel_app/widgets/header.dart';
import 'package:grocery_admin_panel_app/widgets/order_widget.dart';
import 'package:grocery_admin_panel_app/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final menuControllerProvider = Provider.of<MenuController>(context);

    return Scaffold(
      key: menuControllerProvider.getOrdersScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) const Expanded(child: SideMenu()),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  Header(
                    fct: () => menuControllerProvider.controllAllOrdersMenu(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: OrdersList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
