import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Shop extends StatelessWidget {
  final User user;

  const Shop({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shop_rounded,
                    size: 100, color: Color.fromARGB(255, 225, 120, 0)),
                SizedBox(height: 20),
                Text(
                  'Welcome to the Shop!',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Text(
                  'Explore our products and find what you need for your fitness journey.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.monetization_on,
                            color: Color.fromARGB(255, 232, 210, 12), size: 24),
                        SizedBox(width: 5),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 232, 210, 12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width:
                            30), // Add a small space between each icon-value pair
                    Row(
                      children: [
                        Icon(Icons.diamond_rounded,
                            color: Colors.blue, size: 24),
                        SizedBox(width: 5),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width:
                            30), // Add a small space between each icon-value pair
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.purple, size: 24),
                        SizedBox(width: 5),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
