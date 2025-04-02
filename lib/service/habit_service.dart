import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_habit_app/model/habit_model.dart';

/** HabitService: It consist of the logic that use for HabitModel
 *  it perform the basic CRUD operation on the Task Document
 * **/

class HabitService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //future fn to create
  Future<void> createTask(HabitModel task) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('habit')
          .add(task.toMap());
    }
  }

  //read the specific task
  Future<HabitModel?> readTask(String taskId) async {
    User? user = _firebaseAuth.currentUser!;
    print("uid:${user.uid}");
    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('habit')
        .doc(taskId)
        .get();

    if (doc.exists) {
      return HabitModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  //read all the tasks and return as list
  Stream<List<HabitModel>> getTasks() {
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
          .collection('habit')
          .snapshots()
          .map((snapshot) {
        print("Snapshot received: ${snapshot.docs.length} documents found");
        return snapshot.docs.map((doc) {
          print("Document data: ${doc.data()}");
          return HabitModel.fromMap(doc.data(), doc.id);
        }).toList();
      });
    } else {
      return Stream.value([]);
    }
  }
}
