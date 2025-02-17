import 'dart:math';
import 'package:flutter/material.dart';
import 'package:avatar_plus/avatar_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock user data
  String _name = 'John Doe';
  String _bio = 'Flutter Developer 👨‍💻\nCoffee Lover ☕';
  bool _showAvatarSelector = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // Avatar seeds
  List<String> _avatarSeeds = [];
  String _selectedAvatarSeed = "Seed1";

  @override
  void initState() {
    super.initState();
    _avatarSeeds = _generateRandomStrings(6, 10);
    _nameController.text = _name;
    _bioController.text = _bio;
  }

  List<String> _generateRandomStrings(int count, int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(
        count,
        (_) => String.fromCharCodes(
              Iterable.generate(length,
                  (_) => chars.codeUnitAt(random.nextInt(chars.length))),
            ));
  }

  void _refreshAvatars() {
    setState(() {
      _avatarSeeds = _generateRandomStrings(6, 10);
    });
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _bioController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Bio"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _name = _nameController.text;
                  _bio = _bioController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAvatarSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            AvatarPlus(_selectedAvatarSeed, height: 100, width: 100),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () =>
                    setState(() => _showAvatarSelector = !_showAvatarSelector),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(_bio,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _showEditProfileDialog,
                child: const Text("Edit Profile"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _StatCard(label: 'Followers', count: 120),
        _StatCard(label: 'Following', count: 180),
        _StatCard(label: 'Posts', count: 45),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Achievements",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                5,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          AvatarPlus("Achievement$index",
                              height: 60, width: 60),
                          const SizedBox(height: 4),
                          Text("Badge ${index + 1}",
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildAvatarSection(),
            ),
            const SizedBox(height: 16),
            _buildStatsSection(),
            const Divider(height: 32, thickness: 1),
            _buildAchievementsSection(),
            if (_showAvatarSelector) _buildAvatarSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSelector() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Select Avatar",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _refreshAvatars),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _avatarSeeds.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatarSeed = _avatarSeeds[index];
                        _showAvatarSelector = false;
                      });
                    },
                    child:
                        AvatarPlus(_avatarSeeds[index], height: 50, width: 50),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int count;

  const _StatCard({required this.label, required this.count, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$count",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }
}
