import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 2)
class ProductModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final double? taxPercent; // optional tax %

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    this.taxPercent,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] ?? 0,
      taxPercent: (json['taxPercent'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'taxPercent': taxPercent,
    };
  }

  
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    double? taxPercent,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }
  
}
