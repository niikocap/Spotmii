import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate(message) async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: message,
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Fingerprint required!',
            cancelButton: 'No thanks',
          ),
          IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }
}