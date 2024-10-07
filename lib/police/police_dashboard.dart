import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../login.dart';

class PoliceDashboard extends StatefulWidget {
  final String token;
  const PoliceDashboard({required this.token, super.key});

  @override
  PoliceDashboardState createState() => PoliceDashboardState();
}

class PoliceDashboardState extends State<PoliceDashboard> {
  late String pid;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    pid = jwtDecodedToken['pid'];
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
        title: const Text('Police Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Handle menu button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                // Handle Dashboard tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.doorbell),
              title: const Text('Notification'),
              onTap: () {
                // Handle Notification tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Passport Status'),
              onTap: () {
                // Handle Passport Status tap
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.work),
              title: const Text('Services'),
              children: <Widget>[
                ListTile(
                  title: const Text('Reissue Passport'),
                  onTap: () {
                    // Handle Reissue Passport tap
                  },
                ),
                ListTile(
                  title: const Text('Report Lost/Stolen Passport'),
                  onTap: () {
                    // Handle Report Lost/Stolen Passport tap
                  },
                ),
                ListTile(
                  title: const Text('Contact Counceller'),
                  onTap: () {
                    // Handle Contact Counceller tap
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle Settings tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                // Handle Help tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout Account'),
              onTap: () {
                // Handle Logout tap
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                hintText: 'Search for something',
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor:
                    Colors.grey[200], // Background color of the search bar
              ),
            ),
            const SizedBox(height: 50), // Increased height to lower the cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildAnimatedCard(
                    "Verify Applications", // Card title
                    "Check and Verify", // Card subtitle
                    Icons.verified_user, // Card icon
                    Colors.blue, // Icon color
                    () {
                      // Handle card press
                    },
                  ),
                  _buildAnimatedCard(
                    "View Reports", // Card title
                    "Check Reports", // Card subtitle
                    Icons.report, // Card icon
                    Colors.red, // Icon color
                    () {
                      // Handle card press
                    },
                  ),
                  _buildAnimatedCard(
                    "Settings", // Card title
                    "Configure System", // Card subtitle
                    Icons.settings, // Card icon
                    Colors.green, // Icon color
                    () {
                      // Handle card press
                    },
                  ),
                  _buildAnimatedCard(
                    "Notifications", // Card title
                    "View Alerts", // Card subtitle
                    Icons.notifications, // Card icon
                    Colors.orange, // Icon color
                    () {
                      // Handle card press
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // To maintain colors for each item
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green, // Color for selected item
                        ),
                      ),
                      const Icon(Icons.home,
                          color: Colors.black), // Icon for home
                    ],
                  )
                : const Icon(Icons.home, color: Colors.black), // Icon for home
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green, // Color for selected item
                        ),
                      ),
                      const Icon(Icons.search,
                          color: Colors.black), // Icon for search
                    ],
                  )
                : const Icon(Icons.search,
                    color: Colors.black), // Icon for search
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green, // Color for selected item
                        ),
                      ),
                      const Icon(Icons.account_circle,
                          color: Colors.black), // Icon for account
                    ],
                  )
                : const Icon(Icons.account_circle,
                    color: Colors.black), // Icon for account
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green, // Color for the selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        showSelectedLabels: false, // Hides labels
        showUnselectedLabels: false, // Hides labels
      ),
    );
  }

  Widget _buildAnimatedCard(String title, String subtitle, IconData icon,
      Color iconColor, VoidCallback onPressed,
      {Color textColor = Colors.white}) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            transform: isHovered
                ? Matrix4.identity().scaled(1.04)
                : Matrix4.identity(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(isHovered ? 0.8 : 0.5),
                    blurRadius: isHovered ? 20.0 : 0.5,
                    spreadRadius: isHovered ? 5.0 : 0.5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: iconColor, size: 35),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF186343),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: Text(
                          subtitle,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
