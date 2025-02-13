import 'package:flutter/material.dart';
import 'pages/ingredient_buddy_page.dart';
import 'pages/RepoCrawl.dart';
import 'pages/placeholder_page_two.dart';
import 'widgets/side_navigation_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'IngredientBuddy',
        theme: ThemeData(
          colorScheme: ColorScheme.dark(),
          useMaterial3: true,
        ),
        home: const MainLayout(),
      );
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  static const List<Widget> _pages = [
    IngredientBuddyPage(),
    RepoCrawl(),
    PlaceholderPageTwo(),
  ];

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Row(
          children: [
            SideNavigationBar(
              selectedIndex: _selectedIndex,
              onIndexChanged: (index) => setState(() => _selectedIndex = index),
            ),
            Expanded(
              child: ColoredBox(
                color: const Color(0xFF121212),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: MainLayout._pages[_selectedIndex],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
