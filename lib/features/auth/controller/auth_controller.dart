import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privatelimited/core/showsnack.dart';
import 'package:privatelimited/features/auth/repos/auth_repo.dart';

final authcontrollerProvider = StateNotifierProvider<authcontroller, bool>(
    (ref) => authcontroller(cauthrepo: ref.read(authrepoProvider)));

class authcontroller extends StateNotifier<bool> {
  final Authrepo authrepo;

  authcontroller({
    required Authrepo cauthrepo,
  })  : authrepo = cauthrepo,
        super(false);

  void getotp(String name, BuildContext context) {
    authrepo.otpgenerate(name);
    ShowSnackBar(context, "Sending OTP");
  }

  Future<bool> verifyotp(String smsCode) async {
    final s = await authrepo.verifyCode(smsCode);
    return s;
  }
}
