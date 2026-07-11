import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/github_repo_model.dart';

class RepoItem extends StatelessWidget {
  final GithubRepoModel repo;

  const RepoItem({super.key, required this.repo});

  Future<void> _launch(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Couldn't open link")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: repo.fork ? Colors.white : Colors.green.shade100,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        mouseCursor: SystemMouseCursors.click,
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text("Open Link"),
                content: const Text("Choose what you want to open"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _launch(context, repo.htmlUrl);
                    },
                    child: const Text("Repository"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _launch(context, repo.owner.htmlUrl);
                    },
                    child: const Text("Owner"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              );
            },
          );
        },
        child: ListTile(
          leading: CircleAvatar(child: Text(repo.owner.login[0].toUpperCase())),
          title: Tooltip(
            message: repo.name,
            child: Text(
              repo.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repo.description?.trim().isNotEmpty == true
                    ? repo.description!
                    : "No description",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.person, size: 16.r, color: Colors.grey),
                  SizedBox(width: 5.w),
                  Text(
                    repo.owner.login,
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
