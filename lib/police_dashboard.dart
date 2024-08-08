import 'package:flutter/material.dart';

class PoliceDashboard extends StatefulWidget {
  const PoliceDashboard({required Key key}) : super(key: key);

  @override
  PoliceDashboardState createState() => PoliceDashboardState();
}

class PoliceDashboardState extends State<PoliceDashboard> {
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
				fillColor: Colors.grey[200], // Background color of the search bar
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
					  const Icon(Icons.home, color: Colors.black), // Icon for home
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
					  const Icon(Icons.search, color: Colors.black), // Icon for search
					],
				  )
				: const Icon(Icons.search, color: Colors.black), // Icon for search
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
					  const Icon(Icons.account_circle, color: Colors.black), // Icon for account
					],
				  )
				: const Icon(Icons.account_circle, color: Colors.black), // Icon for account
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

  Widget _buildAnimatedCard(String title, String subtitle, IconData icon, Color iconColor, VoidCallback onPressed, {Color textColor = Colors.white}) {
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
					title,
					style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
					borderRadius: BorderRadius.circular(12.0), // Rounded corners
				  ),
				  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Increase padding
				  textStyle: const TextStyle(fontSize: 16), // Increase font size
				),
				child: Text(
				  subtitle,
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

class PoliceDashboardPage extends StatefulWidget {
  const PoliceDashboardPage({Key? key}) : super(key: key);

  @override
  PoliceDashboardPageState createState() => PoliceDashboardPageState();
}

class PoliceDashboardPageState extends State<PoliceDashboardPage> {
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
                fillColor: Colors.grey[200], // Background color of the search bar
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
                      const Icon(Icons.home, color: Colors.black), // Icon for home
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
                      const Icon(Icons.search, color: Colors.black), // Icon for search
                    ],
                  )
                : const Icon(Icons.search, color: Colors.black), // Icon for search
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
                      const Icon(Icons.account_circle, color: Colors.black), // Icon for account
                    ],
                  )
                : const Icon(Icons.account_circle, color: Colors.black), // Icon for account
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

  Widget _buildAnimatedCard(String title, String subtitle, IconData icon, Color iconColor, VoidCallback onPressed, {Color textColor = Colors.white}) {
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
                    title,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Increase padding
                  textStyle: const TextStyle(fontSize: 16), // Increase font size
                ),
                child: Text(
                  subtitle,
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