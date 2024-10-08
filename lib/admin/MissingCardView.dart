import 'package:flutter/material.dart';

class MissingCardView extends StatefulWidget {
  final dynamic cardRequest;

  const MissingCardView({super.key, required this.cardRequest});

  @override
  MissingCardViewState createState() => MissingCardViewState();
}

class MissingCardViewState extends State<MissingCardView> {
  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Action'),
          content: const Text('Are you sure you want to mark this report as found?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call function to mark as found
                markAsFound();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void markAsFound() {
Navigator.of(context).pop();
Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final cardRequest = widget.cardRequest;

    final passportType = cardRequest['passportType'] ?? 'N/A';
    final reissueReason = cardRequest['reissueReason'] ?? 'N/A';
    final country = cardRequest['country'] ?? 'N/A';
    final policeCaseNumber = cardRequest['policeCaseNumber'] ?? 'N/A';
    final district = cardRequest['district'] ?? 'N/A';
    final policeStation = cardRequest['policeStation'] ?? 'N/A';
    final reportedDate = cardRequest['reportedDate'] ?? 'N/A';
    final previousPassportNumber = cardRequest['previousPassportNumber'] ?? 'N/A';
    final dateOfIssue = cardRequest['dateOfIssue'] ?? 'N/A';
    final dateOfExpiration = cardRequest['dateOfExpiration'] ?? 'N/A';
    final unknownPreviousPassportData = cardRequest['unknownPreviousPassportData'] ?? false;
    final otherCountryPassport = cardRequest['otherCountryPassport'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Missing Card Details'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.orange.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 8,
          shadowColor: Colors.orangeAccent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(Icons.credit_card, 'Passport Type', passportType, Colors.purple),
                _buildDetailRow(Icons.history, 'Reissue Reason', reissueReason, Colors.teal),
                _buildDetailRow(Icons.flag, 'Country', country, Colors.blue),
                _buildDetailRow(Icons.policy, 'Police Case Number', policeCaseNumber, Colors.red),
                _buildDetailRow(Icons.location_city, 'District', district, Colors.green),
                _buildDetailRow(Icons.account_balance, 'Police Station', policeStation, Colors.deepPurple),
                _buildDetailRow(Icons.date_range, 'Reported Date', reportedDate, Colors.amber),
                _buildDetailRow(Icons.fingerprint, 'Previous Passport Number', previousPassportNumber, Colors.cyan),
                _buildDetailRow(Icons.calendar_today, 'Date of Issue', dateOfIssue, Colors.indigo),
                _buildDetailRow(Icons.calendar_today, 'Date of Expiration', dateOfExpiration, Colors.brown),
                _buildDetailRow(Icons.lock_open, 'Unknown Passport Data', unknownPreviousPassportData ? 'Yes' : 'No', Colors.redAccent),
                _buildDetailRow(Icons.public, 'Other Country Passport', otherCountryPassport, Colors.blueAccent),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle),
                    label: const Text("Mark as Found"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    ),
                    onPressed: showConfirmationDialog,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
