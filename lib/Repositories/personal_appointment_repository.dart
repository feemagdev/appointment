import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalAppointmentRepository {
  PersonalAppointmentRepository.defaultConstructor();

  Future<bool> createAppointment(Map data) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('personal_appointment').add(data);
    if (reference.id.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
