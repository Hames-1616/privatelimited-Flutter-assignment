import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privatelimited/core/dimensions.dart';
import 'package:privatelimited/core/loadingScreen.dart';
import 'package:privatelimited/core/showsnack.dart';
import 'package:privatelimited/core/textfield.dart';
import 'package:privatelimited/features/auth/controller/auth_controller.dart';
import 'package:privatelimited/features/home/views/maineNav.dart';
import 'package:privatelimited/features/home/views/mainpage.dart';

class OtpVerify extends ConsumerWidget {
  OtpVerify({super.key});

  final number = TextEditingController();
  static final GlobalKey<FormState> form =
      GlobalKey<FormState>(debugLabel: "key2");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authcontrollerProvider)?const Loading():
    Scaffold(
        body: Form(
      key: form,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              SizedBox(
                  height:
                      MediaQuery.of(context).size.height / hei(context, 400),
                  width: MediaQuery.of(context).size.width / wid(context, 350),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://img.freepik.com/free-vector/enter-otp-concept-illustration_114360-7867.jpg?w=996&t=st=1699204039~exp=1699204639~hmac=61a3a6a133098449724c8663b87e035468dcc43c1ef423c9fd21c240f5a90b20",
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  )),
              CustomTextField(
                  hintText: "OTP",
                  icon: Icons.numbers,
                  onChanged: (value) {},
                  con: number),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (form.currentState!.validate()) {
                    final s = await ref
                        .watch(authcontrollerProvider.notifier)
                        .verifyotp(number.text);
                    if (s) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  mainScreen()),
                          (route) => false);
                    } else {
                      // ignore: use_build_context_synchronously
                      ShowSnackBar(context, "Wrong OTP");
                    }
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    height:
                        MediaQuery.of(context).size.height / hei(context, 50),
                    width:
                        MediaQuery.of(context).size.width / wid(context, 100),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        color: Colors.black),
                    child: const Text(
                      "Verify OTP",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
