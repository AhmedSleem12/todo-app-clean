import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final String isCheck;
  final void Function()? method;
  const CheckBox({Key? key, required this.isCheck, required this.method})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: method,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: isCheck == "true"
              ? null
              : Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: isCheck == "true" ? Colors.green : null,
        ),
        child: isCheck == "true"
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
