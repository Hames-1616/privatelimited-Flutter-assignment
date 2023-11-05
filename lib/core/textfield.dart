import 'package:flutter/material.dart';
import 'package:privatelimited/core/dimensions.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
  
    this.keyboard = TextInputType.text,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.con,
    Key? key,
  }) : super(key: key);


  final TextInputType keyboard;
  final String hintText;
  final IconData icon;

  final Function(String) onChanged;
  final TextEditingController con;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width / wid(context, 25),
          left: MediaQuery.of(context).size.width / wid(context, 25),
          bottom: MediaQuery.of(context).size.height / hei(context, 15)),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This Field is requried";
          }
          if(hintText == "Phone NUmber")
          {
            if (value.length != 10) {
            return "Invalid Phone number";
          }
          }

          if(hintText == "OTP")
          {
            if(value.length != 6)
            {
              return "Invalid OTP";
            }
          }
          return null;
        },
        maxLength: (hintText == "Phone Number")?10:6,
        keyboardType: TextInputType.number,
        controller: con,
        style: const TextStyle(
          color: Colors.black,
          // fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.all(18.0),
          filled: true,
          fillColor: Colors.grey.shade300,
          prefixIcon: Icon(
            icon,
            size: 24.0,
            color: Colors.black45,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black45,
            // fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Colors.black45),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide(color: Colors.red.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
