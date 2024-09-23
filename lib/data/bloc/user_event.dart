import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class AddUser extends UserEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;

  const AddUser({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.role,
  });
}

class EditUser extends UserEvent {
  final int id;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;

  const EditUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.role,
  });
}

class DeleteUser extends UserEvent {
  final int id;

  const DeleteUser(this.id);
}

class LoadUsers extends UserEvent {}
