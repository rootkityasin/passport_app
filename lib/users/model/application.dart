// models/application.dart
class Remark {
  final String remark;
  final String by;
  final DateTime date;

  Remark({required this.remark, required this.by, required this.date});

  factory Remark.fromJson(Map<String, dynamic> json) {
    return Remark(
      remark: json['remark'],
      by: json['by'],
      date: DateTime.parse(json['date']),
    );
  }
}

class Application {
  final String id;
  final String refNo;
  final String certificate;
  final String passportNo;
  final String applyDate;
  final String mobileNo;
  final String personName;
  final String districtName;
  final String thanaName;
  final String status;
  final List<Remark> remarks;

  Application({
    required this.id,
    required this.refNo,
    required this.certificate,
    required this.passportNo,
    required this.applyDate,
    required this.mobileNo,
    required this.personName,
    required this.districtName,
    required this.thanaName,
    required this.status,
    required this.remarks,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    var remarksFromJson = json['remarks'] as List<dynamic>;
    List<Remark> remarksList =
        remarksFromJson.map((i) => Remark.fromJson(i)).toList();

    return Application(
      id: json['_id'],
      refNo: json['refNo'] ?? '-',
      certificate: json['certificate'] ?? '-',
      passportNo: json['personalInfo']['foreignPassportNo'] ?? '-',
      applyDate:
          DateTime.parse(json['createdAt']).toLocal().toString().split(' ')[0],
      mobileNo: json['personalInfo']['contactNo'] ?? '-',
      personName: json['personalInfo']['fullName'] ?? '-',
      districtName: json['presentAddress']['district'] ?? '-',
      thanaName: json['presentAddress']['policeStation'] ?? '-',
      status: json['status'] ?? '-',
      remarks: remarksList,
    );
  }
}
