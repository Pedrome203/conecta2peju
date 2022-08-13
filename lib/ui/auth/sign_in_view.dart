import 'package:conecta2peju/ui/auth/common/body_auth.dart';
import 'package:conecta2peju/ui/auth/common/card_auth.dart';
import 'package:conecta2peju/ui/auth/log_in_view.dart';
import 'package:conecta2peju/ui/common/primary_button.dart';
import 'package:conecta2peju/ui/home/home_view.dart';
import 'package:conecta2peju/ui/home/profile_settings/profile_data_view.dart';
import 'package:conecta2peju/ui/profile_verify/profile_verify_view.dart';
import 'package:conecta2peju/ui/auth/sign_in_cubit.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, snapchot) {
          if (snapchot == SignInState.none) {
            pushAndReplaceToPage(context, const LogInView());
          } else {
            pushAndReplaceToPage(context, const ProfileDataView());
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: bodyAuth(
                context,
                'Sign In',
                'Login',
                cardAuth(
                    context,
                    'Sign In',
                    primaryButton(context, onPressed: () {
                      context.read<SignInCubit>().signIn();
                    },
                        text: 'Sign In',
                        colorButton:
                            Theme.of(context).colorScheme.primaryContainer,
                        colorText: Theme.of(context).colorScheme.background))),
          );
        },
      ),
    );
  }
}
