import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessquest_v1/services/firestore.dart';

class EditGoals extends StatefulWidget {
  final User user;
  final String? currentActivity;
  final String? currentDifficulty;
  final String? currentGoal;
  final String? currentHeight;
  final String? currentWeight;
  final bool? currentNeedsDumbell;

  const EditGoals({
    Key? key,
    required this.user,
    this.currentActivity,
    this.currentDifficulty,
    this.currentGoal,
    this.currentHeight,
    this.currentWeight,
    this.currentNeedsDumbell,
  }) : super(key: key);

  @override
  _EditGoalsState createState() => _EditGoalsState();
}

class _EditGoalsState extends State<EditGoals> {
  final _formKey = GlobalKey<FormState>();
  late String? activityLevel;
  late String? difficulty;
  late String? goal;
  late String? height;
  late String? weight;
  late String? needsDumbell;

  @override
  void initState() {
    super.initState();
    activityLevel = widget.currentActivity ?? 'Sedentary';
    difficulty = widget.currentDifficulty ?? 'Beginner';
    goal = widget.currentGoal ?? 'Lose weight';
    height = widget.currentHeight ?? '';
    weight = widget.currentWeight ?? '';
    needsDumbell = widget.currentNeedsDumbell != null
        ? (widget.currentNeedsDumbell! ? 'Yes' : 'No')
        : 'No';
  }

  Future<void> updateUserGoals() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        FirestoreService firestoreService = FirestoreService();
        await firestoreService.updateUser(
          widget.user.uid,
          activityLevel: activityLevel,
          difficulty: difficulty,
          goal: goal,
          height: height,
          weight: weight,
          needsDumbell: needsDumbell == 'Yes',
        );
        Navigator.pop(context);
      } catch (error) {
        print('Error updating user Goals: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Goals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: activityLevel,
                decoration: const InputDecoration(labelText: 'Activity Level'),
                items: ['Sedentary', 'Moderate', 'Active', 'Very Active']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    activityLevel = value!;
                  });
                },
                onSaved: (value) => activityLevel = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select an Activity Level'
                    : null,
              ),
              DropdownButtonFormField<String>(
                value: difficulty,
                decoration: const InputDecoration(labelText: 'Difficulty'),
                items: ['Beginner', 'Intermediate', 'Advanced']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    difficulty = value!;
                  });
                },
                onSaved: (value) => difficulty = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a Difficulty'
                    : null,
              ),
              DropdownButtonFormField<String>(
                value: goal,
                decoration: const InputDecoration(labelText: 'Goal'),
                items: ['Lose weight', 'Gain weight', 'Maintain weight']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    goal = value!;
                  });
                },
                onSaved: (value) => goal = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a Goal'
                    : null,
              ),
              TextFormField(
                initialValue: height,
                decoration: const InputDecoration(labelText: 'Height'),
                onSaved: (value) => height = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a Height' : null,
              ),
              TextFormField(
                initialValue: weight,
                decoration: const InputDecoration(labelText: 'Weight'),
                onSaved: (value) => weight = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a Weight' : null,
              ),
              DropdownButtonFormField<String>(
                value: needsDumbell,
                decoration: const InputDecoration(labelText: 'Needs Dumbell'),
                items: ['Yes', 'No']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    needsDumbell = value!;
                  });
                },
                onSaved: (value) => needsDumbell = value!,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select if you need dumbell'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateUserGoals,
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
