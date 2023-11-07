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
    state = true;
    authrepo.otpgenerate(name);
    state = false;
    ShowSnackBar(context, "Sending OTP");
  }

  Future<bool> verifyotp(String smsCode) async {
    state = true;
    final s = await authrepo.verifyCode(smsCode);
    state = false;
    return s;
  }
}
