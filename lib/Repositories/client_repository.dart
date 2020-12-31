import 'package:appointment/Models/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientRepository {
  ClientRepository.defaultConstructor();
  Future<Client> addClient(Map data) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('client').add(data);
    return await getClientData(reference.id);
  }

  Future<Client> getClientData(String clientID) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection('client').doc(clientID).get();
    return Client.fromMap(snapshot.data(), snapshot.id);
  }

  Future<List<Client>> getClientsList() async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference.collection('client').get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<Client> clients = List();
      snapshot.docs.forEach((element) {
        clients.add(Client.fromMap(element.data(), element.id));
      });
      return clients;
    }
  }
}
