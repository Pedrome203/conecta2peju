import 'package:conecta2peju/ui/home/feed/feed_news_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:translator/translator.dart';
import 'package:provider/provider.dart';

class CardPost extends StatelessWidget {
  const CardPost(
      {Key? key,
      @required this.textCard,
      @required this.categoryCard,
      @required this.isLike,
      @required this.isSave,
      @required this.countLike,
      @required this.urlImage,
      @required this.nameUser,
      @required this.idUser,
      @required this.idCard,
      @required this.index})
      : super(key: key);

  final String? urlImage;
  final String? textCard;
  final String? categoryCard;
  final String? countLike;
  final String? isLike;
  final String? isSave;
  final String? nameUser;
  final String? idUser;
  final String? idCard;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: categoryCard == '1'
                ? const Color.fromARGB(27, 136, 15, 192)
                : categoryCard == '2'
                    ? const Color.fromARGB(27, 243, 48, 9)
                    : categoryCard == '3'
                        ? const Color.fromARGB(27, 171, 192, 15)
                        : categoryCard == '4'
                            ? const Color.fromARGB(27, 62, 192, 15)
                            : categoryCard == '5'
                                ? const Color.fromARGB(27, 192, 15, 154)
                                : const Color.fromARGB(27, 19, 212, 246)),
        child: Stack(children: [
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      _openCustomDialog(context, 'User', nameUser!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          imageUrl: urlImage!,
                        ),
                      ),
                    ),
                  ),
                  //Save
                  Padding(
                    padding: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width * 0.85) - 90),
                    child: IconButton(
                      icon: Icon(
                        Icons.turned_in_outlined,
                        color: isSave == '1'
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onSecondary,
                        size: 35,
                      ),
                      onPressed: () async {
                        Provider.of<FeedNewsProvider>(context, listen: false)
                            .addSave(index!, 2, int.parse(idCard!),
                                int.parse(isSave!));
                      },
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  _openCustomDialog(context, 'Traducción', textCard!);
                },
                child: Padding(
                  // Texto en ingles
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(textCard!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5),
                ),
              ),
              Align(
                  // Like
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.heart_fill,
                            size: 35,
                            color: isLike == '1'
                                ? const Color.fromARGB(255, 244, 0, 0)
                                : const Color.fromARGB(255, 86, 81, 81),
                          ),
                          onPressed: () async {
                            Provider.of<FeedNewsProvider>(context,
                                    listen: false)
                                .addLike(index!, 2, int.parse(idCard!),
                                    int.parse(isLike!));
                          },
                        ),
                        Text(countLike!)
                      ],
                    ),
                  )),
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> _openCustomDialog(
      BuildContext context, String title, String textCard) async {
    final translator = GoogleTranslator();
    final input = textCard;
    var textTranslation =
        await translator.translate(input, from: 'en', to: 'es');
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                child: AlertDialog(
                  title: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background),
                      child: Text(title)),
                  content: Text(
                    textTranslation.text,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                        child: Text("Continuar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ));
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
