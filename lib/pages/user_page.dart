import 'package:database_paml/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserFormPage extends StatefulWidget {
    final UserEntity? user;

    const UserFormPage({super.key, this.user});

    @override
    State<UserFormPage> createState() => _UserFormPageState();
}

