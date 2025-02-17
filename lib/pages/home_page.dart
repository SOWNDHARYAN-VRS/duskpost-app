import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedMood;

  // Mock data for stories
  final List<Map<String, dynamic>> stories =  [
    {'username': 'sarah_93', 'mood': '😊'},
    {'username': 'mike_dev', 'mood': '😎'},
    {'username': 'lisa.art', 'mood': '🎨'},
    {'username': 'john_doe', 'mood': '🏃'},
  ];

  // Mood options
  final List<Map<String, dynamic>> moods = [
    {'emoji': '😊', 'name': 'Happy'},
    {'emoji': '😎', 'name': 'Cool'},
    {'emoji': '😴', 'name': 'Sleepy'},
    {'emoji': '🤔', 'name': 'Thinking'},
    {'emoji': '😍', 'name': 'Love'},
    {'emoji': '😢', 'name': 'Sad'},
    {'emoji': '😡', 'name': 'Angry'},
    {'emoji': '🎮', 'name': 'Gaming'},
    {'emoji': '📚', 'name': 'Reading'},
    {'emoji': '🎵', 'name': 'Music'},
  ];

  void _showMoodSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your mood',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedMood = moods[index]['emoji'];
                      });
                      Navigator.pop(context);
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            moods[index]['emoji'],
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(
                            moods[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Your story
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: _showMoodSelector,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: selectedMood != null
                                    ? Text(
                                        selectedMood!,
                                        style: const TextStyle(fontSize: 25),
                                      )
                                    : Icon(
                                        Icons.add,
                                        size: 25,
                                        color: theme.colorScheme.secondary,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Your story',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    // Other stories
                    ...stories.map((story) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.colorScheme.secondary,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    story['mood'],
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                story['username'],
                                style: const TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
