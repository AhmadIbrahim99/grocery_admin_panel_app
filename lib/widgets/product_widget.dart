import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';

import '../services/utils.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png',
                        fit: BoxFit.fill,
                        height: size.width * 0.12,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                value: 1,
                                child: const Text("Edit"),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                value: 2,
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ])
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: "\$1.99",
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                      visible: true,
                      child: Text(
                        "\$3.89",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: color,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextWidget(
                      text: "1Kg",
                      color: color,
                      textSize: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: "title",
                  color: color,
                  textSize: 24,
                  isTilte: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
