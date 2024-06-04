import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_habit_app/model/task_model.dart';

/** TaskService: It consist of the logic that use for TaskModel
 *  it perform the basic CRUD operation on the Task Document
 * **/

class TaskService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //future fn to create
  Future<void> createTask(TaskModel task) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('task')
          .add(task.toMap());
    }
  }

  //read the specific task
  Future<TaskModel?> readTask(String taskId) async {
    User? user = _firebaseAuth.currentUser!;
    print("uid:${user.uid}");
    if (user != null) {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('task')
          .doc(taskId)
          .get();

      if (doc.exists) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    }
    return null;
  }

  //read all the tasks and return as list
  Stream<List<TaskModel>> getTasks() {
    User? user = _firebaseAuth.currentUser;
    print(user?.email);
    print("uid:${user?.uid}");

    // if (user != null) {
    //   return _firestore
    //       .collection('users')
    //       .doc(user.uid)
    //       .collection('tasks')
    //       .snapshots()
    //       .map((snapshot) =>
    //       print("Snapshot received: ${snapshot.docs.length} documents found");
    //         return snapshot.docs
    //           .map((doc) =>
    //           print("Document data:${doc.data()}");
    //       TaskModel.fromMap(doc.data(), doc.id))
    //           .toList());
    // } else {
    //   return Stream.value([]);
    // }
    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('task')
          .snapshots()
          .map((snapshot) {
        print("Snapshot received: ${snapshot.docs.length} documents found");
        return snapshot.docs.map((doc) {
          print("Document data: ${doc.data()}");
          return TaskModel.fromMap(doc.data(), doc.id);
        }).toList();
      });
    } else {
      return Stream.value([]);
    }
  }
}
