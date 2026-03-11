import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final bool isActive;
  const ProfileScreen({super.key, this.isActive = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey _profileKey = GlobalKey();
  final GlobalKey _babyKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _orderKey = GlobalKey();
  final GlobalKey _settingsKey = GlobalKey();
  final GlobalKey _logoutKey = GlobalKey();

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startShowcase(context);
      });
    }
  }

  Future<void> _startShowcase(BuildContext context) async {
    // final prefs = await SharedPreferences.getInstance();
    // bool isFirstTime = prefs.getBool("profile_tooltip_shown") ?? true;

    // if (isFirstTime) {
      if (mounted) {
        ShowCaseWidget.of(context).startShowCase([
          _profileKey,
          _babyKey,
          _aboutKey,
          _orderKey,
          _settingsKey,
          _logoutKey,
        ]);
        // await prefs.setBool("profile_tooltip_shown", false);
      }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCustomShowcase(
            key: _profileKey,
            title: "প্রোফাইল তথ্য",
            description: "এখান থেকে আপনার ব্যক্তিগত তথ্য দেখতে ও পরিবর্তন করতে পারবেন।",
            index: "১/৬",
            child: _buildTile(
              icon: Icons.person,
              title: "Ratul Ahmed Shafin",
              subtitle: "View your profile",
            ),
          ),
          const SizedBox(height: 20),
          _buildCustomShowcase(
            key: _babyKey,
            title: "বেবি প্রোফাইল",
            description: "আপনার সন্তানের প্রোফাইল ম্যানেজ করুন এখান থেকে।",
            index: "২/৬",
            child: _buildTile(
              icon: Icons.child_care,
              title: "Ratul Ahmed Rup",
              subtitle: "Main profile",
            ),
          ),
          const SizedBox(height: 20),
          _buildTile(
            icon: Icons.card_giftcard,
            title: "Reward Points",
            trailing: "1200",
          ),
          const SizedBox(height: 30),
          _buildCustomShowcase(
            key: _aboutKey,
            title: "আমাদের সম্পর্কে",
            description: "আমাদের সম্পর্কে বিস্তারিত জানতে এখানে ক্লিক করুন।",
            index: "৩/৬",
            child: _buildTile(
              icon: Icons.info,
              title: "About Us",
            ),
          ),
          const SizedBox(height: 20),
          _buildCustomShowcase(
            key: _orderKey,
            title: "অর্ডার লিস্ট",
            description: "আপনার সব অর্ডার এবং স্ট্যাটাস এখানে দেখুন।",
            index: "৪/৬",
            child: _buildTile(
              icon: Icons.shopping_bag,
              title: "Order List",
            ),
          ),
          const SizedBox(height: 20),
          _buildCustomShowcase(
            key: _settingsKey,
            title: "সেটিংস",
            description: "অ্যাপের ভাষা ও অন্যান্য সেটিংস পরিবর্তন করুন।",
            index: "৫/৬",
            child: _buildTile(
              icon: Icons.settings,
              title: "Settings",
            ),
          ),
          const SizedBox(height: 20),
          _buildCustomShowcase(
            key: _logoutKey,
            title: "লগ আউট",
            description: "অ্যাকাউন্ট থেকে লগ আউট করতে এখানে ক্লিক করুন।",
            index: "৬/৬",
            child: _buildTile(
              icon: Icons.logout,
              title: "Log Out",
            ),
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
                Text(
                  index,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
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
                ElevatedButton(
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
              ],
            ),
          ],
        ),
      ),
      child: child,
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    String? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                if (subtitle != null) Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          if (trailing != null) Text(trailing, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey)
        ],
      ),
    );
  }
}
