import 'dart:async';

import 'package:appointment/Models/client_model.dart';
import 'package:appointment/Repositories/client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_personal_client_event.dart';
part 'view_personal_client_state.dart';

class ViewPersonalClientBloc
    extends Bloc<ViewPersonalClientEvent, ViewPersonalClientState> {
  ViewPersonalClientBloc() : super(ViewPersonalClientInitial());

  @override
  Stream<ViewPersonalClientState> mapEventToState(
    ViewPersonalClientEvent event,
  ) async* {
    if (event is GetClientListEvent) {
      yield ViewPersonalClientLoadingState();
      List<Client> clients = List();
      clients = await ClientRepository.defaultConstructor().getClientsList();
      if (clients == null || clients.isEmpty) {
        yield NoClientFoundState();
      } else {
        yield GetClientListState(clientList: clients);
      }
    } else if (event is ClientSearchingEvent) {
      List<Client> clientList = event.clientList;
      List<Client> filtered = List();
      String string = event.query;
      clientList.forEach((element) {
        if (element
                .getLastName()
                .toLowerCase()
                .contains(string.toLowerCase()) ||
            element.getPhone().toLowerCase().contains(string.toLowerCase())) {
          filtered.add(element);
        }
      });

      yield ClientSearchingState(
          filteredList: filtered, clientList: clientList);
    } else if (event is ViewSelectedClientEvent) {
      yield ClientSelectedState(client: event.client);
    }
  }
}
