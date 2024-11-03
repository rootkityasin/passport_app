import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert'; // For jsonDecode
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:pms_flutter_app/users/setting.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'apply.dart';
import '../config.dart';
import 'reissue.dart';
import 'missing.dart';
import 'status.dart';
import '../login.dart';

class UserDashboard extends StatefulWidget {
  final String token;
  const UserDashboard({required this.token, super.key});

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  late String email = '';
  late String fname = '';
  late String lname = '';
  late String userId = '';
  bool hasNewNotification = true;

  File? _imageFile; // File to hold the selected image
  final picker = ImagePicker(); // ImagePicker instance

  @override
  void initState() {
    super.initState();
    _decodeTokenAndFetchUserData();
  }

  void _decodeTokenAndFetchUserData() async {
    try {
      // Decode the token to get the user ID
      Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
      userId =
          decodedToken['_id']; // Updated to match the backend token structure

      if (userId.isEmpty) {
        print('Error: userId is null or empty');
        return;
      }

      final response = await http.get(Uri.parse('$userdata/$userId'));

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          email = userData['email'] ?? '';
          fname = userData['fname'] ?? '';
          lname = userData['lname'] ?? '';
        });
        print('User data fetched: $userData');
      } else {
        print('Failed to load user data');
      }
    } catch (e) {
      print('Error in _decodeTokenAndFetchUserData: $e');
    }
  }

  // List of pages corresponding to each BottomNavigationBar item
  final List<Widget> _pages = [
    const UserDashboard(token: 'test_token'),
    const SettingsPage(token: 'test_token'),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleNotificationPress() {
    // Handle notification press
    // Once the user views the notifications, set the state to remove the red dot
    setState(() {
      hasNewNotification = false;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Update state with selected image
      });
    }
    // Open the file picker
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.image, // Specify that we are only picking image files
    // );
    //
    // if (result != null && result.files.single.path != null) {
    //   setState(() {
    //     _imageFile =
    //         File(result.files.single.path!); // Update state with selected image
    //   });
    // }
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
            UserAccountsDrawerHeader(
              accountName: Text("$fname $lname"),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!) // Display selected image
                      : const AssetImage('images/govt.png')),
              decoration: const BoxDecoration(
                color: Colors.teal, // Background color of the header
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                // Handle Dashboard tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDashboard(token: widget.token),
                  ),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(token: widget.token),
                  ),
                );
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
                        MaterialPageRoute(
                            builder: (context) => const ApplyPage()),
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
                            builder: (context) =>
                                StatusPage(token: widget.token)),
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
          transform: isHovered ? Matrix4.identity().scaled(1.04) : Matrix4.identity(), // Scale on hover
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3), // Card background color
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(isHovered ? 0.8 : 0.5), // Shadow effect on hover
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
                    Icon(icon, color: iconColor, size: 35), // Icon size and color
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
                      backgroundColor: const Color(0xFF186343), // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Rounded corners
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
}
