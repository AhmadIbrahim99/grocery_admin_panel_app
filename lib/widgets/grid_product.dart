import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/product_widget.dart';

import '../consts/constss.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget(
      {Key? key, this.crossAxisCount = 4, this.childAspectRatio = 1})
      : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  //final bool isInMain;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) => const ProductWidget(),
      itemCount: 4,
    );
  }
}
