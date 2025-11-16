import "package:flutter/material.dart";
import "product_posting_screen.dart";
import "dashboard_screen.dart";
import "reports_screen.dart";
import "login_screen.dart";

class HomeScreen extends StatefulWidget {
  final String userType;

  const HomeScreen({super.key, required this.userType});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [];
  final List<BottomNavigationBarItem> _navBarItems = [];

  @override
  void initState() {
    super.initState();
    _buildNavItems();
  }

  void _buildNavItems() {
    bool isFarmer = widget.userType == "Farmer";
    bool isAdmin = widget.userType == "Admin";

    // Home is always present
    _pages.add(const Center(child: Text("Welcome Home!")));
    _navBarItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ));

    if (isFarmer) {
      _pages.add(const ProductPostingScreen());
      _navBarItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.add_shopping_cart),
        label: "Post Product",
      ));
    }

    if (isFarmer || isAdmin) {
      _pages.add(const DashboardScreen());
      _navBarItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: "Dashboard",
      ));
      _pages.add(const ReportsScreen());
      _navBarItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.report),
        label: "Reports",
      ));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.userType} Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Important for more than 3 items
      ),
    );
  }
}
