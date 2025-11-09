import 'package:hive/hive.dart';

part 'terms_model.g.dart';

@HiveType(typeId: 3)
class TermsModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;

  TermsModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }
}
