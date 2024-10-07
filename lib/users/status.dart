import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

import './model/application.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pms_flutter_app/config.dart';

class StatusPage extends StatefulWidget {
  final String token;
  const StatusPage({required this.token, super.key});

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  late String userId = '';
  List<Application> applications = [];
  bool isLoading = true;

  // Controllers for search fields
  final TextEditingController _refNoController = TextEditingController();
  final TextEditingController _passportNoController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTokenAndRoleAndApplications();
  }

  Future<void> _fetchTokenAndRoleAndApplications() async {
    // Decode the token to get the user ID
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    userId =
        decodedToken['_id']; // Updated to match the backend token structure

    if (userId.isEmpty) {
      print('Error: userId is null or empty');
      return;
    }
    await _fetchApplications();
  }

  Future<void> _fetchApplications() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse(recieveapplicationdata),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['applications'];
      setState(() {
        applications = data.map((item) => Application.fromJson(item)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to fetch applications: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _refNoController,
                    decoration: const InputDecoration(
                      labelText: 'Ref No',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _passportNoController,
                    decoration: const InputDecoration(
                      labelText: 'Passport No',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _mobileNoController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile No',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // DataTable for Application Information
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(label: Text('Ref No')),
                          DataColumn(label: Text('Certificate')),
                          DataColumn(label: Text('Passport No')),
                          DataColumn(label: Text('Apply Date')),
                          DataColumn(label: Text('Mobile No')),
                          DataColumn(label: Text('Person Name')),
                          DataColumn(label: Text('District Name')),
                          DataColumn(label: Text('Thana Name')),
                          DataColumn(label: Text('Current Status')),
                          DataColumn(label: Text('Remarks')),
                        ],
                        rows: applications.map((app) {
                          return DataRow(cells: [
                            DataCell(Text(app.refNo)),
                            DataCell(Text(app.certificate)),
                            DataCell(Text(app.passportNo)),
                            DataCell(Text(app.applyDate)),
                            DataCell(Text(app.mobileNo)),
                            DataCell(Text(app.personName)),
                            DataCell(Text(app.districtName)),
                            DataCell(Text(app.thanaName)),
                            DataCell(Text(app.status)),
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: app.remarks
                                    .map((remark) => Text(
                                        '${_formatDate(remark.date)}: ${remark.remark} (${remark.by})'))
                                    .toList(),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Format date as desired, e.g., '15-SEP-24'
    return '${date.day.toString().padLeft(2, '0')}-${_getMonthAbbreviation(date.month)}-${date.year.toString().substring(2)}';
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ];
    return months[month - 1];
  }
}
