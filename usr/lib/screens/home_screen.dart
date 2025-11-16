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

  static const List<Widget> _widgetOptions = <Widget>[
    Text("Home"),
    ProductPostingScreen(),
    DashboardScreen(),
    ReportsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFarmer = widget.userType == "Farmer";

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          if (isFarmer)
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: "Post Product",
            ),
          if (isFarmer)
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
          if (isFarmer)
            const BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: "Reports",
            ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
