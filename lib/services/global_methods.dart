import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class GlobalMethods {
  static navigateTo({required ctx, required name}) {
    Navigator.pushReplacementNamed(ctx, name);
  }

  static navigateToReplacement({required ctx, required name}) {
    Navigator.of(ctx)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => name));
  }

  static Future<void> warningDialog(
      {required function,
      required title,
      required hintText,
      required textButton,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(title)
              ],
            ),
            content: Text(hintText),
            actions: [
              TextButton(
                onPressed: () {
                  if (!Navigator.canPop(context)) return;

                  Navigator.pop(context);
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: "Cancel",
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () => function(),
                child: TextWidget(
                  color: Colors.red,
                  text: textButton,
                  textSize: 18,
                ),
              )
            ],
          );
        });
  }
}
