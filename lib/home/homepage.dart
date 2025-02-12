import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_bar_code/qr/qr.dart';
import 'package:qr_login_poc/home/bloc/auth_bloc.dart';
import 'package:qr_login_poc/home/login_initiated_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String devId = '';

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.initializeLoginReqState == StateStatus.loading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QRCode(
                  data: devId,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginReqEvent(devId));
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            );
          } else if (state.initializeLoginReqState == StateStatus.error) {
            return const Center(
              child: Text('Error'),
            );
          } else if (state.initializeLoginReqState == StateStatus.success) {
            return Center(
              child: Text('Welcome, Signed In \n  ${state.token}'),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {
                        devId = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8),
                Text(devId),
                SizedBox(height: 8),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print('object');
                      context
                          .read<AuthBloc>()
                          .add(InitializeLoginReqEvent('$devId'));
                    },
                    child: const Text('Initialize Login'),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginInitiatedScreen(),
                      ));
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
