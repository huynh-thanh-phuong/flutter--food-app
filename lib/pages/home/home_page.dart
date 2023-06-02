import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/pages/account/account_page.dart';
import 'package:flutter_food_delivery/pages/cart/cart_history.dart';
import 'package:flutter_food_delivery/pages/home/main_food_page.dart';

import '../../utils/colors.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List page = [
    const MainFoodPage(),
    const Center(child: Text("Next page")),
    const CartHistory(),
    const AccountPage(),
  ];
  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedIndex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "History",
          ),BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

}
