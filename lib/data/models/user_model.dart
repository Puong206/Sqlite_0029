import 'package:database_paml/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.noTelpon,
    required super.alamat
  });

  // Method toMap sesuai Gambar Anda
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'noTelpon': noTelpon,
      'alamat': alamat,
    };
  }

  // Factory fromMap sesuai gambar Anda
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      noTelpon: map['noTelpon'] ?? '',
      alamat: map['alamat'] ?? '',
    );
  }
}