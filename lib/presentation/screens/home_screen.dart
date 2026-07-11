import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/github_cubit.dart';
import '../../business_logic/cubit/github_state.dart';
import '../../core/services/service_locator.dart';
import '../../data/repositories/github_repository.dart';
import '../widgets/repo_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GithubCubit(getIt<GithubRepository>())..getRepos(),
      child: const GithubView(),
    );
  }
}

class GithubView extends StatefulWidget {
  const GithubView({super.key});

  @override
  State<GithubView> createState() => _GithubViewState();
}

class _GithubViewState extends State<GithubView> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (!scrollController.hasClients) return;

      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        context.read<GithubCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: const Text(
          "Square Repositories",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,

            color: Color(0xff1E1E1E),
          ),
        ),

        centerTitle: false,
        toolbarHeight: 85,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<GithubCubit, GithubState>(
        builder: (context, state) {
          if (state is GithubLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GithubError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 70, color: Colors.red),
                  const SizedBox(height: 15),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GithubCubit>().getRepos();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (state is GithubLoaded) {
            return RefreshIndicator(
              displacement: 50,
              onRefresh: () async {
                searchController.clear();
                await context.read<GithubCubit>().refreshRepos();
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: searchController,
                      onChanged: context.read<GithubCubit>().search,
                      decoration: InputDecoration(
                        hintText: "Search repositories...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  if (state.repos.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          "No repositories found",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: state.hasReachedMax
                            ? state.repos.length
                            : state.repos.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.repos.length) {
                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          return RepoItem(repo: state.repos[index]);
                        },
                      ),
                    ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
