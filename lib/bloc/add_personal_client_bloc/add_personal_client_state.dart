part of 'add_personal_client_bloc.dart';

@immutable
abstract class AddPersonalClientState {}

class AddPersonalClientInitial extends AddPersonalClientState {}

class AddPersonalClientLoadingState extends AddPersonalClientState {}

class PersonalClientAddedSuccessfullyState extends AddPersonalClientState {
  final Client client;
  PersonalClientAddedSuccessfullyState({@required this.client});
}
