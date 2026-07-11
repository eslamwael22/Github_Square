import 'package:hive/hive.dart';
import 'owner_model.dart';



part 'github_repo_model.g.dart';

@HiveType(typeId: 0)
class GithubRepoModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final bool fork;

  @HiveField(3)
  final String htmlUrl;

  @HiveField(4)
  final OwnerModel owner;

  GithubRepoModel({
    required this.name,
    required this.description,
    required this.fork,
    required this.htmlUrl,
    required this.owner,
  });

  factory GithubRepoModel.fromJson(Map<String, dynamic> json) {
    return GithubRepoModel(
      name: json['name'],
      description: json['description'],
      fork: json['fork'] ?? false,
      htmlUrl: json['html_url'],
      owner: OwnerModel.fromJson(json['owner']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'fork': fork,
      'html_url': htmlUrl,
      'owner': owner.toJson(),
    };
  }
}
