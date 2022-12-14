import 'package:conecta2peju/ui/auth/log_in_view.dart';
import 'package:conecta2peju/ui/home/home_view.dart';

import 'package:conecta2peju/ui/profile_verify/profile_verify_view.dart';
import 'package:conecta2peju/ui/auth/sign_in_view.dart';
import 'package:conecta2peju/ui/splash/splash_cubit.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/auth_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.authUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool? loading = false;
    final auth = Provider.of<AuthProvider>(context, listen: false);

    loading = context.watch<AuthProvider>().loading;

    if (loading! == true) {
      auth.reset();
      print(auth.user!.username.toString());
      return BlocProvider(
        create: (context) =>
            SplashCubit(context.read())..init(auth.user!.username.toString()),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, snapchot) {
            if (snapchot == SplashState.none) {
              pushAndReplaceToPage(context, const LogInView());
            } else if (snapchot == SplashState.existingUser) {
              pushAndReplaceToPage(context, HomeView());
            } else {
              pushAndReplaceToPage(context, HomeView());
            }
          },
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(34, 108, 138, 1),
            body: Center(
              child: Image.asset(
                "assets/images/Logo_Transparente.png",
                height: 280.0,
                width: 280.0,
              ),
            ),
          ),
        ),
      );
    } else {
      Future.delayed(Duration(milliseconds: 2000), () {
        if (auth.error) {
          popAllAndPush(context, LogInView());
        }
      });

      return Scaffold(
        backgroundColor: const Color.fromRGBO(34, 108, 138, 1),
        body: Center(
          child: Image.asset(
            "assets/images/Logo_Transparente.png",
            height: 280.0,
            width: 280.0,
          ),
        ),
      );
    }
  }
}
