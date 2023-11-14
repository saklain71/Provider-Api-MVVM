
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/user_view_model.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();

    // Fetch user data when the state object is inserted into the tree.
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: userViewModel.loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : userViewModel.errorMessage.isNotEmpty
          ? Center(
        child: Text(userViewModel.errorMessage),
      )
          : ListView.builder(
        itemCount: userViewModel.users.length,
        itemBuilder: (context, index) {
          final user = userViewModel.users[index];

          // Display a list of users with their name, email, and ID.
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            leading: CircleAvatar(
              child: Text(user.id.toString()),
            ),
          );
        },
      ),
    );
  }
}