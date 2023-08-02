import 'package:flutter/material.dart';
import 'package:flutter_mvvm/users_list/models/user_error.dart';
import 'package:flutter_mvvm/users_list/models/users_list_model.dart';
import 'package:flutter_mvvm/users_list/repository/api_status.dart';
import 'package:flutter_mvvm/users_list/repository/user_services.dart';
import 'package:flutter_mvvm/utils/constants.dart';

class UsersViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserModel> _userListModel = [];
  UserError _userError = UserError(code: 0, message: "");
  UserModel _selectedUser = defaultUser;

  UserModel _addingUser = defaultUser;

  bool get loading => _loading;
  List<UserModel> get userListModel => _userListModel;
  UserError get userError => _userError;
  UserModel get selectedUser => _selectedUser;
  UserModel get addingUser => _addingUser;

  UsersViewModel() {
    getUsers();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setSelectedUser(UserModel userModel) {
    _selectedUser = userModel;
  }

  addUser() async {
    if (isValid()) {
      _userListModel.add(addingUser);
      _addingUser = defaultUser;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool isValid() {
    if (addingUser.name.isEmpty || addingUser.email.isEmpty) {
      return false;
    }
    return true;
  }

  getUsers() async {
    setLoading(true);
    var response = await UserServices.getUsersAPI();
    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}
