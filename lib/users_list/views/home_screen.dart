import 'package:flutter/material.dart';
import 'package:flutter_mvvm/users_list/components/app_error.dart';
import 'package:flutter_mvvm/users_list/components/app_loading.dart';
import 'package:flutter_mvvm/users_list/components/user_list_row.dart';
import 'package:flutter_mvvm/users_list/models/users_list_model.dart';
import 'package:flutter_mvvm/users_list/view_models/users_view_model.dart';
import 'package:flutter_mvvm/utils/navigation_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            onPressed: () async {
              openAddUser(context);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              usersViewModel.getUsers();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          _ui(usersViewModel),
        ],
      ),
    );
  }

  _ui(UsersViewModel usersViewModel) {
    if (usersViewModel.loading) {
      return const AppLoading();
    }
    if (usersViewModel.userError.code > 0) {
      return AppError(
        errortxt: usersViewModel.userError.message,
      );
    }
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (context, index) {
          UserModel userModel = usersViewModel.userListModel[index];
          return UserListRow(
            userModel: userModel,
            onTap: () async {
              await usersViewModel.setSelectedUser(userModel);
              openUserDetails(context);
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: usersViewModel.userListModel.length,
      ),
    );
  }
}
