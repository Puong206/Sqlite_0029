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
}