import 'package:flutter/cupertino.dart';
import '../../models/login_model.dart';
import '../models/register_model.dart';
import '../models/user_model.dart';

class DataState extends ChangeNotifier {
  LoginModel loginModel = LoginModel();
  RegisterModel registerModel = RegisterModel();
  UserModel user = UserModel();
}
