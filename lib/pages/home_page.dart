import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_workout_companion/data/workout_data.dart';
import 'package:your_workout_companion/pages/workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //text controller
  final newWorkoutNameController = TextEditingController();

  //create new workout
  void createNewWorkout(){
    showDialog(context: context,
        builder: (context) =>  AlertDialog(
          title: const Text("Create a new workout"),
          content: TextField(
            controller: newWorkoutNameController,
          ),
          actions: [
            //save
            MaterialButton(
                onPressed: save,
                child: const Text("save")
              ),

            //cancel
            MaterialButton(
                onPressed: cancel,
                child: const Text("cancel")
            )
          ],
        ),
    );
  }

  //go to workout page
  void goToWorkoutPage(String workoutName){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => WorkoutPage(
        workoutName: workoutName,
      ),
    ),
    );
  }

  //save workout
  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false)
        .addWorkout(newWorkoutName);
      //pop the dialog box
    Navigator.pop(context);
  }

  void cancel(){
    Navigator.pop(context);
  }

  //clear
  void clear() {
    newWorkoutNameController.clear();
  }

  @override 
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(child:  Text('Workout Tracker')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add, color: Colors.blueAccent,),
        ),
        body: ListView.builder(
            itemCount: value.getWorkoutList().length,
            itemBuilder:(context, index) =>  ListTile(
              title: Text(value.getWorkoutList() [index].name),
              trailing: IconButton(icon: const Icon(Icons.send_to_mobile_sharp),
              onPressed:() => goToWorkoutPage(
                  value.getWorkoutList() [index].name)),
            ),
        ),
      ),
    );
  }
}
