import 'package:conecta2peju/domain/models/chat_user.dart';
import 'package:conecta2peju/ui/home/chat/chat_view.dart';
import 'package:conecta2peju/ui/home/chat/selection/friend_selection_cubit.dart';
import 'package:conecta2peju/ui/home/chat/selection/group_selection_cubit.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionView extends StatelessWidget {
  GroupSelectionView(this.selectedUsers);
  final List<ChatUserState> selectedUsers;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GroupSelectionCubit(selectedUsers, context.read(), context.read()),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
          listener: (context, snapshot) {
        if (snapshot.channel != null) {
          pushAndReplaceToPage(
              context,
              Scaffold(
                  body: StreamChannel(
                channel: snapshot.channel!,
                child: const ChannelPage(),
              )));
        }
      }, builder: (context, snapshot) {
        return Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Verify your identity'),
              snapshot.file != null
                  ? Image.file(
                      snapshot.file!,
                      height: 150,
                    )
                  : const Placeholder(
                      fallbackHeight: 100,
                      fallbackWidth: 100,
                    ),
              IconButton(
                onPressed: context.read<GroupSelectionCubit>().pickImage,
                icon: const Icon(Icons.photo),
              ),
              TextField(
                controller:
                    context.read<GroupSelectionCubit>().nameTextController,
                decoration: const InputDecoration(
                  hintText: 'Name group',
                ),
              ),
              Wrap(
                children: List.generate(
                  selectedUsers.length,
                  (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(),
                      Text(selectedUsers[index].chatUser!.name!),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: context.read<GroupSelectionCubit>().createGroup,
                  child: const Text('Next'))
            ],
          )),
        );
      }),
    );
  }
}
