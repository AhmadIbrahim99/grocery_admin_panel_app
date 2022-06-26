import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/consts/constss.dart';
import 'package:grocery_admin_panel_app/widgets/order_list.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (ctx, index) => Column(
          children: const [
            OrdersWidget(),
            Divider(
              thickness: 3,
            )
          ],
        ),
      ),
    );
  }
}
