import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'apply.dart';
import 'reissue.dart';
import 'missing.dart';
import 'status.dart';
import 'login.dart';

class UserDashboard extends StatefulWidget {
  final token;
  const UserDashboard({@required this.token, super.key});

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  late String email;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['email'];
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu button press
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.doorbell),
            onPressed: () {
              // Handle profile icon press
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Parvez"),
              accountEmail: Text("UI / UX ENGINEER"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/govt.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.teal, // Background color of the header
              ),
            ),
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
                // Handle myOrders tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Passport Status'),
              onTap: () {
                // Handle Schedules tap
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
                Navigator.pushNamed(context, '/setting');
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
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0, //space between cards
                mainAxisSpacing: 16.0,
                children: [
                  _buildAnimatedCard(
                    "Apply", // Card title
                    "Start New Application", // Card subtitle
                    Icons.assignment, // Card icon
                    Colors.blue, // Icon color
                    () {
                      // Navigate to Apply Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Apply()),
                      );
                    },
                  ),
                  _buildAnimatedCard(
                    "Reissue", // Card title
                    "Reissue or Renew", // Card subtitle
                    Icons.refresh, // Card icon
                    Colors.green, // Icon color
                    () {
                      // Navigate to Reissue Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReissuePage()),
                      );
                    },
                  ),
                  _buildAnimatedCard(
                    "Missing/Lost", // Card title
                    "Report Lost or Stolen", // Card subtitle
                    Icons.report, // Card icon
                    Colors.red, // Icon color
                    () {
                      // Navigate to Missing/Lost Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MissingLostPage()),
                      );
                    },
                  ),
                  _buildAnimatedCard(
                    "Status", // Card title
                    "Check Your Status", // Card subtitle
                    Icons.info, // Card icon
                    Colors.orange, // Icon color
                    () {
                      // Navigate to Status Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StatusPage()),
                      );
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
                          color: Colors.green,
                        ),
                      ),
                      const Icon(Icons.home, color: Colors.black),
                    ],
                  )
                : const Icon(Icons.home, color: Colors.black),
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
                          color: Colors.green,
                        ),
                      ),
                      const Icon(Icons.credit_card, color: Colors.black),
                    ],
                  )
                : const Icon(Icons.credit_card, color: Colors.black),
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
                          color: Colors.green,
                        ),
                      ),
                      const Icon(Icons.person, color: Colors.black),
                    ],
                  )
                : const Icon(Icons.person, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      const Icon(Icons.qr_code, color: Colors.black),
                    ],
                  )
                : const Icon(Icons.qr_code, color: Colors.black),
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
    return Card(
      color: const Color(0xFFD9D9D9), // Set the card color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 35), // Icon size
                const SizedBox(width: 20), // Space between icon and title
                Expanded(
                  child: Text(
                    title, // Card title
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Spacer(), // Pushes the button to the bottom
            Center(
              child: ElevatedButton(
                onPressed: onPressed, // Handle button press
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF186343), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0), // Increase padding
                  textStyle:
                      const TextStyle(fontSize: 16), // Increase font size
                ),
                child: Text(
                  subtitle, // Card subtitle
                  style: TextStyle(color: textColor), // Custom font color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
