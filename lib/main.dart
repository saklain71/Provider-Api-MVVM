// main.dart

import 'package:api_provider_mvvm/view/user_list.dart';
import 'package:api_provider_mvvm/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import './data/repositories/user_repository.dart';
import './data/services/api_service.dart';


void main() {
  // Create Dio instance for HTTP requests
  final Dio dio = Dio();

  // Create ApiService instance with the Dio instance
  final ApiService apiService = ApiService(dio: dio);

  // Create UserRepository instance with the ApiService instance
  final UserRepository userRepository = UserRepository(apiService: apiService);

  runApp(
    MultiProvider(
      providers: [
        // Provide the UserViewModel with UserRepository dependency to manage user data and API calls
        ChangeNotifierProvider<UserViewModel>(
          create: (context) => UserViewModel(userRepository: userRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List', // Meta Title for the App
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const UserList(),
    );
  }
}