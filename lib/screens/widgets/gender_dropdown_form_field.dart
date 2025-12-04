import 'package:flutter/material.dart';

import '../../models/gender.dart';

class GenderDropdownFormField extends StatelessWidget {
  const GenderDropdownFormField({super.key, this.initialValue, this.onSaved});

  final Gender? initialValue;
  final FormFieldSetter<Gender>? onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      initialValue: initialValue,
      decoration: const InputDecoration(
        labelText: 'Giới tính *',
        border: OutlineInputBorder(),
      ),
      items: Gender.values.map((gender) {
        return DropdownMenuItem(
          value: gender,
          child: Text(gender.displayName),
        );
      }).toList(),
      onChanged: (v) => {},
      onSaved: onSaved,
    );
  }
}
