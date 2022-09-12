import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gridScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _editProductScaffoldKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _getOrdersScaffoldKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _addProductScaffoldKey =
      GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;
  GlobalKey<ScaffoldState> get getGridScaffoldKey => _gridScaffoldKey;
  GlobalKey<ScaffoldState> get getAddProductScaffoldKey =>
      _addProductScaffoldKey;
  GlobalKey<ScaffoldState> get getOrdersScaffoldKey => _getOrdersScaffoldKey;

  GlobalKey<ScaffoldState> get getEditProductscaffoldKey =>
      _editProductScaffoldKey;

  void controllDashBoardMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void controllProductsMenu() {
    if (!_gridScaffoldKey.currentState!.isDrawerOpen) {
      _gridScaffoldKey.currentState!.openDrawer();
    }
  }

  void controllAddProductsMenu() {
    if (!_addProductScaffoldKey.currentState!.isDrawerOpen) {
      _addProductScaffoldKey.currentState!.openDrawer();
    }
  }

  void controlEditProductsMenu() {
    if (!_editProductScaffoldKey.currentState!.isDrawerOpen) {
      _editProductScaffoldKey.currentState!.openDrawer();
    }
  }

  void controllAllOrdersMenu() {
    if (!_getOrdersScaffoldKey.currentState!.isDrawerOpen) {
      _getOrdersScaffoldKey.currentState!.openDrawer();
    }
  }
}
