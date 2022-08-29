import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardAuth(BuildContext context, String title, Widget button) {
  return Card(
    shadowColor: Theme.of(context).colorScheme.onSecondary,
    elevation: 20.0,
    color: Theme.of(context).colorScheme.background,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.headline5,
                    labelText: "Email",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    border: const UnderlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.headline5,
                    labelText: "Password",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    border: const UnderlineInputBorder()),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
            ),
            button,
          ],
        ),
      ),
    ),
  );
}
