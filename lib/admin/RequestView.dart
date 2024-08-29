import 'package:flutter/material.dart';

class Requestview extends StatefulWidget {
  const Requestview({super.key});

  @override
  AdminDashboardState createState() => AdminDashboardState();
}

class AdminDashboardState extends State<Requestview> {
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
        title: const Text('Application Detail'),
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
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Parves"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Dhaka"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("01788426.."),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("0163724"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("KSA"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("USA"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Kulna"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Manda"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("A34DT"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("2345678"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("parves@gmail.com"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Yeasin"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Wahab"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Rajshahi"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Naogaon"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("01183726"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Kumilla"),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("ID"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12.0,
                                            horizontal: 24.0,
                                          ),
                                        ),
                                        child: const Text(
                                          "Accept",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12.0,
                                            horizontal: 24.0,
                                          ),
                                        ),
                                        child: const Text(
                                          "Decline",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
                      const Icon(Icons.search, color: Colors.black),
                    ],
                  )
                : const Icon(Icons.search, color: Colors.black),
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
                      const Icon(Icons.account_circle, color: Colors.black),
                    ],
                  )
                : const Icon(Icons.account_circle, color: Colors.black),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
