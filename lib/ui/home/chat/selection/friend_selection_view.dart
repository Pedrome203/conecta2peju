import 'package:conecta2peju/domain/models/chat_user.dart';
import 'package:conecta2peju/ui/home/chat/chat_view.dart';
import 'package:conecta2peju/ui/home/chat/selection/friend_selection_cubit.dart';
import 'package:conecta2peju/ui/home/chat/selection/group_selection_view.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendSelectionView extends StatelessWidget {
  const FriendSelectionView({Key? key}) : super(key: key);
  void _createFriendChannel(
      BuildContext context, ChatUserState chatUserState) async {
    final channel = await context
        .read<FriendSelectionCubit>()
        .createFriendChannel(chatUserState);
    pushAndReplaceToPage(
      context,
      Scaffold(
          body: StreamChannel(
        channel: channel,
        child: ChannelPage(),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FriendSelectionCubit(context.read())..init(),
        ),
        BlocProvider(create: (_) => FriendsGroupCubit())
      ],
      child: BlocBuilder<FriendsGroupCubit, bool>(builder: (context, isGroup) {
        return BlocBuilder<FriendSelectionCubit, List<ChatUserState>>(
            builder: (context, snapshot) {
          final selectedUsers =
              context.read<FriendSelectionCubit>().selectedUsers;
          return Scaffold(
            floatingActionButton: isGroup && selectedUsers.isNotEmpty
                ? FloatingActionButton(onPressed: () {
                    pushAndReplaceToPage(
                        context, GroupSelectionView(selectedUsers));
                  })
                : null,
            body: Column(
              children: [
                if (isGroup)
                  Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          context.read<FriendsGroupCubit>().changeToGroup();
                        },
                      ),
                      Text("New Group"),
                    ],
                  )
                else
                  // ignore: dead_code
                  Row(children: [
                    BackButton(
                      onPressed: Navigator.of(context).pop,
                    ),
                    Text("People"),
                  ]),
                if (!isGroup)
                  // ignore: dead_code
                  ElevatedButton(
                    onPressed: () {
                      context.read<FriendsGroupCubit>().changeToGroup();
                    },
                    child: Text('Create Group'),
                  )
                else if (isGroup && selectedUsers.isEmpty)
                  // ignore: dead_code
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(),
                      Text('Add a friend'),
                    ],
                  )
                else
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedUsers.length,
                        itemBuilder: ((context, index) {
                          final chatUserState = selectedUsers[index];
                          return Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircleAvatar(),
                                  Text(chatUserState.chatUser!.name!)
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<FriendSelectionCubit>()
                                        .selectUser(chatUserState);
                                    print('selected user');
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          );
                        })),
                  ),
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.length,
                        itemBuilder: (context, index) {
                          final chatUserState = snapshot[index];
                          return ListTile(
                              onTap: () {
                                _createFriendChannel(context, chatUserState);
                              },
                              leading: CircleAvatar(),
                              title: Text(chatUserState.chatUser!.name!),
                              trailing: isGroup
                                  ? Checkbox(
                                      value: chatUserState.selected!,
                                      onChanged: (val) {
                                        print('select user for group');
                                        context
                                            .read<FriendSelectionCubit>()
                                            .selectUser(chatUserState);
                                      })
                                  : null);
                        }))
              ],
            ),
          );
        });
      }),
    );
  }
}
