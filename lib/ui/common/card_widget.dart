import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:translator/translator.dart';

class CardPost extends StatelessWidget {
  const CardPost(
      {Key? key,
      @required this.textCard,
      @required this.categoryCard,
      @required this.isLike,
      @required this.isSave,
      @required this.urlImage})
      : super(key: key);

  final String? urlImage;
  final String? textCard;
  final String? categoryCard;
  final String? isLike;
  final String? isSave;

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
                      _openCustomDialog(context, 'User');
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
                      onPressed: null,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  _openCustomDialog(context, textCard!);
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
                    child: IconButton(
                      icon: Icon(
                        CupertinoIcons.heart_fill,
                        size: 35,
                        color: isLike == '1'
                            ? const Color.fromARGB(255, 244, 0, 0)
                            : const Color.fromARGB(255, 86, 81, 81),
                      ),
                      onPressed: null,
                    ),
                  )),
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> _openCustomDialog(BuildContext context, String textCard) async {
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
                  title: const Text('Traducción'),
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
