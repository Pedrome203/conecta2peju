import 'package:conecta2peju/ui/common/card_widget.dart';
import 'package:conecta2peju/ui/home/feed/feed_news_cubit.dart';
import 'package:conecta2peju/ui/home/profile_settings/profile_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';

class FeedRecomendationsView extends StatefulWidget {
  const FeedRecomendationsView({Key? key}) : super(key: key);

  @override
  State<FeedRecomendationsView> createState() => _FeedRecomendationsViewState();
}

class _FeedRecomendationsViewState extends State<FeedRecomendationsView> {
  @override
  void initState() {
    super.initState();
    final cardsProvider = Provider.of<FeedNewsProvider>(context, listen: false);
    final userProvider = Provider.of<AuthProvider>(context, listen: false);

    cardsProvider.loadRecommendations(userProvider.user!.id);
  }

  Widget build(BuildContext context) {
    final cards = context.watch<FeedNewsProvider>().recommendations;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final loading = context.watch<FeedNewsProvider>().loadingRecommendations;
    final recommendationsIsEmpty =
        context.watch<FeedNewsProvider>().recommendationsIsEmpty;

    return Scaffold(
      body: Center(
        child: loading == false
            ? recommendationsIsEmpty == false
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: kToolbarHeight),
                    itemCount: cards!.cards!.length,
                    itemBuilder: (context, index) {
                      final card = cards.cards![index];
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CardPost(
                            idUserAuth: auth.user!.id,
                            textCard: card.content,
                            categoryCard: card.category.toString(),
                            isLike: card.isLike.toString(),
                            isSave: card.isSave.toString(),
                            countLike: card.countLike.toString(),
                            urlImage: card.image,
                            nameUser: card.name,
                            idUser: card.userId.toString(),
                            idCard: card.id.toString(),
                            index: index,
                            isRecomendation: true,
                          ));
                    })
                : Container(
                    child: Text('You have no recommendations',
                        style: Theme.of(context).textTheme.headline3),
                  )
            : spinkit,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Reload-recomendations',
        backgroundColor: Theme.of(context).colorScheme.background,
        focusColor: Theme.of(context).colorScheme.onBackground,
        onPressed: () => setState(() => {
              Provider.of<FeedNewsProvider>(context, listen: false)
                  .loadRecommendations(auth.user!.id)
            }),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

const spinkit = SpinKitRotatingCircle(
  color: Color.fromARGB(255, 34, 108, 138),
  size: 50.0,
);
