import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_admin_panel_app/controllers/menuController.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/screens/loading_manager.dart';
import 'package:grocery_admin_panel_app/services/global_methods.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/button.dart';
import 'package:grocery_admin_panel_app/widgets/header.dart';
import 'package:grocery_admin_panel_app/widgets/side_menu.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadProductForm extends StatefulWidget {
  static const String routeName = "/UploadProductForm";
  const UploadProductForm({Key? key}) : super(key: key);

  @override
  State<UploadProductForm> createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController, _priceController;
  String _catValue = "Vegetables";

  int _groupValue = 1;
  bool isPiece = false;
  File? _pickedImage;
  var webImage;
  bool isClear = false;

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

  bool _isLoading = false;
  Future<void> _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) return;
    if (_pickedImage == null) {
      GlobalMethods.errorDialog(
          function: () {},
          title: 'Warning',
          hintText: 'Plz Select an Image',
          textButton: 'Oky',
          context: context);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final _uid = const Uuid().v4();
    _formKey.currentState!.save();

    final ref =
        FirebaseStorage.instance.ref().child('productsImages').child(_uid);
    if (ref.name.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final uploadFile = kIsWeb ? webImage : _pickedImage!.readAsBytesSync();
    final nameData = ref.putData(uploadFile);

    nameData.whenComplete(() async {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
          textColor: Colors.white,
          backgroundColor: Colors.grey.shade400,
          msg: "An Image has Been Added Succefully");
      await nameData.snapshot.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance.collection('products').doc(_uid).set({
          'id': _uid,
          'title': _titleController.text,
          'price': _priceController.text,
          'salePrice': 0.1,
          'imageUrl': value.toString(),
          'productCategoryName': _catValue,
          'isOnSale': false,
          'isPiece': isPiece,
          'createdAt': Timestamp.now(),
        }).then((value) {
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              fontSize: 16.0,
              textColor: Colors.white,
              backgroundColor: Colors.grey.shade400,
              msg: "An Product has Been Added Succefully");
        }).onError((error, stackTrace) {
          setState(() {
            _isLoading = false;
          });
          GlobalMethods.errorDialog(
              function: () {},
              title: 'Error',
              hintText: error,
              textButton: 'Ok',
              context: context);
        });
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethods.errorDialog(
            function: () {},
            title: 'Error',
            hintText: error,
            textButton: 'Ok',
            context: context);
      });
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
    });

    // fb.StorageReference storageReference =
    //     fb.storage().ref().child('productsImages').child(_uid + "png");

    // log(storageReference.fullPath);

    // final fb.UploadTaskSnapshot uploadTaskSnapshot =
    //     await storageReference.put(kIsWeb ? webImage : _pickedImage).future;
    // if (uploadTaskSnapshot.ref.name.isEmpty) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   GlobalMethods.errorDialog(
    //       function: () {},
    //       title: 'Error',
    //       hintText: 'Some Thing Went Wrong',
    //       textButton: 'Ok',
    //       context: context);
    //   return;
    // }

    // await uploadTaskSnapshot.ref.getDownloadURL().then((value) async {
    //   Fluttertoast.showToast(
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       fontSize: 16.0,
    //       textColor: Colors.white,
    //       backgroundColor: Colors.grey.shade400,
    //       msg: "An Image has Been Added Succefully");
    //   await FirebaseFirestore.instance.collection('products').doc(_uid).set({
    //     'id': _uid,
    //     'title': _titleController.text,
    //     'price': _priceController.text,
    //     'salePrice': 0.1,
    //     'imageUrl': value.toString(),
    //     'productCategoryName': _catValue,
    //     'isOnSale': false,
    //     'isPiece': isPiece,
    //     'createdAt': Timestamp.now(),
    //   }).then((value) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     Fluttertoast.showToast(
    //         toastLength: Toast.LENGTH_LONG,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         fontSize: 16.0,
    //         textColor: Colors.white,
    //         backgroundColor: Colors.grey.shade400,
    //         msg: "An Product has Been Added Succefully");
    //   }).onError((error, stackTrace) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     GlobalMethods.errorDialog(
    //         function: () {},
    //         title: 'Error',
    //         hintText: error,
    //         textButton: 'Ok',
    //         context: context);
    //   });
    // }).onError((error, stackTrace) {
    //   GlobalMethods.errorDialog(
    //       function: () {},
    //       title: 'erro',
    //       hintText: '$error',
    //       textButton: 'Oky',
    //       context: context);
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
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
      body: LoadingManager(
        isLoading: _isLoading,
        child: Row(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                            inputFormatters: <
                                                TextInputFormatter>[
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
                                        Container(
                                            color: _scafoldColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: _categoriesDropDown(
                                                  _cats.length, _cats),
                                            )),
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
                                        Row(
                                          children: [
                                            TextWidget(
                                                text: 'KG',
                                                color: utils.getColor,
                                                textSize: 16),
                                            Radio(
                                                activeColor: Colors.green,
                                                value: 1,
                                                groupValue: _groupValue,
                                                onChanged: onChanged),
                                            TextWidget(
                                                text: 'Peice',
                                                color: utils.getColor,
                                                textSize: 16),
                                            Radio(
                                                activeColor: Colors.green,
                                                value: 2,
                                                groupValue: _groupValue,
                                                onChanged: onChanged),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Image to be picked code is here
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: utils.getScreenSize.width > 650
                                          ? 350
                                          : utils.getScreenSize.width * 0.45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      child: _pickedImage == null
                                          ? dottedBorder(
                                              color: utils.getColor,
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: kIsWeb
                                                  ? Image.memory(
                                                      webImage,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.file(
                                                      _pickedImage!,
                                                      fit: BoxFit.fill,
                                                    ),
                                            ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                      child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () => _clear(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonsWidget(
                                    onPressed: _onPressedClear,
                                    text: 'Clear Form',
                                    icon: IconlyBold.danger,
                                    backGroundColor: Colors.red.shade300,
                                  ),
                                  ButtonsWidget(
                                    onPressed: () async {
                                      await _uploadForm();
                                    },
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
      ),
    );
  }

  //image picker
  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      var selected = File(image.path);
      setState(() {
        _pickedImage = selected;
      });
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
        _pickedImage = File('a');
      });
    }

    return;
  }

  //Dotted Border
  Widget dottedBorder({required Color color}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: color,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: color,
                    size: 50,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      _pickImage();
                    },
                    child: TextWidget(
                      text: 'Choose an image',
                      color: Colors.blue,
                      textSize: 16,
                    ),
                  ),
                ]),
          ),
        ),
      );

  //clear button
  _onPressedClear() {
    _priceController.clear();
    _titleController.clear();
    isPiece = false;
    _groupValue = 1;
    _clear();
  }

