import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({Key? key, this.appBarText, @required this.appBarColor})
      : super(key: key);
  final String? appBarText;
  final Color? appBarColor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarText!),
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.onSurface,
          size: 30,
        ),
        onPressed: () => popPage(context),
      ),
      elevation: 0.0,
      backgroundColor: appBarColor,
    );
  }
}
