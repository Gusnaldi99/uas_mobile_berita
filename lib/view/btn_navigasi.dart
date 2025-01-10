import 'package:flutter/material.dart';
import 'package:uas_mobile_berita/view/bookmark_screen.dart';
import 'package:uas_mobile_berita/view/categories_screen.dart';
import 'home_screen.dart';

class MyButton extends StatefulWidget {
  const MyButton({super.key});

  @override
  State<MyButton> createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  int idx = 0;

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

// Content yang akan ditampilkan dihalaman utama
  Widget getBody() {
    switch (idx) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CategoriesScreen();
      case 2:
        return const BookmarkScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          getBody(), //memenaggil wigdet getbody agar tampil button navbar dihalaman utama
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        selectedItemColor: const Color.fromARGB(255, 255, 17, 0),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: onItemTap, //mengatur nilai idx berdasarkan tap yang dipilih
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Bookmark",
          ),
        ],
      ),
    );
  }
}
