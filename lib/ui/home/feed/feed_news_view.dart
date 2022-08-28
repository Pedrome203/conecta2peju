import 'package:conecta2peju/domain/models/repository/card_api.dart';
import 'package:conecta2peju/ui/common/card_widget.dart';
import 'package:conecta2peju/ui/home/feed/feed_news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FeedNewsView extends StatefulWidget {
  const FeedNewsView({Key? key}) : super(key: key);

  @override
  State<FeedNewsView> createState() => _FeedNewsViewState();
}

class _FeedNewsViewState extends State<FeedNewsView> {
  @override
  void initState() {
    super.initState();
    final cardsProvider = Provider.of<FeedNewsProvider>(context, listen: false);

    cardsProvider.loadCards();
  }

  Widget build(BuildContext context) {
    final cards = context.watch<FeedNewsProvider>().cardList;

    final loading = context.watch<FeedNewsProvider>().loading;

    return Scaffold(
      body: Center(
        child: loading == true
            ? ListView.builder(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                itemCount: cards!.cards!.length,
                itemBuilder: (context, index) {
                  final card = cards.cards![index];
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CardPost(
                        textCard: card.content,
                        categoryCard: card.category.toString(),
                        isLike: card.isLike.toString(),
                        isSave: card.isSave.toString(),
                        countLike: card.countLike.toString(),
                        urlImage:
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                        nameUser: card.name,
                        idUser: card.userId.toString(),
                        idCard: card.id.toString(),
                        index: index,
                      ));
                })
            : spinkit,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Reload',
        backgroundColor: Theme.of(context).colorScheme.background,
        focusColor: Theme.of(context).colorScheme.onBackground,
        onPressed: () => setState(() => {
              Provider.of<FeedNewsProvider>(context, listen: false).loadCards()
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
