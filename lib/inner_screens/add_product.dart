import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_admin_panel_app/controllers/menuController.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/button.dart';
import 'package:grocery_admin_panel_app/widgets/header.dart';
import 'package:grocery_admin_panel_app/widgets/side_menu.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class UploadProductForm extends StatefulWidget {
  static const String routeName = "/UploadProductForm";
  const UploadProductForm({Key? key}) : super(key: key);

  @override
  State<UploadProductForm> createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController, _priceController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    var utils = Utils(context);
    final _scafoldColor = Theme.of(context).scaffoldBackgroundColor;
    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scafoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: utils.getColor,
          width: 1.0,
        ),
      ),
    );

    final _menuProvider = Provider.of<MenuController>(context);
    return Scaffold(
      key: _menuProvider.getAddProductScaffoldKey,
      drawer: const SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SideMenu(),
            ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Header(
                    fct: () => _menuProvider.controllAddProductsMenu(),
                    title: 'Add product',
                    showText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: utils.getScreenSize.width > 650
                        ? 650
                        : utils.getScreenSize.width,
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextWidget(
                            text: 'Product title',
                            color: utils.getColor,
                            textSize: 16,
                            isTilte: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _titleController,
                            key: const ValueKey(
                              'Title',
                            ),
                            validator: validatorTitle,
                            decoration: inputDecoration,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: 'Price in \$*',
                                        color: utils.getColor,
                                        textSize: 16,
                                        isTilte: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: TextFormField(
                                          controller: _priceController,
                                          key: const ValueKey('Price \$'),
                                          keyboardType: TextInputType.number,
                                          validator: validatorPrice,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r'[0-9.]',
                                              ),
                                            ),
                                          ],
                                          decoration: inputDecoration,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextWidget(
                                        text: 'Product category',
                                        color: utils.getColor,
                                        textSize: 16,
                                        isTilte: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextWidget(
                                        text: 'Measure unit',
                                        color: utils.getColor,
                                        textSize: 16,
                                        isTilte: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //radio button code here
                                    ],
                                  ),
                                ),
                              ),
                              //Image to be picked code is here
                              Expanded(
                                flex: 4,
                                child: Container(
                                  color: Colors.red,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: FittedBox(
                                    child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: TextWidget(
                                        text: 'Clear',
                                        color: Colors.red,
                                        textSize: 16,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: TextWidget(
                                        text: 'Update Image',
                                        color: Colors.blue,
                                        textSize: 16,
                                      ),
                                    ),
                                  ],
                                )),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              18.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonsWidget(
                                  onPressed: () {},
                                  text: 'Clear Form',
                                  icon: IconlyBold.danger,
                                  backGroundColor: Colors.red.shade300,
                                ),
                                ButtonsWidget(
                                  onPressed: () => _uploadForm(),
                                  text: 'Upload',
                                  icon: IconlyBold.upload,
                                  backGroundColor: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validatorTitle(String? value) {
    if (value!.isEmpty) return 'Plz enter a Title';
    return null;
  }

  String? validatorPrice(String? value) {
    if (value!.isEmpty) return 'Price is missed';
    return null;
  }
}
