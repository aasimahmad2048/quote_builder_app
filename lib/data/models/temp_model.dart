import 'package:hive/hive.dart';

part 'temp_model.g.dart';

@HiveType(typeId: 1)
class ClientModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String type; 

  ClientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.type,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'type': type,
    };
  }
}
