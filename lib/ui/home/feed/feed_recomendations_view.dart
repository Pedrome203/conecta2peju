import 'package:conecta2peju/ui/common/card_widget.dart';
import 'package:conecta2peju/ui/home/profile_settings/profile_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedRecomendationsView extends StatelessWidget {
  const FeedRecomendationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileDataCubit(context.read()),
      child: Scaffold(
        body: Center(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              itemCount: 2,
              itemBuilder: (context, index) {
                return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CardPost(
                        textCard: 'Hello',
                        categoryCard: '1',
                        isLike: '1',
                        isSave: '1',
                        urlImage:
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png'));
              }),
        ),
      ),
    );
  }
}
