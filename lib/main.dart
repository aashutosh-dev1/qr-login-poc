import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_login_poc/home/bloc/auth_bloc.dart';
import 'package:qr_login_poc/home/homepage.dart';
import 'package:qr_login_poc/home/repository/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(AuthRepository())),
        ],
        child: HomePage(),
      ),
    );
  }
}
