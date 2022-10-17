import 'package:conecta2peju/ui/common/messages_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/navigator_utils.dart';
import '../profile_settings/user_cubit.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({Key? key}) : super(key: key);

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  final key = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final friends = context.watch<UserProvider>().friends;
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
        body: Center(
          child: AnimatedList(
            padding: EdgeInsets.symmetric(horizontal: 5),
            key: key,
            initialItemCount: friends!.users!.length,
            itemBuilder: (context, index, animation) {
              final friend = friends.users![index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 100,
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
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            color: Color.fromARGB(255, 5, 120, 19),
                            icon: const Icon(
                                CupertinoIcons.checkmark_rectangle_fill),
                            onPressed: () {
                              messageOK(context,
                                  'Haz aceptado una solicitud de amistad');
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.only(top: 50),
                          child: IconButton(
                            color: Color.fromARGB(255, 120, 34, 5),
                            icon: const Icon(CupertinoIcons.clear_fill),
                            onPressed: () {
                              messageOK(context,
                                  'Haz rechazado una solicitud de amistad');
                            },
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ));
  }
}
