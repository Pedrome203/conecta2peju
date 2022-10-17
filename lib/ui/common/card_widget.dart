import 'package:conecta2peju/ui/common/loader_custom.dart';
import 'package:conecta2peju/ui/common/messages_widgets.dart';
import 'package:conecta2peju/ui/home/feed/feed_news_cubit.dart';
import 'package:conecta2peju/ui/home/profile_settings/profile_data_view.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:translator/translator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class CardPost extends StatelessWidget {
  const CardPost(
      {Key? key,
      @required this.idUserAuth,
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
  final int? idUserAuth;
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
                      pushToPage(
                          context,
                          ProfileDataView(
                              idUser: int.parse(idUser!),
                              idStalker: idUserAuth!));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          imageUrl: urlImage != 'NA'
                              ? urlImage!
                              : 'https://ui-avatars.com/api/?name=' + nameUser!,
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
                            .addSave(index!, idUserAuth!, int.parse(idCard!),
                                int.parse(isSave!));
                      },
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  await _openMessageTranslate(context, textCard!);
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
                                .addLike(index!, idUserAuth!,
                                    int.parse(idCard!), int.parse(isLike!));
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

  Future<void> _openMessageTranslate(
      BuildContext context, String textCard) async {
    loaderView(context);
    final translator = GoogleTranslator();
    final input = textCard;
    var textTranslation =
        await translator.translate(input, from: 'en', to: 'es');
    Loader.hide();
    messageTranslate(context, textTranslation.toString());
  }
}
