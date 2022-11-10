import 'package:conecta2peju/ui/common/messages_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../utils/navigator_utils.dart';
import '../../common/loader_custom.dart';
import '../auth_provider.dart';
import '../profile_settings/profile_data_view.dart';
import '../profile_settings/user_cubit.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({Key? key}) : super(key: key);

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  final key = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    userProvider.loadFriendRequests(auth.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    final requests = context.watch<UserProvider>().requests;
    final loading = context.watch<UserProvider>().loading;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Friend Requests',
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
        body: loading == false
            ? Center(
                child: AnimatedList(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  key: key,
                  initialItemCount: requests!.requests!.length,
                  itemBuilder: (context, index, animation) {
                    final friend = requests.requests![index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  pushAndReplaceToPage(
                                      context,
                                      ProfileDataView(
                                          idUser: friend.id,
                                          idStalker: auth.user!.id));
                                },
                                child: Container(
                                  height: 100,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage(friend.image != 'NA'
                                            ? friend.image
                                            : 'https://ui-avatars.com/api/?name=' +
                                                friend.name),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  friend.name.length > 20
                                      ? friend.name.substring(0, 20) + '...'
                                      : friend.name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  color: Color.fromARGB(255, 5, 120, 19),
                                  icon: const Icon(
                                      CupertinoIcons.checkmark_rectangle_fill),
                                  onPressed: () async {
                                    await changeStatusRequest(
                                        context, friend.id, auth.user!.id, 2);
                                  },
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.only(top: 50),
                                child: IconButton(
                                  color: Color.fromARGB(255, 120, 34, 5),
                                  icon: const Icon(CupertinoIcons.clear_fill),
                                  onPressed: () async {
                                    await changeStatusRequest(
                                        context, friend.id, auth.user!.id, 3);
                                  },
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              )
            : spinkit);
  }

  changeStatusRequest(
      BuildContext context, int idUserS, int idUserR, int status) async {
    loaderView(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    final response = await Provider.of<UserProvider>(context, listen: false)
        .addFriendRequest(idUserS, idUserR, status);
    if (response) {
      if (status == 3) {
        messageOK(context, 'Haz rechazado esta solicitud');
      } else {
        messageOK(context, 'Haz aceptado esta solicitud');
      }
      userProvider.loadFriendRequests(auth.user!.id);
    } else {
      if (status == 3) {
        messageError(
            context, 'Ha ocurrido un erroor al aceptar esta solicitud');
      } else {
        messageError(
            context, 'Ha ocurrido un erroor al rechazar esta solicitud');
      }
    }
    Loader.hide();
  }
}

const spinkit = SpinKitRotatingCircle(
  color: Color.fromARGB(255, 34, 108, 138),
  size: 50.0,
);
