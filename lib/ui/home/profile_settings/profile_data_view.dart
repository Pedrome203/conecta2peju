import 'package:conecta2peju/ui/common/card_single_widget.dart';
import 'package:conecta2peju/ui/home/feed/feed_news_cubit.dart';
import 'package:conecta2peju/ui/home/profile_settings/profile_data_cubit.dart';
import 'package:conecta2peju/ui/home/profile_settings/user_cubit.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'dart:math' as math;

class ProfileDataView extends StatefulWidget {
  const ProfileDataView({Key? key}) : super(key: key);

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

    userProvider.loadAllCardsCreate();

    controller = TabController(length: 2, vsync: this);
    scrollController =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);
  }

  final key = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.currentUser;
    final image = user?.extraData['image'];
    final cards = context.watch<UserProvider>().cardsCreate;
    final friends = context.watch<UserProvider>().friends;

    final loading = context.watch<FeedNewsProvider>().loading;

    return BlocProvider(
      create: (context) => ProfileDataCubit(context.read()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
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
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              // le permite crear una lista de elementos que se desplazarían hasta que el cuerpo alcanzara la parte superior */
              headerSliverBuilder: (context, _) {
                return [
                  SliverList(
                      delegate: SliverChildListDelegate(
                          [ContentProfileUser(context: context)]))
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
                              color: Theme.of(context).colorScheme.primary)),
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
                      loading == true
                          ? GridView.builder(
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
                            )
                          : spinkit,
                      AnimatedList(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        key: key,
                        initialItemCount: friends!.length,
                        itemBuilder: (context, index, animation) {
                          final friend = friends[index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 90,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        image: DecorationImage(
                                            image: NetworkImage(friend.image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        friend.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const spinkit = SpinKitRotatingCircle(
  color: Color.fromARGB(255, 34, 108, 138),
  size: 50.0,
);

class ContentProfileUser extends StatelessWidget {
  ContentProfileUser({Key? key, required this.context}) : super(key: key);
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          fotoPerfilContadores(context: context),
          const SizedBox(height: 12.0),
          descripcion(),
          const SizedBox(height: 12.0),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primaryContainer),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.black))),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: () {},
              child: const Text("Edit Profile",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }

  // Creamos las vista de los contadores
  Widget fotoPerfilContadores({required BuildContext context}) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).canvasColor,
              radius: 41.0,
              backgroundImage: const NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
            ),
          ),
          Expanded(child: _contadoroes()),
        ],
      ),
    );
  }

  /// WIDGETS
  Widget _contadoroes() {
    // Devuelve una vista con los contadores publiccaciones : seguidores : seguidos

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Column(children: const <Widget>[
            Text(
              '37',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "Cards",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
          ])),
          Container(
            child: Column(children: const <Widget>[
              Text(
                '15',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                "Friends",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.center,
              ),
            ]),
          ),
          Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Colors.purple),
              child: const Text(
                "B1",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }

  Widget descripcion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
          'Juan Manuel Balderrama González',
          style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 85, 85, 85),
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

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
