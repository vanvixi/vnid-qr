import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StringInputFormField extends StatelessWidget {
  const StringInputFormField({
    super.key,
    this.initialValue,
    required this.labelText,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onSaved,
  });

  final String? initialValue;
  final String labelText;
  final String hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      minLines: 1,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
