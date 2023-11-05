import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privatelimited/core/providers.dart';

final authrepoProvider =
    Provider((ref) => Authrepo(cauth: ref.read(FirebaseAuthProvider)));

class Authrepo {
  final FirebaseAuth auth;

  Authrepo({
    required FirebaseAuth cauth,
  }) : auth = cauth;

  String ver = "";
  void otpgenerate(String number) async {
    await auth.verifyPhoneNumber(
      phoneNumber: "+91$number",
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        ver = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        ver = verificationId;
      },
    );
  }

  Future<bool> verifyCode(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: ver,
      smsCode: smsCode,
    );
    try {
      final user = await auth.signInWithCredential(credential);
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
