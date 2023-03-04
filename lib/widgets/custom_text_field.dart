import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController? textEditingController;
  IconData? iconData;
  String? hintText;
  bool? isObscure = true;
  bool? enabled = true;

  CustomTextField({
    // Key? key,
    this.textEditingController,
    this.iconData,
    this.hintText,
    this.isObscure,
    this.enabled,
  });
  // : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: widget.enabled,
        obscureText: widget.isObscure!,
        controller: widget.textEditingController,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(widget.iconData,
          color: Colors.purpleAccent,),
          focusColor: Theme.of(context).primaryColor,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
