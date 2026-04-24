import 'package:database_paml/domain/repository/user_repository.dart';
import 'package:database_paml/helper/database_helper.dart';

class UserRepositoryImpl implements UserRepository {
  final DatabaseHelper dbHelper;
  UserRepositoryImpl(this.dbHelper);

  
}