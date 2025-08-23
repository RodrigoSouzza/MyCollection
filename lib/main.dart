import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/collection_screen.dart';
import 'screens/register_screen.dart';
import 'providers/minifigure_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (_) => MinifigureProvider(),
    child: const MinifigsApp(),
    )
  );
}

class MinifigsApp extends StatefulWidget {
  const MinifigsApp({super.key});

  @override
  State<MinifigsApp> createState() => _MinifigsAppState();
}

class _MinifigsAppState extends State<MinifigsApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CollectionScreen(),
    const RegisterScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minifigs Manager',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.toys),
              label: "Coleção",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Registrar",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}