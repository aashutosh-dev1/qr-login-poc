import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_login_poc/home/bloc/auth_bloc.dart';
import 'package:qr_login_poc/home/repository/auth_repository.dart';

class LoginInitiatedScreen extends StatefulWidget {
  const LoginInitiatedScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginInitiatedScreenState();
}

class _LoginInitiatedScreenState extends State<LoginInitiatedScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.loginReqState == StateStatus.loading ||
              state.loginReqState == StateStatus.initial) {
            if (result != null) {
              context.read<AuthBloc>().add(LoginReqEvent(result!.code));
            }

            return _buildQrView(context);
          } else if (state.loginReqState == StateStatus.error) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return Center(
              child: Text('Success, Signed In'),
            );
          }
        },
      ),
    ));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        controller.scannedDataStream.first.then((data) {
          setState(() {
            result = data;
          });
        });
      },
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
