part of 'property_customer_bloc.dart';

@immutable
abstract class PropertyCustomerState {}

final class PropertyCustomerInitial extends PropertyCustomerState {}

@immutable
abstract class PropertyCustomerNavigationState extends PropertyCustomerState {}

final class PropertyCustomerNavToNextPage
    extends PropertyCustomerNavigationState {}
