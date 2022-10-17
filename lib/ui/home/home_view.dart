import 'package:conecta2peju/ui/home/auth_provider.dart';
import 'package:conecta2peju/ui/home/chat/chat_view.dart';
import 'package:conecta2peju/ui/home/dictionary/category_card_view.dart';
import 'package:conecta2peju/ui/home/feed/feed_news_view.dart';
import 'package:conecta2peju/ui/home/feed/feed_recomendations_view.dart';

import 'package:conecta2peju/ui/home/home_cubit.dart';
import 'package:conecta2peju/ui/home/menu_lateral/menu_lateral_view.dart';
import 'package:conecta2peju/ui/home/profile_settings/profile_data_view.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuLateral(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: auth.user!.englishLevel.toString() == '1'
                      ? Color.fromARGB(255, 77, 73, 73)
                      : auth.user!.englishLevel.toString() == '2'
                          ? Color.fromARGB(255, 26, 118, 64)
                          : auth.user!.englishLevel.toString() == '3'
                              ? Color.fromARGB(255, 86, 4, 4)
                              : auth.user!.englishLevel.toString() == '4'
                                  ? Color.fromARGB(255, 106, 8, 133)
                                  : auth.user!.englishLevel.toString() == '5'
                                      ? Color.fromARGB(255, 15, 89, 123)
                                      : auth.user!.englishLevel.toString() ==
                                              '5'
                                          ? Color.fromARGB(255, 112, 109, 20)
                                          : Color.fromARGB(66, 0, 0, 0),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                auth.user!.englishLevel.toString() == '1'
                    ? 'A1'
                    : auth.user!.englishLevel.toString() == '2'
                        ? 'A2'
                        : auth.user!.englishLevel.toString() == '3'
                            ? 'B1'
                            : auth.user!.englishLevel.toString() == '4'
                                ? 'B2'
                                : auth.user!.englishLevel.toString() == '5'
                                    ? 'C1'
                                    : auth.user!.englishLevel.toString() == '6'
                                        ? 'C2'
                                        : 'NA',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.bars,
            color: Color.fromARGB(255, 42, 41, 41),
            size: 30,
          ),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => HomeCubit(),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<HomeCubit, int>(builder: (context, snapshot) {
                return IndexedStack(
                  index: snapshot,
                  children: const [
                    DictionaryCardsView(),
                    FeedNewsView(),
                    FeedRecomendationsView(),
                    ChatView(),
                  ],
                );
              }),
            ),
            const HomeNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context, listen: true);

    return CurvedNavigationBar(
        height: 70.0,
        index: 0,
        items: const <Widget>[
          Icon(CupertinoIcons.book_solid, size: 30),
          Icon(CupertinoIcons.news_solid, size: 30),
          Icon(CupertinoIcons.question_circle_fill, size: 30),
          Icon(CupertinoIcons.chat_bubble_2_fill, size: 30),
        ],
        color: Theme.of(context).colorScheme.primary,
        buttonBackgroundColor: Colors.transparent,
        backgroundColor: Colors.white,
        animationCurve: Curves.elasticOut,
        animationDuration: const Duration(milliseconds: 1000),
        onTap: (index) {
          cubit.onChangeTab(index);
        });
  }
}
