import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessquest_v1/services/firestore.dart';

class EditProfile extends StatefulWidget {
  final User user;
  final String? currentName;
  final String? currentNick;
  final String? currentAge;
  final String? currentGender;

  const EditProfile({
    Key? key,
    required this.user,
    this.currentName,
    this.currentNick,
    this.currentAge,
    this.currentGender,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String nick;
  late String age;
  late String gender;

  @override
  void initState() {
    super.initState();
    name = widget.currentName ?? '';
    nick = widget.currentNick ?? '';
    age = widget.currentAge ?? '';
    gender = widget.currentGender ?? '';
  }

  Future<void> updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        FirestoreService firestoreService = FirestoreService();
        await firestoreService.updateUser(
          widget.user.uid,
          name: name,
          nick: nick,
          age: age,
          gender: gender,
        );
        Navigator.pop(context); // Return to the previous screen
      } catch (error) {
        print('Error updating user profile: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                initialValue: nick,
                decoration: InputDecoration(labelText: 'Nickname'),
                onSaved: (value) => nick = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a nickname' : null,
              ),
              TextFormField(
                initialValue: age,
                decoration: InputDecoration(labelText: 'Age'),
                onSaved: (value) => age = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an age' : null,
              ),
              TextFormField(
                initialValue: gender,
                decoration: InputDecoration(labelText: 'Gender'),
                onSaved: (value) => gender = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a gender' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateUserProfile,
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
