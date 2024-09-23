import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final List<Map<String, dynamic>> users;
  final bool isEditing;
  final Map<String, dynamic>? editingUser;
  final bool isLoading;
  final String? error;

  const UserState({
    this.users = const [],
    this.isEditing = false,
    this.editingUser,
    this.isLoading = false,
    this.error,
  });

  UserState copyWith({
    List<Map<String, dynamic>>? users,
    bool? isEditing,
    Map<String, dynamic>? editingUser,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      users: users ?? this.users,
      isEditing: isEditing ?? this.isEditing,
      editingUser: editingUser ?? this.editingUser,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [users, isEditing, editingUser, isLoading, error];
}



// import 'package:equatable/equatable.dart';

// class UserState extends Equatable {
//   final List<Map<String, dynamic>> users;
//   final bool isEditing;
//   final Map<String, dynamic>? editingUser;

//   const UserState({
//     this.users = const [],
//     this.isEditing = false,
//     this.editingUser,
//   });

//   UserState copyWith({
//     List<Map<String, dynamic>>? users,
//     bool? isEditing,
//     Map<String, dynamic>? editingUser,
//   }) {
//     return UserState(
//       users: users ?? this.users,
//       isEditing: isEditing ?? this.isEditing,
//       editingUser: editingUser ?? this.editingUser,
//     );
//   }

//   @override
//   List<Object?> get props => [users, isEditing, editingUser];
// }
