import 'package:conecta2peju/ui/common/card_single_widget.dart';

import 'package:conecta2peju/ui/home/profile_settings/profile_data_cubit.dart';
import 'package:conecta2peju/ui/home/profile_settings/user_cubit.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;

import '../../common/loader_custom.dart';
import '../../common/messages_widgets.dart';

class ProfileDataView extends StatefulWidget {
  const ProfileDataView(
      {Key? key, @required this.idUser, @required this.idStalker})
      : super(key: key);
  final int? idUser;
  final int? idStalker;
  @override
  State<ProfileDataView> createState() => _ProfileDataViewState();
}

class _ProfileDataViewState extends State<ProfileDataView>
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.loadDataUser(widget.idUser!, widget.idStalker!);

    controller = TabController(length: 2, vsync: this);
    scrollController =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);
  }

  final key = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final cards = context.watch<UserProvider>().cardsCreate;
    final friends = context.watch<UserProvider>().friends;
    final profile = context.watch<UserProvider>().user;
    final loading = context.watch<UserProvider>().loading;

    final status = context.watch<UserProvider>().status;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: profile != null
                  ? Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: profile.englishLevel.toString() == '1'
                              ? Color.fromARGB(255, 77, 73, 73)
                              : profile.englishLevel.toString() == '2'
                                  ? Color.fromARGB(255, 26, 118, 64)
                                  : profile.englishLevel.toString() == '3'
                                      ? Color.fromARGB(255, 86, 4, 4)
                                      : profile.englishLevel.toString() == '4'
                                          ? Color.fromARGB(255, 106, 8, 133)
                                          : profile.englishLevel.toString() ==
                                                  '5'
                                              ? Color.fromARGB(255, 15, 89, 123)
                                              : profile.englishLevel
                                                          .toString() ==
                                                      '5'
                                                  ? Color.fromARGB(
                                                      255, 112, 109, 20)
                                                  : Color.fromARGB(66, 0, 0, 0),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        profile.englishLevel.toString() == '1'
                            ? 'A1'
                            : profile.englishLevel.toString() == '2'
                                ? 'A2'
                                : profile.englishLevel.toString() == '3'
                                    ? 'B1'
                                    : profile.englishLevel.toString() == '4'
                                        ? 'B2'
                                        : profile.englishLevel.toString() == '5'
                                            ? 'C1'
                                            : profile.englishLevel.toString() ==
                                                    '6'
                                                ? 'C2'
                                                : 'NA',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  : Container(),
            ),
          ],
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Theme.of(context).colorScheme.onSurface,
              size: 30,
            ),
            onPressed: () => popPage(context),
          ),
          elevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: loading == false
            ? Center(
                child: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    // le permite crear una lista de elementos que se desplazarían hasta que el cuerpo alcanzara la parte superior */
                    headerSliverBuilder: (context, _) {
                      return [
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Container(
                            margin: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        radius: 45.0,
                                        backgroundImage: NetworkImage(profile!
                                                    .image ==
                                                'NA'
                                            ? 'https://ui-avatars.com/api/?background=226C8A&color=ffffff&name=' +
                                                profile.name
                                            : profile.image),
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(children: <Widget>[
                                          Text(
                                            cards!.cards!.length.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "Cards",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            textAlign: TextAlign.center,
                                          ),
                                        ]),
                                        Column(children: <Widget>[
                                          Text(
                                            friends!.users!.length.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "Friends",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            textAlign: TextAlign.center,
                                          ),
                                        ]),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile.name,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        widget.idUser == widget.idStalker
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primaryContainer
                                            : status == 0
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : status == 2
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer
                                                    : status == 1
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                      ),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: const BorderSide(
                                                  color: Colors.black))),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                    ),
                                    onPressed: () async {
                                      status == 0 || status == 3
                                          ? await sendRequest(
                                              context,
                                              widget.idStalker!,
                                              widget.idUser!,
                                              1)
                                          : print('NULL');
                                    },
                                    child: Text(
                                        widget.idUser == widget.idStalker
                                            ? "Edit Profile"
                                            : status == 0
                                                ? 'Send Friend Request'
                                                : status == 2
                                                    ? 'Friend'
                                                    : status == 1
                                                        ? 'Friend Request Sent'
                                                        : 'Send Friend Request',
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                              ],
                            ),
                          )
                        ]))
                      ];
                    },
                    // La vista de pestaña va aqui */
                    body: Column(
                      children: <Widget>[
                        TabBar(
                          indicatorColor:
                              Theme.of(context).textTheme.bodyText1?.color,
                          tabs: [
                            Tab(
                                icon: Icon(CupertinoIcons.collections_solid,
                                    size: 30.0,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            Tab(
                                icon: Icon(
                              Icons.group,
                              size: 30.0,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                          ],
                        ),
                        Opacity(
                            opacity: 0.9,
                            child: Divider(
                              height: 2.0,
                              thickness: 0.9,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        Expanded(
                          child: TabBarView(children: [
                            GridView.builder(
                              itemCount: cards!.cards!.length,
                              itemBuilder: (context, index) {
                                final card = cards.cards![index];
                                return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CardPostSingle(
                                      textCard: card.content,
                                      categoryCard: card.category.toString(),
                                      urlImage:
                                          'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                      nameUser: card.name,
                                      idUser: card.userId.toString(),
                                      idCard: card.id.toString(),
                                      index: index,
                                    ));
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 1,
                              ),
                            ),
                            AnimatedList(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              key: key,
                              initialItemCount: friends!.users!.length,
                              itemBuilder: (context, index, animation) {
                                final friend = friends.users![index];

                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      pushAndReplaceToPage(
                                          context,
                                          ProfileDataView(
                                              idUser: friend.id,
                                              idStalker: widget.idStalker));
                                    },
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              height: 90,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10)),
                                                image: DecorationImage(
                                                    image: NetworkImage(friend
                                                                .image !=
                                                            'NA'
                                                        ? friend.image
                                                        : 'https://ui-avatars.com/api/?name=' +
                                                            friend.name),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: Text(
                                                friend.name.length > 20
                                                    ? friend.name
                                                            .substring(0, 20) +
                                                        '...'
                                                    : friend.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              },
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : spinkit);
  }
}

const spinkit = SpinKitRotatingCircle(
  color: Color.fromARGB(255, 34, 108, 138),
  size: 50.0,
);

// Una astilla cuyo tamaño varía cuando la astilla se desplaza hacia el borde de la ventana opuesta a la Dirección de crecimiento de la astilla . */
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(child: _tabBar);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

sendRequest(BuildContext context, int idUserS, int idUserR, int status) async {
  loaderView(context);
  final response = await Provider.of<UserProvider>(context, listen: false)
      .addFriendRequest(idUserS, idUserR, status);
  if (response) {
    messageOK(context, 'La solicitud se ha enviado con exito');
  } else {
    messageError(context, 'Ha ocurrido un erroor al enviar la solicitud');
  }
  Loader.hide();
}
