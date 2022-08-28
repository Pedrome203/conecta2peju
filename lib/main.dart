import 'package:conecta2peju/data/rest/card_rest_service.dart';
import 'package:conecta2peju/dependecies.dart';
import 'package:conecta2peju/domain/models/repository/card_api.dart';
import 'package:conecta2peju/ui/home/feed/feed_news_cubit.dart';
import 'package:conecta2peju/ui/splash/splash_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/material/text_theme.dart' as texttheme;
import 'package:flutter/services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _streamChatClient = StreamChatClient("nkfawvb2yjwd");

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return MultiRepositoryProvider(
        providers: buildRepositories(_streamChatClient),
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => FeedNewsProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              home: const SplashView(),
              theme: ThemeData(
                  colorScheme: const ColorScheme(
                      primary: Color.fromARGB(100, 34, 108, 138),
                      primaryContainer: Color.fromARGB(255, 34, 108, 138),
                      secondary: Color.fromARGB(255, 147, 27, 27),
                      secondaryContainer: Color.fromARGB(255, 255, 255, 255),
                      surface: Color(0xFFFFFEFB),
                      background: Color.fromARGB(255, 255, 255, 255),
                      error: Color.fromARGB(255, 81, 24, 24),
                      onPrimary: Color.fromARGB(255, 25, 143, 127),
                      onSecondary: Color.fromARGB(255, 155, 149, 149),
                      onSurface: Color.fromARGB(255, 59, 58, 58),
                      onBackground: Color(0x3A7B7474),
                      onError: Color(0xFF5F872C),
                      brightness: Brightness.light),
                  textTheme: const texttheme.TextTheme(
                    bodyText1: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 18,
                      color: Color.fromARGB(255, 104, 104, 104),
                    ),
                    bodyText2: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold),
                    subtitle1: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 17,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    subtitle2: TextStyle(fontFamily: 'Calibri', fontSize: 20),
                    headline6: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w400),
                    headline5: TextStyle(
                        color: Color.fromARGB(255, 82, 79, 79),
                        fontFamily: 'Calibri',
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                    headline4: TextStyle(
                        color: Color.fromARGB(255, 59, 58, 58),
                        fontFamily: 'Calibri',
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    headline3: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Calibri',
                        fontWeight: FontWeight.w400,
                        fontSize: 22),
                  )),
              builder: (context, child) {
                return StreamChat(client: _streamChatClient, child: child);
              },
            )));
  }
}
