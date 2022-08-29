import 'package:conecta2peju/ui/home/chat/selection/friend_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../utils/navigator_utils.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child: Stack(children: <Widget>[
          ChannelListView(
            filter:
                Filter.in_('members', [StreamChat.of(context).currentUser!.id]),
            sort: const [SortOption('last_message_at')],
            channelWidget: const ChannelPage(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.background,
                focusColor: Theme.of(context).colorScheme.onBackground,
                onPressed: () {
                  pushToPage(context, const FriendSelectionView());
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: const [
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
