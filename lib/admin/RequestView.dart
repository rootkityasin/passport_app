import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Requestview extends StatefulWidget {
  final dynamic application; // Accepting application details

  const Requestview({super.key, required this.application});

  @override
  RequestviewState createState() => RequestviewState();
}

class RequestviewState extends State<Requestview> {
  final int _selectedIndex = 0;
  final TextEditingController _declineReasonController = TextEditingController();

  Future<void> _deleteApplication(String applicationId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:3000/api/apply/$applicationId'),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.of(context).pop(); // Go back to the previous page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application deleted successfully!')),
        );
      } else {
        throw Exception('Failed to delete application');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  void _showAcceptConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Accept'),
          content: const Text('Are you sure you want to accept this request?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteApplication(widget.application['_id']); // Delete application
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showDeclineReasonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Decline Reason'),
          content: TextField(
            controller: _declineReasonController,
            decoration: const InputDecoration(
              hintText: 'Enter reason for decline',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteApplication(widget.application['_id']); // Delete application
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _declineReasonController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final application = widget.application;

    // Extracting all fields from the application
    final personalInfo = application['personalInfo'] ?? {};
    final presentAddress = application['presentAddress'] ?? {};
    final permanentAddress = application['permanentAddress'] ?? {};

    final fullName = personalInfo['fullName'] ?? 'N/A';
    final givenName = personalInfo['givenName'] ?? 'N/A';
    final surname = personalInfo['surname'] ?? 'N/A';
    final dateOfBirth = personalInfo['dateOfBirth'] ?? 'N/A';
    final countryOfBirth = personalInfo['countryOfBirth'] ?? 'N/A';
    final nationality = personalInfo['nationality'] ?? 'N/A';
    final placeOfBirth = personalInfo['placeOfBirth'] ?? 'N/A';
    final gender = personalInfo['gender'] ?? 'N/A';
    final citizenType = personalInfo['citizenType'] ?? 'N/A';
    final religion = personalInfo['religion'] ?? 'N/A';
    final dualCitizenshipStatus = personalInfo['dualCitizenshipStatus'] ?? false;
    final otherCitizenshipCountry = personalInfo['otherCitizenshipCountry'] ?? 'N/A';
    final foreignPassportNo = personalInfo['foreignPassportNo'] ?? 'N/A';
    final spouseName = personalInfo['spouseName'] ?? 'N/A';
    final spouseNationality = personalInfo['spouseNationality'] ?? 'N/A';
    final spouseProfession = personalInfo['spouseProfession'] ?? 'N/A';
    final spousePassportNo = personalInfo['spousePassportNo'] ?? 'N/A';
    final spouseNationalId = personalInfo['spouseNationalId'] ?? 'N/A';
    final nationalId = personalInfo['nationalId'] ?? 'N/A';
    final birthCertificateNo = personalInfo['birthCertificateNo'] ?? 'N/A';
    final profession = personalInfo['profession'] ?? 'N/A';
    final contactNo = personalInfo['contactNo'] ?? 'N/A';
    final email = personalInfo['email'] ?? 'N/A';

    final districtPresent = presentAddress['district'] ?? 'N/A';
    final policeStationPresent = presentAddress['policeStation'] ?? 'N/A';
    final postOfficePresent = presentAddress['postOffice'] ?? 'N/A';
    final postCodePresent = presentAddress['postCode'] ?? 'N/A';
    final cityPresent = presentAddress['city'] ?? 'N/A';
    final roadPresent = presentAddress['road'] ?? 'N/A';

    final districtPermanent = permanentAddress['district'] ?? 'N/A';
    final policeStationPermanent = permanentAddress['policeStation'] ?? 'N/A';
    final postOfficePermanent = permanentAddress['postOffice'] ?? 'N/A';
    final postCodePermanent = permanentAddress['postCode'] ?? 'N/A';
    final cityPermanent = permanentAddress['city'] ?? 'N/A';
    final roadPermanent = permanentAddress['road'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Detail'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(Icons.person, 'Full Name', fullName, Colors.blue),
              _buildInfoCard(Icons.assignment_ind, 'Given Name', givenName, Colors.teal),
              _buildInfoCard(Icons.person_outline, 'Surname', surname, Colors.orange),
              _buildInfoCard(Icons.cake, 'Date of Birth', dateOfBirth, Colors.red),
              _buildInfoCard(Icons.flag, 'Country of Birth', countryOfBirth, Colors.deepPurple),
              _buildInfoCard(Icons.location_on, 'Place of Birth', placeOfBirth, Colors.green),
              _buildInfoCard(Icons.male, 'Gender', gender, Colors.pink),
              _buildInfoCard(Icons.perm_identity, 'Citizen Type', citizenType, Colors.cyan),
              _buildInfoCard(Icons.account_balance, 'Nationality', nationality, Colors.indigo),
              _buildInfoCard(Icons.security, 'Dual Citizenship Status', dualCitizenshipStatus ? 'Yes' : 'No', Colors.brown),
              _buildInfoCard(Icons.public, 'Other Citizenship Country', otherCitizenshipCountry, Colors.lightBlue),
              _buildInfoCard(Icons.email, 'Email', email, Colors.amber),
              const SizedBox(height: 20),
              const Text(
                'Present Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.location_city, 'District', districtPresent, Colors.deepOrange),
              _buildInfoCard(Icons.local_police, 'Police Station', policeStationPresent, Colors.red),
              _buildInfoCard(Icons.markunread_mailbox, 'Post Office', postOfficePresent, Colors.green),
              _buildInfoCard(Icons.mail_outline, 'Post Code', postCodePresent, Colors.purple),
              _buildInfoCard(Icons.apartment, 'City', cityPresent, Colors.blueAccent),
              _buildInfoCard(Icons.add_road, 'Road', roadPresent, Colors.blueGrey),
              const SizedBox(height: 20),
              const Text(
                'Permanent Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.location_city, 'District', districtPermanent, Colors.deepOrange),
              _buildInfoCard(Icons.local_police, 'Police Station', policeStationPermanent, Colors.red),
              _buildInfoCard(Icons.markunread_mailbox, 'Post Office', postOfficePermanent, Colors.green),
              _buildInfoCard(Icons.mail_outline, 'Post Code', postCodePermanent, Colors.purple),
              _buildInfoCard(Icons.apartment, 'City', cityPermanent, Colors.blueAccent),
              _buildInfoCard(Icons.add_road, 'Road', roadPermanent, Colors.blueGrey),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _showAcceptConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: _showDeclineReasonDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Decline'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? _buildBottomNavIcon(Icons.home)
                : const Icon(Icons.home, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? _buildBottomNavIcon(Icons.search)
                : const Icon(Icons.search, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? _buildBottomNavIcon(Icons.account_circle)
                : const Icon(Icons.account_circle, color: Colors.black),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildBottomNavIcon(IconData icon) {
    return Stack(
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
        Icon(icon, color: Colors.black),
      ],
    );
  }
}
