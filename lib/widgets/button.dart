import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_admin_panel_app/consts/constss.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/widgets/text_widget.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.backGroundColor,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: backGroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding * 1.5,
            vertical: defaultPadding / (Responsive.isDesktop(context) ? 1 : 2),
          ),
        ),
        onPressed: () => onPressed(),
        icon: Icon(
          icon,
          size: 20,
        ),
        label: Text(text),
      );
}
