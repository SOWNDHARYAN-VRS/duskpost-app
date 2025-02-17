import 'package:flutter/material.dart';
import 'package:avatar_plus/avatar_plus.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // Mock data for posts
  final List<Map<String, dynamic>> posts = List.generate(10, (index) {
    return {
      'avatarSeed': 'User$index', // Seed for AvatarPlus
      'name': 'User $index',
      'time': '${index + 1} hours ago',
      'title': 'This is the title of post $index. It has a limit of 100 characters.',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' * 15,
      'likes': 10 * (index + 1),
      'comments': 5 * (index + 1),
    };
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Explore"),
        ),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar, name, and time
                      Row(
                        children: [
                          // AvatarPlus
                          AvatarPlus(
                            post['avatarSeed'],
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                post['time'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        post['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Content
                      Text(
                        post['content'],
                        maxLines: 20,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                      const Spacer(),
                      // Likes and Comments
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.thumb_up_alt_outlined, size: 18),
                              const SizedBox(width: 4),
                              Text('${post['likes']}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.comment_outlined, size: 18),
                              const SizedBox(width: 4),
                              Text('${post['comments']}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
