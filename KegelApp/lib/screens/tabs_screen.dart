import 'package:KegelApp/screens/games_screen.dart';
import 'package:KegelApp/screens/my_club_screen.dart';
import 'package:KegelApp/screens/sessions_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //Pages for the different bottom nav buttons
  final List<Widget> _pages = [MyClubScreen(), SessionScreen(), GamesScreen()];
  int _selectedPageIndex = 0;

  //select Pages by index
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //builds the bottom navigation bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 48, 48, 1),
        title: Text(
          "Kegel App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromRGBO(217, 226, 236, 1),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(48, 48, 48, 1),
      body: Container(
        child: _pages[_selectedPageIndex],
      ),
      bottomNavigationBar: Container(
        color: Color.fromRGBO(48, 48, 48, 1),
        child: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Color.fromRGBO(48, 48, 48, 1),
          selectedItemColor: Color.fromRGBO(51, 78, 104, 1),
          unselectedItemColor: Color.fromRGBO(217, 226, 236, 0.6),
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: "Mein Club",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_bar),
              label: "Kegelabend",
            ),
            //Maybe in future add feature to play simple games in app
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.sports_esports),
            //   label: "Spiele",
            // ),
          ],
        ),
      ),
    );
  }
}
