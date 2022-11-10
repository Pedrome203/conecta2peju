/*import 'package:conecta2peju/ui/home/chat/selection/friend_selection_view.dart';

import 'package:conecta2peju/ui/profile_verify/profile_verify_cubit.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileVerifyView extends StatelessWidget {
  const ProfileVerifyView();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileVerifyCubit(context.read(), context.read()),
      child: BlocConsumer<ProfileVerifyCubit, ProfileState>(
          listener: (context, snapshot) {
        if (snapshot.success!) {
          pushAndReplaceToPage(context, const FriendSelectionView());
        }
      }, builder: (context, snapshot) {
        // refresh the photo
        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Verify your identity"),
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
                  onPressed: () {
                    context.read<ProfileVerifyCubit>().pickImage();
                  },
                  icon: const Icon(Icons.photo)),
              const Text("Your name"),
              TextField(
                controller: context.read<ProfileVerifyCubit>().nameController,
                decoration: const InputDecoration(
                  hintText: "Or just how people now you",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ProfileVerifyCubit>().startChatting();
                },
                child: const Text("Start chatting now"),
              )
            ],
          ),
        ));
      }),
    );
  }
}
*/