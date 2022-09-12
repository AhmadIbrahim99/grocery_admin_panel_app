import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/screens/loading_manager.dart';
import 'package:grocery_admin_panel_app/services/global_methods.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../inner_screens/edit_prod.dart';
import '../services/utils.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isLoading = false;
  String title = '';
  String productCat = '';
  String imageUrl = '';
  double price = 0.0;
  double salePrice = 0.0;
  bool isOnSale = false;
  bool isPiece = false;

  @override
  void initState() {
    getProductData();
    super.initState();
  }

  Future<void> getProductData() async {
    if (widget.id.isEmpty) return;
    setState(() {
      _isLoading = true;
    });
    final DocumentSnapshot productDoc = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.id)
        .get();
    if (!productDoc.exists) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    title = productDoc.get('title');
    productCat = productDoc.get('productCategoryName');
    price = productDoc.get('price');
    salePrice = productDoc.get('salePrice');
    imageUrl = productDoc.get('imageUrl');
    isPiece = productDoc.get('isPiece');
    isOnSale = productDoc.get('isOnSale');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LoadingManager(
        isLoading: _isLoading,
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor.withOpacity(0.6),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProductScreen(
                    id: widget.id,
                    title: title,
                    price: price,
                    salePrice: salePrice,
                    productCat: productCat,
                    imageUrl: imageUrl,
                    isOnSale: isOnSale,
                    isPiece: isPiece,
                  ),
                ),
              );
            },
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
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                          height: size.width * 0.12,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                        text: "\$$salePrice",
                        color: color,
                        textSize: 18,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Visibility(
                        visible: true,
                        child: Text(
                          "\$$price",
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
                    text: title,
                    color: color,
                    textSize: 24,
                    isTilte: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
