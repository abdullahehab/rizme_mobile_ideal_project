import 'package:flutter/material.dart';

import '../../../generated/localization.dart';
import '../../../models/post/post.dart';
import '../widgets/post_card.dart';
import '../widgets/trending_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2.0,
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 180,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey.shade600,
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  tabs: [
                    Tab(text: LocaleKeys.home.tr()),
                    Tab(text: LocaleKeys.popular.tr()),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeTabView(),
          PopularTabView(),
        ],
      ),
    );
  }
}

class PopularTabView extends StatelessWidget {
  const PopularTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const TrendingContainer(),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: Post.posts.length,
          itemBuilder: (context, index) {
            final post = Post.posts[index];
            return PostCard(post: post);
          },
        ),
      ],
    );
  }
}

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: Post.posts.length,
      itemBuilder: (context, index) {
        final post = Post.posts[index];
        return PostCard(post: post);
      },
    );
  }
}
