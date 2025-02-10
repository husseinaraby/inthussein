import 'package:flutter/material.dart';

void main() {
  runApp(MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[800]),
        ),
      ),
      home: MoodTrackerScreen(),
    );
  }
}

class MoodTrackerScreen extends StatefulWidget {
  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  String? _selectedMood = 'Happy';
  String _quote = 'Keep smiling and the world smiles with you!';
  IconData _moodIcon = Icons.sentiment_very_satisfied;

  // List of moods
  final List<String> _moods = [
    'Happy',
    'Sad',
    'Angry',
    'Excited',
    'Tired',
  ];

  // Quotes corresponding to moods
  final Map<String, String> _quotes = {
    'Happy': 'Keep smiling and the world smiles with you!',
    'Sad': 'It\'s okay to feel sad. Better days are coming!',
    'Angry': 'Take a deep breath. Calmness is your superpower.',
    'Excited': 'Embrace the excitement and make the most of it!',
    'Tired': 'Rest is essential. Take care of yourself!',
  };

  // Icons corresponding to moods
  final Map<String, IconData> _moodIcons = {
    'Happy': Icons.sentiment_very_satisfied,
    'Sad': Icons.sentiment_dissatisfied,
    'Angry': Icons.sentiment_very_dissatisfied,
    'Excited': Icons.sentiment_satisfied,
    'Tired': Icons.bedtime,
  };

  void _navigateToSuggestionScreen(String title, String message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuggestionScreen(title: title, message: message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Mood Tracker'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://static.vecteezy.com/system/resources/thumbnails/007/776/025/small/mood-monitoring-pixel-perfect-rgb-color-icon-mobile-app-for-health-tracking-internet-of-things-isolated-illustration-simple-filled-line-drawing-editable-stroke-arial-font-used-vector.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,  // Set text color to black
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_moodIcon, color: Colors.blue[400], size: 30),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _selectedMood,
                    items: _moods.map((String mood) {
                      return DropdownMenuItem<String>(
                        value: mood,
                        child: Text(
                          mood,
                          style: TextStyle(fontSize: 18, color: Colors.black),  // Set text color to black
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newMood) {
                      setState(() {
                        if (newMood != null) {
                          _selectedMood = newMood;
                          _quote = _quotes[newMood]!;  // Update quote based on selected mood
                          _moodIcon = _moodIcons[newMood]!;  // Update icon based on selected mood
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Text(
                  _quote,
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,  // Set text color to black
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_selectedMood != null) {
                    setState(() {
                      _quote = _quotes[_selectedMood!]!;
                      if (_selectedMood == 'Happy') {
                        _navigateToSuggestionScreen(
                          'Spread Joy!',
                          'You\'re feeling happy! Clap your hands to celebrate and share your joy with the world!',
                        );
                      } else if (_selectedMood == 'Sad') {
                        _navigateToSuggestionScreen(
                          'Cheer Up!',
                          'It\'s okay to feel sad sometimes. Why not do something you love? '
                              'Listen to your favorite music, watch a good movie, or call a loved one!',
                        );
                      } else if (_selectedMood == 'Tired') {
                        _navigateToSuggestionScreen(
                          'Time to Rest',
                          'You seem tired. It\'s important to get enough rest. Try going to bed early tonight!',
                        );
                      } else if (_selectedMood == 'Angry') {
                        _navigateToSuggestionScreen(
                          'Calm Down',
                          'Take  moment to follow this breathing method: Inhale deeply for 4 seconds, hold your breath for 4 seconds, and exhale for 4 seconds. Repeat this a few times to feel calmer.',
                        );
                      } else if (_selectedMood == 'Excited') {
                        _navigateToSuggestionScreen(
                          'Channel Your Energy!',
                          'You\'re feeling excited! Why not channel that energy into something productive like sports or physical activities? Go for a run, play a game, or try a new workout!',
                        );
                      }
                    });
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SuggestionScreen extends StatelessWidget {
  final String title;
  final String message;

  SuggestionScreen({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.black),  // Set text color to black
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
