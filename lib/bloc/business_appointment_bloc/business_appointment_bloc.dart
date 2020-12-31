import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'business_appointment_event.dart';
part 'business_appointment_state.dart';

class BusinessAppointmentBloc
    extends Bloc<BusinessAppointmentEvent, BusinessAppointmentState> {
  BusinessAppointmentBloc() : super(BusinessAppointmentInitial());

  @override
  Stream<BusinessAppointmentState> mapEventToState(
    BusinessAppointmentEvent event,
  ) async* {}
}
