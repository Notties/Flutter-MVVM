// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/users_list/view_models/users_view_model.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  UsersViewModel _usersViewModel = UsersViewModel();

  @override
  void initState() {
    super.initState();
    _usersViewModel = Provider.of<UsersViewModel>(context, listen: false);
    _usersViewModel.addingUser.name = "";
    _usersViewModel.addingUser.email = "";
  }

  @override
  void dispose() {
    _usersViewModel.addingUser.name = "";
    _usersViewModel.addingUser.email = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        actions: [
          IconButton(
            onPressed: (usersViewModel.addingUser.name.trim().isEmpty ||
                    usersViewModel.addingUser.email.trim().isEmpty)
                ? null
                : () async {
                    bool userAdded = await usersViewModel.addUser();
                    if (!userAdded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to add user.')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saved successfully.')));
                      Navigator.pop(context);
                    }
                  },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Name'),
              onChanged: (val) {
                setState(() {
                  usersViewModel.addingUser.name = val;
                });
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
              onChanged: (val) {
                setState(() {
                  usersViewModel.addingUser.email = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
