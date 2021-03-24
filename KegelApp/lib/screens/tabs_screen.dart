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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.red],
            ),
          ),
        ),
        title: Text(
          "Kegel App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.grey]),
        ),
        child: _pages[_selectedPageIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.orange,
              Colors.red,
            ],
          ),
        ),
        child: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: "Mein Club",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_bar),
              label: "Session",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports),
              label: "Spiele",
            ),
          ],
        ),
      ),
    );
  }
}
