import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pms_flutter_app/admin/admin_request.dart';
import 'package:pms_flutter_app/admin/AdminMissingRequest.dart';

import 'package:http/http.dart' as http;

import '../login.dart';

class AdminDashboard extends StatefulWidget {
  final String token;
  const AdminDashboard({required this.token, super.key});

  @override
  AdminDashboardState createState() => AdminDashboardState();
}

class AdminDashboardState extends State<AdminDashboard> {
  late String aid;
  int totalApplicants = 0;
  List<dynamic> applications = [];

@override
void initState() {
  super.initState();
  Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  aid = jwtDecodedToken['aid'];
  fetchApplications();
  fetchMissingRequests();
}

  Future<void> fetchApplications() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/api/admin/applications'));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('applications')) {
          setState(() {
            applications = responseData['applications'] as List<dynamic>;
            totalApplicants = applications.length;
          });

          print('Total applicants: $totalApplicants');
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else {
        throw Exception('Failed to load applications');
      }
    } catch (e) {
      print('Error fetching applications: $e');
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int totalMissingRequests = 0;

  Future<void> fetchMissingRequests() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:3000/api/missing'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic> && responseData.containsKey('reports')) {
        setState(() {
          totalMissingRequests = responseData['reports'].length;
        });
        print('Total missing requests: $totalMissingRequests');
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load missing requests');
    }
  } catch (e) {
    print('Error fetching missing requests: $e');
  }
}


 Widget _buildAnimatedCard(String title, String subtitle, IconData icon,
      Color iconColor, VoidCallback onPressed,
      {Color textColor = Colors.white}) {
    bool isHovered = false; // Track hover state

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
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3), // Card background color
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: iconColor.withOpacity(
                      isHovered ? 0.8 : 0.5), // Shadow effect on hover
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
                      Icon(icon,
                          color: iconColor, size: 35), // Icon size and color
                      const SizedBox(width: 20), // Space between icon and title
                      Expanded(
                        child: Text(
                          title, // Card title
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
                        backgroundColor:
                            const Color(0xFF186343), // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Rounded corners
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
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
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0, // space between cards
                mainAxisSpacing: 16.0,
                children: [
                  _buildAnimatedCard(
                    "Total Request ($totalApplicants)", // Card title
                    "Check Request", // Card subtitle
                    Icons.assignment, // Card icon
                    Colors.blue, // Icon color
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminRequest()));
                    },
                  ),
                  _buildAnimatedCard(
                    "Reissue", // Card title
                    "Reissue or Renew", // Card subtitle
                    Icons.refresh, // Card icon
                    Colors.green, // Icon color
                    () {
                      // Navigate to Reissue Page
                    },
                  ),
                  _buildAnimatedCard(
                    "Missing/Lost ($totalMissingRequests)", 
                    "Report Lost or Stolen", 
                    Icons.report, 
                    Colors.red, 
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminMissingRequest(),
                        ),
                      );
                    },
                  ),
                  _buildAnimatedCard(
                    "Status", // Card title
                    "Check Your Status", // Card subtitle
                    Icons.info, // Card icon
                    Colors.orange, // Icon color
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminRequest()),
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
                      const Icon(Icons.settings, color: Colors.black),
                    ],
                  )
                : const Icon(Icons.settings, color: Colors.black),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
