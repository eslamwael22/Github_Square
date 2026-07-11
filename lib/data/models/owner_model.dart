import 'package:hive/hive.dart';

part 'owner_model.g.dart';

@HiveType(typeId: 1)
class OwnerModel {
  @HiveField(0)
  final String login;

  @HiveField(1)
  final String htmlUrl;

  OwnerModel({required this.login, required this.htmlUrl});

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(login: json['login'], htmlUrl: json['html_url']);
  }

  Map<String, dynamic> toJson() {
    return {'login': login, 'html_url': htmlUrl};
  }
}
