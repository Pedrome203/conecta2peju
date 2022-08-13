/// Copyright 2020 Logica Booleana Authors */

// Dependencias

import 'package:flutter/material.dart';
import 'dart:math' as math;
// Los link de de las depedencias se pueden encontrar en "Más" => Dependencias */
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// DESCRIPCIÓN
// Clon ui Perfil  de la red social instagram

class PageProfileInstagram extends StatefulWidget {
  // Definimos los coloes principales
  static List<Color> colorGradientInstagram = [
    Color.fromRGBO(129, 52, 175, 1.0),
    Color.fromRGBO(129, 52, 175, 1.0),
    Color.fromRGBO(221, 42, 123, 1.0),
    Color.fromRGBO(254, 218, 119, 1.0)
  ];

  @override
  _PageProfileInstagramState createState() => _PageProfileInstagramState();
}

class _PageProfileInstagramState extends State<PageProfileInstagram>
    with SingleTickerProviderStateMixin {
  // var
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
    controller = new TabController(length: 2, vsync: this);
    scrollController =
        new ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: body(),
    );
  }

  Widget body() {
    return DefaultTabController(
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
              indicatorColor: Theme.of(context).textTheme.bodyText1?.color,
              tabs: [
                Tab(
                    icon: FaIcon(FontAwesomeIcons.borderAll,
                        size: 24.0,
                        color: Theme.of(context).textTheme.bodyText1?.color)),
                Tab(
                    icon: FaIcon(
                  FontAwesomeIcons.idBadge,
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
    );
  }

  /// WIDGETS

}

// Contenido del perfil del usuario
// ignore: must_be_immutable
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
    const double sizeWidth = 70;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: sizeWidth,
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
        Text('Lucas Iván Cabrera'),
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
