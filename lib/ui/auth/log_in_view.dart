import 'package:conecta2peju/ui/auth/common/body_auth.dart';
import 'package:conecta2peju/ui/auth/common/card_auth.dart';
import 'package:conecta2peju/ui/auth/log_in_cubit.dart';
import 'package:conecta2peju/ui/auth/sign_in_cubit.dart';
import 'package:conecta2peju/ui/common/primary_button.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_view.dart';

class LogInView extends StatelessWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogInCubit(),
      child: BlocConsumer<LogInCubit, LogInState>(
        listener: (context, snapchot) {
          if (snapchot == LogInState.existingUser) {
            pushAndReplaceToPage(context, HomeView());
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: bodyAuth(
                context,
                'Login',
                'Sign In',
                cardAuth(
                    context,
                    'Login',
                    primaryButton(context, onPressed: () {
                      pushToPage(context, HomeView());
                    },
                        text: 'Login',
                        colorButton:
                            Theme.of(context).colorScheme.primaryContainer,
                        colorText: Theme.of(context).colorScheme.background))),
          );
        },
      ),
    );
  }
}
