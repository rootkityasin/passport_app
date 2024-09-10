import 'package:flutter/material.dart';

class Requestview extends StatefulWidget {
  final dynamic application; // Accepting application details

  const Requestview({super.key, required this.application});

  @override
  RequestviewState createState() => RequestviewState();
}

class RequestviewState extends State<Requestview> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
    final dualCitizenshipStatus =
        personalInfo['dualCitizenshipStatus'] ?? false;
    final otherCitizenshipCountry =
        personalInfo['otherCitizenshipCountry'] ?? 'N/A';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name: $fullName',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Given Name: $givenName',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Surname: $surname', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Date of Birth: $dateOfBirth',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Country of Birth: ${countryOfBirth.isEmpty ? 'N/A' : countryOfBirth}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Nationality: $nationality',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Place of Birth: $placeOfBirth',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Gender: $gender', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Citizen Type: $citizenType',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Religion: $religion', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Dual Citizenship Status: ${dualCitizenshipStatus ? "Yes" : "No"}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Other Citizenship Country: ${otherCitizenshipCountry.isEmpty ? 'N/A' : otherCitizenshipCountry}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Foreign Passport No: ${foreignPassportNo.isEmpty ? 'N/A' : foreignPassportNo}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Spouse Name: ${spouseName.isEmpty ? 'N/A' : spouseName}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Spouse Nationality: ${spouseNationality.isEmpty ? 'N/A' : spouseNationality}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Spouse Profession: ${spouseProfession.isEmpty ? 'N/A' : spouseProfession}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Spouse Passport No: ${spousePassportNo.isEmpty ? 'N/A' : spousePassportNo}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Spouse National ID: ${spouseNationalId.isEmpty ? 'N/A' : spouseNationalId}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('National ID: $nationalId',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Birth Certificate No: $birthCertificateNo',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Profession: $profession',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Contact No: $contactNo',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Email: $email', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text(
                'Present Address',
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('District: $districtPresent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Police Station: $policeStationPresent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Post Office: $postOfficePresent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Post Code: $postCodePresent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('City: $cityPresent', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Road: $roadPresent', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text(
                'Permanent Address',
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('District: $districtPermanent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Police Station: $policeStationPermanent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Post Office: $postOfficePermanent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Post Code: $postCodePermanent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('City: $cityPermanent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Road: $roadPermanent',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
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
                                  borderRadius: BorderRadius.circular(20),
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
