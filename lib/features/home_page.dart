import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _searchKey = GlobalKey();
  final GlobalKey _notificationKey = GlobalKey();
  final GlobalKey _profileTabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstTime();
    });
  }

  Future<void> _isFirstTime() async {
    // final prefs = await SharedPreferences.getInstance();
    // bool isFirstTime = prefs.getBool('is_first_time_home') ?? true;

    // if (isFirstTime) {
    if (mounted) {
      ShowCaseWidget.of(
        context,
      ).startShowCase([_homeKey, _searchKey, _notificationKey, _profileTabKey]);
      // await prefs.setBool('is_first_time_home', false);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Center(child: Text("Home Screen")),
      const Center(child: Text("Search Screen")),
      const Center(child: Text("Notification Screen")),
      ProfileScreen(isActive: _currentIndex == 3),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Bottom Nav App"), centerTitle: true),
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildCustomShowcase(
              key: _homeKey,
              title: "হোম",
              description: "এখান থেকে আপনি আপনার হোম স্ক্রিন দেখতে পারবেন।",
              index: "১/৪",
              child: const Icon(Icons.home),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildCustomShowcase(
              key: _searchKey,
              title: "সার্চ",
              description: "যেকোনো কিছু খুঁজে পেতে এখানে ক্লিক করুন।",
              index: "২/৪",
              child: const Icon(Icons.search),
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: _buildCustomShowcase(
              key: _notificationKey,
              title: "নোটিফিকেশন",
              description: "আপনার সব নোটিফিকেশন এখানে পাবেন।",
              index: "৩/৪",
              child: const Icon(Icons.notifications),
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: _buildCustomShowcase(
              key: _profileTabKey,
              title: "প্রোফাইল",
              description: "আপনার প্রোফাইল ম্যানেজ করতে এখানে ক্লিক করুন।",
              index: "৪/৪",
              child: const Icon(Icons.person),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildCustomShowcase({
    required GlobalKey key,
    required String title,
    required String description,
    required String index,
    required Widget child,
  }) {
    return Showcase.withWidget(
      key: key,
      height: 160,
      width: 280,
      targetPadding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 22),
      targetShapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      container: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 200),
                Text(
                  index,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      ShowCaseWidget.of(context).dismiss();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text(
                      "আমি পরে করব",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () {
                      ShowCaseWidget.of(context).next();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text(
                      "পরবর্তী ধাপ",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
