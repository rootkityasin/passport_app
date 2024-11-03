import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pms_flutter_app/users/user_dashboard.dart';
import 'dart:io';
import '../config.dart';
import '../login.dart';

class SettingsPage extends StatefulWidget {
  final String token;
  const SettingsPage({required this.token, super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String email = '';
  late String fname = '';
  late String lname = '';
  late String userId = '';
  bool isEditing = false;
  bool isLoading = true;
  bool _passwordVisible = false;
  bool _notificationsEnabled = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _presentAddressController =
      TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File? _imageFile; // File to hold the selected image
  final picker = ImagePicker(); // ImagePicker instance

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _dobController.dispose();
    _presentAddressController.dispose();
    _permanentAddressController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _decodeTokenAndFetchUserData();

    // // Set up listeners to update full name controller when first or last name changes
    // _firstNameController.addListener(_updateFullName);
    // _lastNameController.addListener(_updateFullName);

    // AwesomeNotifications().actionStream.listen((receivedNotification) {
    //   if (receivedNotification.buttonKeyPressed == 'REPLY') {
    //     // Handle reply action
    //     print('User pressed reply');
    //   } else if (receivedNotification.buttonKeyPressed == 'MARK_READ') {
    //     // Handle mark as read action
    //     print('User marked as read');
    //   }
    // });
  }

  // void _updateFullName() {
  //   setState(() {
  //     _fullNameController.text =
  //         '${_firstNameController.text} ${_lastNameController.text}';
  //   });
  // }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.year}/${picked.month}/${picked.day}";
      });
    }
  }

  // Track the current selected tab
  int _selectedTabIndex = 0;

  // List of tab titles
  final List<String> _tabs = ['Edit Profile', 'Preference', 'Security'];

  // Function to update the tab index
  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle the action for each index
    if (index == 0) {
      print('Home tapped');
      // Add action for home
    } else if (index == 1) {
      print('Card tapped');
      // Add action for search
    } else if (index == 2) {
      print('Profile tapped');
      // Add action for profile
    } else if (index == 3) {
      print('Manage tapped');
      // Add action for profile
    }
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
          _firstNameController.text = fname;
          _lastNameController.text = lname;
          // _updateFullName();
          _emailController.text = userData['email'];
          _dobController.text = userData['dob'];

          // Parse and format the dob
          if (userData['dob'] != null) {
            DateTime parsedDate = DateTime.parse(userData['dob']);
            String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
            _dobController.text = formattedDate;
          }

          _countryController.text = userData['country'] ?? '';
          _presentAddressController.text = userData['presentaddress'] ?? '';
          _permanentAddressController.text = userData['permanentaddress'] ?? '';

          // Convert the phone number to a string
          if (userData['phone'] != null) {
            _phoneController.text = userData['phone'].toString();
          }
        });
        print('User data fetched: $userData');
      } else {
        print('Failed to load user data');
      }
    } catch (e) {
      print('Error in _decodeTokenAndFetchUserData: $e');
    }
  }

  // Function to update user data
  Future<void> _updateUserData() async {
    final response = await http.put(
      Uri.parse('$updatadata/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'fname': _firstNameController.text,
        'lname': _lastNameController.text,
        'email': _emailController.text,
        'country': _countryController.text,
        'dob': _dobController.text,
        'presentaddress': _presentAddressController.text,
        'permanentaddress': _permanentAddressController.text,
        'phone': int.parse(_phoneController.text),
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        isEditing = false;
      });
      _showSuccessAlert();
    } else {
      // Handle error
      _showErrorAlert();
    }
  }

  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('User data updated successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to update user data. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _toggleNotifications(bool value) async {
    if (value) {
      // Request permission to show notifications
      bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        // Show a pop-up requesting permission
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }

      // After requesting permission, enable notifications if allowed
      isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (isAllowed) {
        setState(() {
          _notificationsEnabled = true;
        });

        // Show your first notification
        _scheduleNotifications();
      }
    } else {
      setState(() {
        _notificationsEnabled = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification permission not granted')),
      );
    }
  }

  void _scheduleNotifications() {
    // Notification 1: Immediate
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Immediate Notification',
        body: 'This is an immediate notification.',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'REPLY',
          label: 'Reply',
        ),
        NotificationActionButton(
          key: 'MARK_READ',
          label: 'Mark as Read',
        ),
      ],
    );

    // Notification 2: 5 minutes later
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'basic_channel',
        title: '5 Minutes Later',
        body: 'This notification is scheduled for 5 minutes later.',
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime.now().add(const Duration(minutes: 5)),
      ),
    );

    // Notification 3: 1 hour later
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 3,
        channelKey: 'basic_channel',
        title: '1 Hour Later',
        body: 'This notification is scheduled for 1 hour later.',
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime.now().add(const Duration(hours: 1)),
      ),
    );
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
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
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
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              if (isEditing) {
                _updateUserData(); // Call save function if currently editing
              }
              setState(() {
                isEditing = !isEditing; // Toggle editing state
              });
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search for something',
              ),
            ),
          ),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!) // Display selected image
                      : const AssetImage('images/govt.png')
                          as ImageProvider, // Default image
                  radius: 40, // Adjust the radius if needed
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage, // Set the action to pick an image
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (index) {
              return TextButton(
                onPressed: () => _onTabSelected(index),
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    fontWeight: _selectedTabIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            }),
          ),
          const Divider(),

          // Render the content based on selected tab
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _getContentForSelectedTab(),
            ),
          ),
        ],
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

  // Function to render content based on the selected tab
  Widget _getContentForSelectedTab() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildEditProfile();
      case 1:
        return _buildPreference();
      case 2:
        return _buildSecurity();
      default:
        return _buildEditProfile();
    }
  }

  // Edit Profile Content
  Widget _buildEditProfile() {
    return ListView(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(labelText: 'First Name'),
          readOnly: !isEditing,
          // initialValue: 'Charline Read',
        ),
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(labelText: 'Last Name'),
          readOnly: !isEditing,
          // initialValue: 'Charline Read',
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          readOnly: !isEditing,
          // initialValue: 'charlineread@gmail.com',
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _countryController,
          decoration: const InputDecoration(labelText: 'Country'),
          readOnly: !isEditing,
          // initialValue: 'USA',
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _dobController,
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            prefixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
          readOnly: !isEditing,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _presentAddressController,
          decoration: const InputDecoration(labelText: 'Present Address'),
          readOnly: !isEditing,
          // initialValue: 'San Jose, California, USA',
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _permanentAddressController,
          decoration: const InputDecoration(labelText: 'Permanent Address'),
          readOnly: !isEditing,
          // initialValue: 'San Jose, California, USA',
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(labelText: 'Phone'),
          readOnly: !isEditing,
          keyboardType: TextInputType.phone,
          // initialValue: 'San Jose',
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),

          readOnly: !isEditing,
          // initialValue: '********',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            } else if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            return null;
          },
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: _confirmPasswordController,
          decoration: const InputDecoration(
            labelText: 'Confirm Password',
          ),
          readOnly: !isEditing,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            } else if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        const SizedBox(height: 20), // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     onPressed: isEditing
        //         ? _updateUserData
        //         : null, // Save profile only if editing,
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.green,
        //       padding: const EdgeInsets.all(16.0),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //       ),
        //     ),
        //     child: const Text(
        //       'Save',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // Preference Content
  Widget _buildPreference() {
    return ListView(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Time Zone',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          value: '(GMT-12:00) International Date Line West',
          items: <String>[
            '(GMT-12:00) International Date Line West',
            '(GMT-11:00) Midway Island, Samoa',
            '(GMT-10:00) Hawaii',
            '(GMT-09:00) Alaska',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {});
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Notification', style: TextStyle(fontSize: 16.0)),
            Switch(
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Save settings or perform other actions
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  // Security Content
  Widget _buildSecurity() {
    return const Center(
      child: Text(
        'Security Settings Coming Soon...',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
