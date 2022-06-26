import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getThem;
    Color color = theme ? Colors.white : Colors.black;
    Size size = Utils(context).getScreenSize;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Flexible(
            flex: size.width < 650 ? 3 : 1,
            child: Image.network(
                'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png',
                fit: BoxFit.fill),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  text: '12x For \$19.9',
                  color: color,
                  textSize: 16,
                  isTilte: true,
                ),
                FittedBox(
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'By',
                        color: Colors.blue,
                        textSize: 16,
                        isTilte: true,
                      ),
                      TextWidget(
                        text: '  Hadi K.',
                        color: color,
                        textSize: 14,
                        isTilte: true,
                      ),
                    ],
                  ),
                ),
                const Text("20/03/2022"),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
