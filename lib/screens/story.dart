import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Story extends StatefulWidget {
  final User user;

  const Story({Key? key, required this.user}) : super(key: key);

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  int fitniPoints = 350;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Fitness Journey',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 10),
          buildChapter('Chapter 1', 5, fitniPoints),
          const SizedBox(height: 20),
          buildChapter('Chapter 2', 6, fitniPoints - 50 * 5),
          // Add more chapters as needed
        ],
      ),
    );
  }

  Widget buildChapter(String title, int days, int fitniPoints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.all(20.0),
          color: Color.fromARGB(255, 255, 154, 39),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(days, (index) {
            return Column(
              children: [
                if (index > 0)
                  Container(
                    width: 2,
                    height: 10, // Connector line color
                  ),
                buildDayCircle(
                    index % 2 == 0, index == days - 1, index, fitniPoints),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget buildDayCircle(
      bool isLeft, bool isLast, int dayIndex, int fitniPoints) {
    bool isOrange = false;
    if (fitniPoints >= (dayIndex + 1) * 50) {
      isOrange = true;
    }
    return Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          setState(() {
            fitniPoints += 10; // Increment fitniPoints
          });
        },
        child: Container(
          width: 90,
          height: 90,
          margin: const EdgeInsets.only(top: 8, right: 140, left: 140),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOrange ? Colors.orange : Colors.grey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              isLast ? Icons.emoji_events_rounded : Icons.star_rounded,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
