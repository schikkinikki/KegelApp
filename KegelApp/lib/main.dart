import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/session.dart';
import 'package:KegelApp/screens/games_screen.dart';
import 'package:KegelApp/screens/my_club_screen.dart';
import 'package:KegelApp/screens/new_session_screen.dart';
import 'package:KegelApp/screens/old_session_detail_screen.dart';
import 'package:KegelApp/screens/old_session_screen_v2.dart';
import 'package:KegelApp/screens/sessions_screen.dart';
import 'package:KegelApp/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/kegelbruder.dart';

void main() {
  runApp(KegelApp());
}

class KegelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemberListClass()),
        ChangeNotifierProvider(create: (context) => Kegelbruder.c2()),
        ChangeNotifierProvider(create: (context) => SessionProvider()),
      ],
      child: MaterialApp(
        home: TabsScreen(),
        routes: {
          MyClubScreen.routeName: (ctx) => MyClubScreen(),
          SessionScreen.routeName: (ctx) => SessionScreen(),
          GamesScreen.routeName: (ctx) => GamesScreen(),
          NewSessionScreen.routeName: (ctx) => NewSessionScreen(),
          OldSessionScreenV2.routeName: (ctx) => OldSessionScreenV2(),
          OldSessionDetailScreen.routeName: (ctx) => OldSessionDetailScreen()
        },
      ),
    );
  }
}
