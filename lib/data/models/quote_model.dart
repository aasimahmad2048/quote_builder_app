import 'dart:ffi';

import 'package:hive/hive.dart';
import 'temp_model.dart';
import 'product_model.dart';
import 'terms_model.dart';

part 'quote_model.g.dart';

@HiveType(typeId: 4)
class QuoteModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String quoteNumber;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  DateTime expiryDate;
  @HiveField(4)
  ClientModel client;
  @HiveField(5)
  List<ProductModel> products;
  @HiveField(6)
  TermsModel terms;
  @HiveField(7)
  double discount;
  @HiveField(8)
  double tax;
  @HiveField(9)
  double totalAmount;
  @HiveField(10)
  String title;

  QuoteModel({
    required this.id,
    required this.quoteNumber,
    required this.date,
    required this.expiryDate,
    required this.client, // This should be ClientModel
    required this.products,
    required this.terms,
    this.discount = 0,
    this.tax = 0.0,
    required this.totalAmount,
    required this.title,
    
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'],
      quoteNumber: json['quoteNumber'],
      date: DateTime.parse(json['date']),
      expiryDate: DateTime.parse(json['expiryDate']),
      client: ClientModel.fromJson(json['client']),
      products: (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      terms: TermsModel.fromJson(json['terms']),
      discount: json['discount'],
      tax: json['tax'],
      totalAmount: json['totalAmount'],
      title: json['title'],
    );
  }
}
