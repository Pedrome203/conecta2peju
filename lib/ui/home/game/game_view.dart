import 'package:conecta2peju/ui/common/card_widget.dart';
import 'package:conecta2peju/ui/home/profile_settings/profile_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileDataCubit(context.read()),
      child: Scaffold(
        body: Center(),
      ),
    );
  }
}
