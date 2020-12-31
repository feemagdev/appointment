part of 'view_personal_client_bloc.dart';

@immutable
abstract class ViewPersonalClientState {}

class ViewPersonalClientInitial extends ViewPersonalClientState {}

class ClientSelectedState extends ViewPersonalClientState {
  final Client client;
  ClientSelectedState({@required this.client});
}

class ClientSearchingState extends ViewPersonalClientState {
  final List<Client> clientList;
  final List<Client> filteredList;

  ClientSearchingState(
      {@required this.clientList, @required this.filteredList});
}

class GetClientListState extends ViewPersonalClientState {
  final List<Client> clientList;
  GetClientListState({@required this.clientList});
}

class ViewPersonalClientLoadingState extends ViewPersonalClientState {}

class NoClientFoundState extends ViewPersonalClientState {}
