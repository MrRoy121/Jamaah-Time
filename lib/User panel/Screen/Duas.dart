import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<String> headings = [
    "Dua for knowledge",
    "Dua for taqwa",
    "Dua for success",
    "Dua for good character",
    "Dua for blessed family",
    "Dua for having children",
    "Dua for relief from distress, laziness, debts",
    "Dua for healthy body",
    "Dua for the sick",
    "Dua for guidance and protection before leaving the home",
    "Dua to avoid sudden afflictions",
    "Dua for preservation",
    "Dua that removes anxiety",
    "Dua for protection in the evening",
    "Dua for forgiveness of all sins",
    "When you see the new moon",

  ];

  final List<String> messages = [
    "Oh Allah, I ask you for knowledge that is of benefit, a good provision, and deeds that will be accepted.",
    "O Allah, give my soul (nafs) its God-fearing righteousness (taqwa) and purify it, for You are the best to purify it. You are its Protector and its Guardian.",
    "Our Lord! Grant us the good of this world and the Hereafter, and protect us from the torment of the Fire.",
    "O Allah! You have made my creation perfect, so make my moral characteristics also be the best.",
    "Our Lord! Grant unto us wives and offspring who will be the comfort of our eyes, and give us (the grace) to lead the righteous.",
    "My Lord, grant me from Yourself a good offspring. Indeed, You are the Hearer of supplication.",
    "Oh Allah! I seek refuge with You from worry and grief, from incapacity and laziness, from cowardice and miserliness, from being heavily in debt and from being overpowered by (other) men.",
    "Oh Allah! Grant me well-being in my body. Oh Allah! Grant me well-being in my hearing. Oh Allah! Grant me well-being in my sight. There is no true God but You.",
    "O Allah! The Rubb of mankind! Remove this disease and cure me! You are the Great Curer. There is no cure but through You, which leaves behind no disease.",
    "In the Name of Allah, I place my trust in Allah. There is no might nor power except with Allah.",
    "In the Name of Allah, with Whose Name nothing is harmed on earth nor in heaven, and He is the All-Hearing, the All-Knowing. [Repeat three times]",
    "Our Lord! Do not let our hearts deviate after you have guided us. Grant us Your mercy. You are indeed the Giver of all bounties.",
    "Allah is enough for me. There is no true god but Him, in Him I put my trust, an He is the Lord of the Great Throne. [Repeat seven times]",
    "I seek refuge in the Perfect Words of Allah from the evil of what He has created.",
    "O Allah, forgive all of my sins: the small and great, the first and the last, the public and the private.",
    "Oh Allah, make it a start full of peace and faith, safety and Islam. My Lord and your Lord is Allah.",
// Add messages 2 through 10 here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'Assets/logo.png',
          width: 10,
          height: 10,
        ),
        title: Text(
          "Duaa's",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: headings.length,
        separatorBuilder: (context, index) => Divider(), // Add a Divider between items
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(headings[index]),
            // subtitle: Text('Date: ${_getDate()}'),
            onTap: () {
              _showNotificationDetails(headings[index], messages[index]);
            },
          );
        },
      ),
    );
  }

  String _getDate() {
    // Return current date here
    return DateTime.now().toString();
  }

  void _showNotificationDetails(String heading, String message) {
    // Navigate to a new screen to show full details of the notification
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationDetailsScreen(
          heading: heading,
          message: message,
        ),
      ),
    );
  }
}

class NotificationDetailsScreen extends StatelessWidget {
  final String heading;
  final String message;

  const NotificationDetailsScreen({
    Key? key,
    required this.heading,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'Assets/logo.png',
          width: 10,
          height: 10,
        ),
        title: Text(
          "Duaa",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
