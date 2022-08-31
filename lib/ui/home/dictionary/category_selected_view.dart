import 'package:conecta2peju/ui/home/dictionary/category_card_create.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:conecta2peju/ui/common/card_single_widget.dart';
import 'package:conecta2peju/ui/home/feed/feed_news_cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CategorySelected extends StatefulWidget {
  const CategorySelected(
      {Key? key,
      @required this.appBarText,
      @required this.appBarColor,
      @required this.secondaryColor,
      @required this.idCategory})
      : super(key: key);
  final String? appBarText;
  final Color? appBarColor;
  final Color? secondaryColor;
  final int? idCategory;

  @override
  State<CategorySelected> createState() => _CategorySelectedState();
}

class _CategorySelectedState extends State<CategorySelected>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  late ScrollController scrollController;
  double get randHeight => math.Random().nextInt(100).toDouble();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final cardsProvider = Provider.of<FeedNewsProvider>(context, listen: false);

    cardsProvider.loadCardsSave(widget.idCategory!);
    cardsProvider.loadCardsLike(widget.idCategory!);
    cardsProvider.loadCardsCreate(widget.idCategory!);

    controller = TabController(length: 3, vsync: this);
    scrollController =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);
  }

  @override
  Widget build(BuildContext context) {
    final cardsCreate = context.watch<FeedNewsProvider>().cardsCreate;
    final cardsSave = context.watch<FeedNewsProvider>().cardsSave;
    final cardsLike = context.watch<FeedNewsProvider>().cardsLike;
    final loading = context.watch<FeedNewsProvider>().loading;
    final message = context.watch<FeedNewsProvider>().message;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.appBarText!,
            style: Theme.of(context).textTheme.headline3,
          ),
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Theme.of(context).colorScheme.onSurface,
              size: 30,
            ),
            onPressed: () => popPage(context),
          ),
          elevation: 0.0,
          backgroundColor: widget.appBarColor,
        ),
        body: Center(
          child: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              // le permite crear una lista de elementos que se desplazarían hasta que el cuerpo alcanzara la parte superior */
              headerSliverBuilder: (context, _) {
                return [
                  SliverList(delegate: SliverChildListDelegate([Container()]))
                ];
              },
              // La vista de pestaña va aqui */
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TabBar(
                      indicatorWeight: 4,
                      indicatorColor: widget.appBarColor,
                      tabs: [
                        Tab(
                            icon: Icon(CupertinoIcons.collections_solid,
                                size: 30.0, color: widget.secondaryColor)),
                        Tab(
                            icon: Icon(
                          CupertinoIcons.heart_fill,
                          size: 30.0,
                          color: widget.secondaryColor,
                        )),
                        Tab(
                            icon: Icon(
                          Icons.turned_in_outlined,
                          size: 30.0,
                          color: widget.secondaryColor,
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      loading == true
                          ? cardsCreate != null
                              ? GridView.builder(
                                  itemCount: cardsCreate.cards!.length,
                                  itemBuilder: (context, index) {
                                    final cardCreate =
                                        cardsCreate.cards![index];
                                    return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CardPostSingle(
                                          textCard: cardCreate.content,
                                          categoryCard:
                                              cardCreate.category.toString(),
                                          urlImage:
                                              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                          nameUser: cardCreate.name,
                                          idUser: cardCreate.userId.toString(),
                                          idCard: cardCreate.id.toString(),
                                          index: index,
                                        ));
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 1,
                                  ))
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    child: Text(
                                      message.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                )
                          : spinkit,
                      loading == true
                          ? cardsLike != null
                              ? GridView.builder(
                                  itemCount: cardsLike.cards!.length,
                                  itemBuilder: (context, index) {
                                    final cardLike = cardsLike.cards![index];
                                    return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CardPostSingle(
                                          textCard: cardLike.content,
                                          categoryCard:
                                              cardLike.category.toString(),
                                          urlImage:
                                              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                          nameUser: cardLike.name,
                                          idUser: cardLike.userId.toString(),
                                          idCard: cardLike.id.toString(),
                                          index: index,
                                        ));
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 1,
                                  ))
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    child: Text(
                                      message.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                )
                          : spinkit,
                      loading == true
                          ? cardsSave != null
                              ? GridView.builder(
                                  itemCount: cardsSave.cards!.length,
                                  itemBuilder: (context, index) {
                                    final cardSave = cardsSave.cards![index];
                                    return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CardPostSingle(
                                          textCard: cardSave.content,
                                          categoryCard:
                                              cardSave.category.toString(),
                                          urlImage:
                                              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                          nameUser: cardSave.name,
                                          idUser: cardSave.userId.toString(),
                                          idCard: cardSave.id.toString(),
                                          index: index,
                                        ));
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 1,
                                  ))
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    child: Text(
                                      message.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                )
                          : spinkit
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'category-select',
          backgroundColor: widget.secondaryColor,
          onPressed: () => {
            pushAndReplaceToPage(
                context,
                CreateCard(
                    appBarColor: widget.appBarColor,
                    secondaryColor: widget.secondaryColor,
                    idCategory: widget.idCategory))
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}

const spinkit = SpinKitRotatingCircle(
  color: Color.fromARGB(255, 34, 108, 138),
  size: 50.0,
);
