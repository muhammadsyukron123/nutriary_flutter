import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../model/user/user.dart';

class UserHiveDataSource{
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>('userBox');
  }
}