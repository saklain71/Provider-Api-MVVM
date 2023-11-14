import 'package:flutter/material.dart';
import '../data/models/user.dart';
import '../data/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  UserViewModel({required this.userRepository});

  List<User> _users = []; // List to store user data fetched from the API.
  bool _loading = false; // Boolean flag to track if data is currently being fetched.
  String _errorMessage = ''; // String to store any error message that occurs during data fetching.

  List<User> get users => _users; // Getter method to access the list of users.
  bool get loading => _loading; // Getter method to access the loading flag.
  String get errorMessage => _errorMessage; // Getter method to access the error message.

  Future<void> fetchUsers() async {
    _loading = true; // Set loading flag to true before making the API call.
    _errorMessage = ''; // Clear any previous error message.

    try {
      // Call the getUsers() method from the UserRepository to fetch user data from the API.
      _users = await userRepository.getUsers();

    } catch (e) {
      // If an exception occurs during the API call, set the error message to display the error.
      _errorMessage = 'Failed to fetch users';
    } finally {
      // After API call is completed, set loading flag to false and notify listeners of data change.
      _loading = false;
      notifyListeners();
    }
  }
}