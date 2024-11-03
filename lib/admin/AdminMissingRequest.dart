import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pms_flutter_app/admin/MissingCardView.dart';

class AdminMissingRequest extends StatefulWidget {
  const AdminMissingRequest({super.key});

  @override
  AdminMissingRequestState createState() => AdminMissingRequestState();
}

class AdminMissingRequestState extends State<AdminMissingRequest> {
  List<dynamic> missingReports = [];

  @override
  void initState() {
    super.initState();
    fetchMissingReports();
  }

  Future<void> fetchMissingReports() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/missing'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is Map<String, dynamic> && responseData.containsKey('reports')) {
        setState(() {
          missingReports = responseData['reports'] as List<dynamic>;
        });
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load missing reports');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Missing Card Requests'),
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
      body: missingReports.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: missingReports.length,
                itemBuilder: (context, index) {
                  final report = missingReports[index];
                  final passportType = report['passportType'] ?? 'Unknown';
                  final reportId = report['_id'] ?? 'N/A';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MissingCardView(cardRequest: report),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: const LinearGradient(
                          colors: [Colors.cyan, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 10.0,
                            offset: const Offset(0, 5),
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
                                const Icon(Icons.report, color: Colors.white, size: 40),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Passport Type: $passportType',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Report ID: $reportId',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Tap to view details',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
