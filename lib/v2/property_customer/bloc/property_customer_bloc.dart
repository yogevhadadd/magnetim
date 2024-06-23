import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'property_customer_event.dart';
part 'property_customer_state.dart';

class PropertyCustomerBloc
    extends Bloc<PropertyCustomerEvent, PropertyCustomerState> {
  PropertyCustomerBloc() : super(PropertyCustomerInitial()) {
    on<PropertyCustomerOnButtonClick>(_propertyCustomerOnButtonClick);
  }

  FutureOr<void> _propertyCustomerOnButtonClick(
      PropertyCustomerOnButtonClick event,
      Emitter<PropertyCustomerState> emit) {
    emit(PropertyCustomerNavToNextPage());
  }
}
