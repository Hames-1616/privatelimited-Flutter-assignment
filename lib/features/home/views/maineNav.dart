import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:privatelimited/features/home/views/allcategories.dart';
import 'package:privatelimited/features/home/views/mainpage.dart';




class mainScreen extends StatefulWidget {

  static route() => MaterialPageRoute(builder: (context) => mainScreen());
  mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
 

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

  EdgeInsets padding = const EdgeInsets.all(12);

  int pos = 0;

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;

  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;

  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;

  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];

  List<Widget> ui = const [Mainpage(),categories()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ui[pos],
      bottomNavigationBar:SnakeNavigationBar.color(
        // height: 80,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        ///configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: pos,
        onTap: (index) => setState(() => pos = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
        
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}