import 'package:flutter/material.dart';
import 'package:grocery_admin_panel_app/responsive.dart';
import 'package:grocery_admin_panel_app/screens/main_screen.dart';
import 'package:grocery_admin_panel_app/services/utils.dart';
import 'package:grocery_admin_panel_app/widgets/side_menu.dart';

class Header extends StatelessWidget {
  const Header(
      {Key? key, required this.title, required this.fct, this.showText = true})
      : super(key: key);
  final Function fct;
  final String title;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getThem;
    final color = Utils(context).getColor;
    final size = Utils(context).getScreenSize;
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: () => fct(),
            icon: const Icon(
              Icons.menu,
            ),
          ),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        if (Responsive.isDesktop(context))
          Spacer(
            flex: Responsive.isDesktop(context) ? 2 : 1,
          ),
        !showText
            ? Container()
            : Expanded(
                child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(
                        size.height * 0.01,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: size.height * 0.01 / 2,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )),
      ],
    );
  }
}
