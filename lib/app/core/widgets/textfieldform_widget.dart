import 'package:flutter/material.dart';

class CustomTextfieldformWidget extends StatelessWidget {
  const CustomTextfieldformWidget({
    super.key,
    required this.hintName,
    required this.textController,
  });

  final String hintName;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: TextFormField(
          // textInputAction: action,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: hintName,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, ingrese un valor';
            }
            return null;
          },
          controller: textController,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}
