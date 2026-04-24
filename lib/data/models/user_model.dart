import 'package:database_paml/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  // Method toMap sesuai Gambar Anda
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email
    };
  }
}