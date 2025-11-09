import 'package:hive/hive.dart';

part 'business_model.g.dart';

@HiveType(typeId: 0)
class BusinessModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String address;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String? website;
  @HiveField(6)
  final String? taxId;
  @HiveField(7)
  final String? bankName;
  @HiveField(8)
  final String? bankAccount;
  @HiveField(9)
  final String? swiftCode;
  @HiveField(10)
  final String? currency;

  BusinessModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    this.website,
    this.taxId,
    this.bankName,
    this.bankAccount,
    this.swiftCode,
    this.currency,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      taxId: json['taxId'],
      bankName: json['bankName'],
      bankAccount: json['bankAccount'],
      swiftCode: json['swiftCode'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'taxId': taxId,
      'bankName': bankName,
      'bankAccount': bankAccount,
      'swiftCode': swiftCode,
      'currency': currency,
    };
  }
}