//clear image
  _clear() {
    setState(() {
      _pickedImage = null;
      webImage = Uint8List(8);
    });
  }

  // radoi onChanged
  onChanged(int? value) => setState(() {
        _groupValue = value!;
        if (_groupValue == 1) isPiece = false;
        if (_groupValue == 2) isPiece = true;
      });

  String? validatorTitle(String? value) {
    if (value!.isEmpty) return 'Plz enter a Title';
    return null;
  }

  String? validatorPrice(String? value) {
    if (value!.isEmpty) return 'Price is missed';
    return null;
  }

  List<DropdownMenuItem<String>> categories = [];

// here we genrate The drop down List
  Widget _categoriesDropDown(length, categoris) => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _catValue,
          onChanged: (value) => setState(() {
            _catValue = value!;
          }),
          hint: const Text("Select A Category"),
          items: _genrateListOfDropdownMenuItem(length, categoris),
        ),
      );

// here we genrate The List Of Items
  _genrateListOfDropdownMenuItem(length, categoris) =>
      List<DropdownMenuItem<String>>.generate(
          length,
          (index) => DropdownMenuItem(
                value: '${categoris[index]}',
                child: Text('${categoris[index]}'),
              ));
//List Of Categories
  final List<String> _cats = const [
    'Vegetables',
    'Fruits',
    'Grains',
    'Nuts',
    'Herbs',
    'Spices',
  ];
}
