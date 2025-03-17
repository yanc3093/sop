import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final String labelText;
  final String prefixText;
  final String suffixText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final void Function(String?)? saveInput;
  final String? Function(String?)? validateInput;

  const CustomTextField({
    super.key,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.labelText = '',
    this.prefixText = '',
    this.suffixText = '',
    this.inputFormatters,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.saveInput,
    this.validateInput,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.only(left: 12, right: 12),
        filled: true,
        fillColor: enabled && !readOnly ? Colors.white : Colors.grey.shade200,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: enabled && !readOnly ? '- Please enter a value -' : null,
        hintStyle:
            enabled && !readOnly
                ? const TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                )
                : null,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        prefixText: prefixText,
        suffixIcon:
            enabled && !readOnly
                ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      textEditingController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                )
                : null,
        suffixText: suffixText,
      ),
      enabled: enabled,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.allow(RegExp(r'.'))],
      keyboardType: textInputType,
      obscureText: obscureText,
      onSaved: saveInput,
      readOnly: readOnly,
      validator:
          validateInput ??
          (value) {
            if (labelText.endsWith('*') &&
                (value == null || value.trim().isEmpty)) {
              return 'Mandatory field.';
            }
            return null;
          },
    );
  }
}
