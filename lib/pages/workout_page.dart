import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_workout_companion/components/exercise_tile.dart';
import 'package:your_workout_companion/data/workout_data.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({required this.workoutName, super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

  //checkbox tapped
  void onCheckBoxChanged(String workoutName, String exerciseName){
    Provider.of<WorkoutData>(context, listen: false)
    .checkOffExercise(workoutName, exerciseName);
  }

  //text controllers

  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  //create a new exercise
  void createNewExercise(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a new exercise"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //name
            TextField(
              controller: exerciseNameController,
            ),

            //reps
            TextField(
              controller: repsController,
            ),

            //sets
            TextField(
              controller: setsController,
            ),

            //weight
            TextField(
              controller: weightController,
            ),
          ],
        ),
        actions: [
          //save button
          MaterialButton(onPressed: save,
          child: const Text("save"),
          ),
          //cancel button
          MaterialButton(onPressed: cancel,
          child: const Text("cancel"),)
        ],
      ),
    );
  }

  //save workout
  void save(){
    String newExerciseName = exerciseNameController.text;
    String reps = repsController.text;
    String sets = setsController.text;
    String weight = weightController.text;

    Provider.of<WorkoutData>(context, listen: false).addExercise(
        widget.workoutName,
        newExerciseName,
        weight,
        reps,
        sets
    );

    Navigator.pop(context);
  }

  void cancel(){
    Navigator.pop(context);
    exerciseNameController.clear();
     weightController.clear();
    setsController.clear();
    repsController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(child: Text(widget.workoutName)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.numberOfExerciseInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name,
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets,
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .reps,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isCompleted,
            onCheckBoxChanged: (val) => onCheckBoxChanged(
              widget.workoutName,value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name
            ),
          ),
        ),
      ),
    );
  }
}
