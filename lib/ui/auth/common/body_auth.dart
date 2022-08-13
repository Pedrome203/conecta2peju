import 'package:conecta2peju/ui/auth/common/card_auth.dart';
import 'package:conecta2peju/ui/common/primary_button.dart';

import 'package:flutter/material.dart';

Widget bodyAuth(BuildContext context, String textPrimary, String textSecondary,
    Widget cardForm) {
  return Stack(
    clipBehavior: Clip.hardEdge,
    fit: StackFit.loose,
    children: [
      Column(children: [
        Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
            )),
        Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).colorScheme.background,
            ))
      ]),
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              const Expanded(
                  child: Center(
                child: ImageIcon(
                  AssetImage("assets/images/Logo_Transparente.png"),
                  size: 100,
                  color: Colors.white,
                ),
              )),
              cardForm,
              tagBottomCardAuth(context, textSecondary)
            ],
          ),
        ),
      )
    ],
  );
}

Widget tagBottomCardAuth(BuildContext context, String text) {
  return Expanded(
      child: Center(
    child: GestureDetector(
      onTap: null,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ),
  ));
}
