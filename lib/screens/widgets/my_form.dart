import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyForm extends StatefulWidget {
  const MyForm({
    super.key,
    this.onSubmit,
    this.onReset,
    required this.children,
  });

  final VoidCallback? onSubmit;
  final VoidCallback? onReset;
  final List<Widget> children;

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      widget.onSubmit?.call();
    }
  }

  void _handleReset() {
    _formKey.currentState?.reset();
    widget.onReset?.call();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          _handleSubmit();
        }
      },
      child: Form(
        key: _formKey,
        autovalidateMode: .onUnfocus,
        child: SingleChildScrollView(
          padding: const .all(16),
          child: Column(
            spacing: 16,
            children: [
              ...widget.children,
              const SizedBox(height: 16),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(fixedSize: Size.fromHeight(56)),
                      child: const Text(
                        'Tạo QR Code',
                        style: TextStyle(fontSize: 16, fontWeight: .bold),
                      ),
                    ),
                  ),
                  IconButton.filled(
                    onPressed: _handleReset,
                    padding: const .all(16),
                    icon: Icon(Icons.backspace_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
