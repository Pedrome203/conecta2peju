import 'package:conecta2peju/data/auth_repository.dart';
import 'package:conecta2peju/data/image_picker_repository.dart';
import 'package:conecta2peju/data/local/auth_local_impl.dart';
import 'package:conecta2peju/data/local/image_picker_impl.dart';
import 'package:conecta2peju/data/local/stream_api_local_impl.dart';
import 'package:conecta2peju/data/local/upload_storage_local_impl.dart';
import 'package:conecta2peju/data/stream_api_repository.dart';
import 'package:conecta2peju/data/upload_storage_repository.dart';
import 'package:conecta2peju/domain/usecases/create_group_usecase.dart';
import 'package:conecta2peju/domain/usecases/login_usecase.dart';
import 'package:conecta2peju/domain/usecases/logout_usecase.dart';
import 'package:conecta2peju/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client) {
  return [
    RepositoryProvider<StreamApiRepository>(
        create: (_) => StreamApiLocalImpl(client)),
    RepositoryProvider<AuthRepository>(create: (_) => AuthLocalImpl()),
    RepositoryProvider<UploadStorageRepository>(
        create: (_) => UploadStorageLocalImpl()),
    RepositoryProvider<ImagePickerRepository>(create: (_) => ImagePickerImpl()),
    RepositoryProvider<ProfileSignInUseCase>(
      create: (context) => ProfileSignInUseCase(
        context.read(),
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<CreateGroupUseCase>(
      create: (context) => CreateGroupUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LogoutUseCase>(
      create: (context) => LogoutUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LoginUseCase>(
      create: (context) => LoginUseCase(
        context.read(),
        context.read(),
      ),
    ),
  ];
}
