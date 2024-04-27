import 'package:flutter/cupertino.dart';
import 'package:your_workout_companion/models/exercise.dart';
import 'package:your_workout_companion/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  /*
  WORKOUT DATA STRUCTURE

   */

  List<Workout> workoutList = [
    //default workout
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(name: "Biceps Curls",
            weight: "10",
            reps: "10",
            sets: "3"
        ),
      ],
    ),
    Workout(
      name: "Lower Body",
      exercises: [
        Exercise(
            name: "Squats",
            weight: "20",
            reps: "12",
            sets: "3"
        ),
      ],
    ),
    Workout(
      name: "Core",
      exercises: [
        Exercise(
            name: "Plank",
            weight: "-",
            reps: "-",
            sets: "3"
        ),
      ],
    ),
    Workout(
      name: "Leg Day",
      exercises: [
        Exercise(
            name: "Lunges",
            weight: "15",
            reps: "12",
            sets: "3"
        ),
      ],
    ),
    Workout(
      name: "Upper Body Blast",
      exercises: [
        Exercise(
            name: "Push-ups",
            weight: "-",
            reps: "15",
            sets: "3"
        ),
      ],
    ),

  ];

  //getting the list of workout
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  //get length of a workout
  int numberOfExerciseInWorkout(String workoutName){
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  //add a workout
  void addWorkout(String name) {
    //add a new workout with blank list of exercise
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
  }

  //add an exercise to workout
  void addExercise(String workoutName,
      String exerciseName,
      String weight,
      String reps,
      String sets
      ){
    // find the relevant workoout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
      Exercise(
          name: exerciseName,
          weight: weight,
          reps: reps,
          sets: sets
      ),
    );

    notifyListeners();
  }

  //check off  exercise
   void checkOffExercise(String workoutName, String exerciseName){
    // find the relevant workout and relevant exercise in that workout

     Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

     relevantExercise.isCompleted = !relevantExercise.isCompleted;

     notifyListeners();
   }
//get length of workouts

  //return relevant workout object, give workout name
  Workout getRelevantWorkout(String workoutName){
    Workout relevantWorkout =
    workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  //retrn relevant exercise object
  Exercise getRelevantExercise(String workoutName, String exerciseName){
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    Exercise relevantExercise = relevantWorkout.exercises
    .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}