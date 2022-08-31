import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:translator/translator.dart';

class CardPostSingle extends StatelessWidget {
  const CardPostSingle(
      {Key? key,
      @required this.textCard,
      @required this.categoryCard,
      @required this.urlImage,
      @required this.nameUser,
      @required this.idUser,
      @required this.idCard,
      @required this.index})
      : super(key: key);

  final String? urlImage;
  final String? textCard;
  final String? categoryCard;
  final String? nameUser;
  final String? idUser;
  final String? idCard;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
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
              GestureDetector(
                onTap: () async {
                  _openCustomDialog(context, 'Traducción', textCard!);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(textCard!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5),
                ),
              ),
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
                  content: Text(
                    textTranslation.text,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                        child: const Text("OK"),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            primary: Theme.of(context).colorScheme.primary),
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
