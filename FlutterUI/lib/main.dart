import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'pages/ingredient_buddy_page.dart';
import 'pages/repo_crawl_page.dart';
import 'pages/placeholder_page_two.dart';
import 'widgets/side_navigation_bar.dart';
import 'core/services/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'IngredientBuddy',
        theme: AppTheme.darkTheme,
        home: const MainLayout(),
      );
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  static const List<Widget> _pages = [
    IngredientBuddyPage(),
    RepoCrawlPage(),
    PlaceholderPageTwo(),
  ];

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          children: [
            SideNavigationBar(
              selectedIndex: _selectedIndex,
              onIndexChanged: (index) => setState(() => _selectedIndex = index),
            ),
            Expanded(
              child: MainLayout._pages[_selectedIndex],
            ),
          ],
        ),
      );
}
