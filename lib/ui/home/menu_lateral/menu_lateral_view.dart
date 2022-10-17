import 'package:conecta2peju/ui/auth/log_in_view.dart';
import 'package:conecta2peju/ui/auth/test.dart';
import 'package:conecta2peju/ui/home/friend_requests/friend_request.dart';
import 'package:conecta2peju/ui/home/profile_settings/profile_data_view.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';

class MenuLateral extends StatelessWidget {
  MenuLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    String imageProfile =
        'https://cdn-icons-png.flaticon.com/512/149/149071.png';

    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.background
                ]),
          ),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('profilePage');
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    imageUrl: imageProfile,
                  ),
                ),
              ),
              Text(
                auth.user!.name.length > 20
                    ? auth.user!.name.substring(0, 20) + '...'
                    : auth.user!.name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )),
      Column(
        children: [
          SafeArea(child: Container()),
          Divider(
            indent: 0.0,
            thickness: 1.0,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          _opcionMenu(context, 'My Profile', CupertinoIcons.person, _myProfile),
          _opcionMenu(
              context, 'Friend Requests', Icons.person_add, _myFriendRequest),
          _opcionMenu(context, 'Log Out', Icons.logout_outlined, _logoutApp),
        ],
      ),
    ]));
  }

  _logoutApp(BuildContext context) async {
    pushToPage(context, LogInView());
  }

  _contactSouport(BuildContext context) async {
    _setWhatsapp(context);
  }

  _myFriendRequest(BuildContext context) async {
    pushToPage(context, FriendRequest());
  }

  _myProfile(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    pushToPage(
        context,
        ProfileDataView(
          idUser: auth.user!.id,
          idStalker: auth.user!.id,
        ));
  }

  _setWhatsapp(BuildContext context) async {}

  _opcionMenu(BuildContext context, String text, IconData icon, function) {
    final colorIcon = Theme.of(context).colorScheme.onSurface;
    final functionAction = function;
    return ListTile(
      leading: Icon(
        icon,
        color: colorIcon,
      ),
      title: Text(text, style: Theme.of(context).textTheme.headline5),
      onTap: () {
        functionAction(context);
      },
    );
  }
}
