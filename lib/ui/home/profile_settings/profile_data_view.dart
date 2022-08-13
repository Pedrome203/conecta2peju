import 'package:conecta2peju/ui/home/profile_settings/profile_data_cubit.dart';
import 'package:conecta2peju/ui/auth/sign_in_view.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    controller = TabController(length: 2, vsync: this);
    scrollController =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.currentUser;
    final image = user?.extraData['image'];

    return BlocProvider(
      create: (context) => ProfileDataCubit(context.read()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
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
                          icon: Icon(Icons.content_copy,
                              size: 24.0,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color)),
                      Tab(
                          icon: Icon(
                        Icons.person,
                        size: 24.0,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      )),
                    ],
                  ),
                  Opacity(
                      opacity: 0.3,
                      child: Divider(
                        height: 0.0,
                        thickness: 0.2,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      )),
                  Expanded(
                    child: Container(),
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
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.grey))),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: () {},
              child: Text("Editar perfil",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyText1?.color)),
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
            child: Column(children: <Widget>[
              Text(
                '12',
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
            ]),
          ),
        ],
      ),
    );
  }

  Widget descripcion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text('Juan el tojo'),
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
