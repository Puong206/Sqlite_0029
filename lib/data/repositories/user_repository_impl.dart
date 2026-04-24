import 'package:database_paml/data/models/user_model.dart';
import 'package:database_paml/domain/entities/user_entity.dart';
import 'package:database_paml/domain/repository/user_repository.dart';
import 'package:database_paml/helper/database_helper.dart';

class UserRepositoryImpl implements UserRepository {
  final DatabaseHelper dbHelper;
  UserRepositoryImpl(this.dbHelper);

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return maps.map((userMap) => UserEntity.fromMap(userMap)).toList(); 
  }

  @override
  Future<void> addUser(UserEntity user) async {
    final db = await dbHelper.database;
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
    );
    await db.insert('users', userModel.toMap());
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final db = await dbHelper.database;
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
    );
    await db.update(
      'users',
      userModel.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}