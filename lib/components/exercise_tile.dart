import 'package:flutter/material.dart';
class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String sets;
  final String reps;
  final bool isCompleted;
  void Function(bool)? onCheckBoxChanged;

   ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.sets,
    required this.reps,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exerciseName),
      subtitle: Row(
        children: [
          //weight
          Chip(label: Text("${weight}kg"),
          ),
          const SizedBox(width: 8,),
          //reps
          Chip(label: Text("$reps reps"),
          ),
          const SizedBox(width: 8,),
          //sets
          const SizedBox(width: 8,),
          Chip(label: Text("$sets sets"
          ),
          ),
        ],
      ),trailing: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Checkbox(
        value: isCompleted,
        onChanged: (value) => onCheckBoxChanged!(value!),
            ),
      )
    );
  }
}
