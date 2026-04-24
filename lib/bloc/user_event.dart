import 'package:database_paml/domain/entities/user_entity.dart';

abstract class UserEvent {}
class LoadUsers extends UserEvent {}
class AddUserEvent extends UserEvent {
  final UserEntity user;
  AddUserEvent(this.user);
}
class DeleteUserEvent extends UserEvent {
  final int id;
  DeleteUserEvent(this.id);
}
class UpdateUserEvent extends UserEvent {
  final UserEntity user;
  UpdateUserEvent(this.user);
}