import 'package:conecta2peju/ui/auth/common/card_auth.dart';
import 'package:conecta2peju/ui/common/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';

import '../../../utils/navigator_utils.dart';
import '../../common/loader_custom.dart';
import '../../common/messages_widgets.dart';
import '../../home/auth_provider.dart';
import '../../home/home_view.dart';
import '../../splash/splash_view.dart';

Widget bodyAuth(
    BuildContext context, String textPrimary, String textSecondary) {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              Card(
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
                          child: Text('Login',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: emailController,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                                labelStyle:
                                    Theme.of(context).textTheme.headline5,
                                labelText: "Email",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                border: const UnderlineInputBorder()),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: passwordController,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                                labelStyle:
                                    Theme.of(context).textTheme.headline5,
                                labelText: "Password",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                border: const UnderlineInputBorder()),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                        ),
                        primaryButton(context, onPressed: () async {
                          await validateLogin(context, emailController.text,
                              passwordController.text);
                        },
                            text: 'Login',
                            colorButton:
                                Theme.of(context).colorScheme.primaryContainer,
                            colorText:
                                Theme.of(context).colorScheme.background),
                      ],
                    ),
                  ),
                ),
              ),
              tagBottomCardAuth(context, textSecondary)
            ],
          ),
        ),
      )
    ],
  );
}

Future<void> validateLogin(
    BuildContext context, String email, String password) async {
  loaderView(context);
  final auth = Provider.of<AuthProvider>(context, listen: false);
  final response = await auth.validate(email, password);
  if (response) {
    Loader.hide();
    Future.delayed(const Duration(milliseconds: 1000), () {
      pushAndReplaceToPage(context, SplashView());
    });
  } else {
    Loader.hide();

    messageError(context, 'Haz ingresado datos no validos');
    print('ERROR');
  }
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
