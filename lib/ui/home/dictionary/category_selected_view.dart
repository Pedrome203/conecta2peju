import 'package:conecta2peju/ui/common/app_bar_custom.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategorySelected extends StatelessWidget {
  const CategorySelected(
      {Key? key, @required this.appBarText, @required this.appBarColor})
      : super(key: key);
  final String? appBarText;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(
        appBarText!,
        style: Theme.of(context).textTheme.headline3,
      ),
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.onSurface,
          size: 30,
        ),
        onPressed: () => popPage(context),
      ),
      actions: const <Widget>[
        IconButton(
            onPressed: null, icon: Icon(CupertinoIcons.add_circled_solid))
      ],
      elevation: 0.0,
      backgroundColor: appBarColor,
    ));
  }
}
