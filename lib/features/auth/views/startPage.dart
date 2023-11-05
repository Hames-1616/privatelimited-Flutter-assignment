import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privatelimited/core/dimensions.dart';
import 'package:privatelimited/core/loadingScreen.dart';
import 'package:privatelimited/core/textfield.dart';
import 'package:privatelimited/features/auth/controller/auth_controller.dart';
import 'package:privatelimited/features/auth/views/verifyOTP.dart';

class Homepage extends ConsumerWidget {
  Homepage({super.key});

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
                        "https://img.freepik.com/free-vector/barbershop-team-concept-illustration_114360-10892.jpg?w=996&t=st=1699202461~exp=1699203061~hmac=9c21d586449c746b3b6dfa23322262f7528ebabee889efb040f676736c6cce1b",
                    placeholder: (context, url) =>
                        const Center(
                          child:  CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                        ),
                  )),
              CustomTextField(
                  hintText: "Phone Number",
                  icon: Icons.numbers,
                  onChanged: (value) {},
                  con: number),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (form.currentState!.validate()) {
                   ref
                        .watch(authcontrollerProvider.notifier)
                        .getotp(number.text,context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerify()));
                        
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
                      "Get OTP",
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
