import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../components/account_creation/account_creator_index.dart';
import '../../screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeOrAccount extends StatelessWidget {
  final User user;

  const HomeOrAccount({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: userExists(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data == true) {
            return HomePage(user: user);
          } else {
            return CreatorIndex(user: user);
          }
        }
      },
    );
  }
}

Future<bool> userExists(String userId) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    print('Checking user document for $userId');
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print('User document $userId found');
    } else {
      print('User document $userId not found');
    }
    return querySnapshot.docs.isNotEmpty;
  } catch (error) {
    print('Error checking user document: $error');
    return false;
  }
}
