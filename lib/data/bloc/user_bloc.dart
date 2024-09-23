import 'package:bloc/bloc.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/user_event.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/user_state.dart';
import 'package:flutter_shopping_app_with_api/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(const UserState()) {
    // Handle loading users
    on<LoadUsers>(_onLoadUsers);

    // Handle adding a user
    on<AddUser>(_onAddUser);

    // Handle editing a user
    on<EditUser>(_onEditUser);

    // Handle deleting a user
    on<DeleteUser>(_onDeleteUser);
  }

  // Load users from the API
  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final users = await userRepository.fetchUsers();
      emit(state.copyWith(users: users, isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  // Add a user via API
  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.addUser(
        event.name,
        event.email,
        event.password,
        event.confirmPassword,
        event.role,
      );
      add(LoadUsers()); // Reload users after adding
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  // Edit a user via API
  Future<void> _onEditUser(EditUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.editUser(
        event.id,
        event.name,
        event.email,
        event.password,
        event.confirmPassword,
        event.role,
      );
      add(LoadUsers()); // Reload users after editing
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  // Delete a user via API
  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    try {
      await userRepository.deleteUser(event.id);
      add(LoadUsers()); // Reload users after deleting
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }
}

// class UserBloc extends Bloc<UserEvent, UserState> {
//   UserBloc() : super(const UserState()) {
//     on<LoadUsers>((event, emit) {
//       emit(state.copyWith(users: _mockData()));
//     });

//     on<AddUser>((event, emit) {
//       final newUser = {
//         'id': state.users.length + 1,
//         'name': event.name,
//         'email': event.email,
//         'role': event.role,
//         'Password': event.password,
//         'Confirm Password': event.confirmPassword,
//       };
//       emit(state.copyWith(users: List.from(state.users)..add(newUser)));
//     });

//     on<EditUser>((event, emit) {
//       final updatedUsers = state.users.map((user) {
//         if (user['id'] == event.id) {
//           return {
//             'id': event.id,
//             'name': event.name,
//             'email': event.email,
//             'role': event.role,
//             'Password': event.password,
//             'Confirm Password': event.confirmPassword,
//           };
//         }
//         return user;
//       }).toList();
//       emit(state.copyWith(users: updatedUsers, isEditing: false));
//     });

//     on<DeleteUser>((event, emit) {
//       emit(state.copyWith(
//           users: state.users.where((user) => user['id'] != event.id).toList()));
//     });
//   }

//   List<Map<String, dynamic>> _mockData() {
//     return [
//       {
//         'id': 1,
//         'name': 'John Doe',
//         'email': 'john.doe@example.com',
//         'role': 'Admin',
//         'Password': '******',
//         'Confirm Password': '******',
//       },
//       {
//         'id': 2,
//         'name': 'Jane Smith',
//         'email': 'jane.smith@example.com',
//         'role': 'User',
//         'Password': '******',
//         'Confirm Password': '******',
//       },
//     ];
//   }
// }
