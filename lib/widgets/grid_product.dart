import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/product_widget.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';

import '../consts/constss.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget(
      {Key? key,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      this.isInMain = true})
      : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMain;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final color = Utils(context).getColor;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                ),
                itemBuilder: (context, index) =>
                    ProductWidget(id: snapshot.data!.docs[index]['id']),
                itemCount: isInMain && snapshot.data!.docs.length > 4
                    ? 4
                    : snapshot.data!.docs.length,
              );
            } else {
              return Center(
                child: TextWidget(
                    text: 'Your Store Is Empty', color: color, textSize: 18.0),
              );
            }
          }
          return Center(
            child: TextWidget(
                text: 'Some Thing Wrong', color: color, textSize: 18.0),
          );
        });
  }
}
