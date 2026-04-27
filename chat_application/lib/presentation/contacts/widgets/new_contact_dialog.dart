import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class NewContactDialog extends StatefulWidget {
  const NewContactDialog({super.key});

  @override
  State<NewContactDialog> createState() => _NewContactDialogState();
}

class _NewContactDialogState extends State<NewContactDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_add, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          const Text(
            'New Contact',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: _inputDecoration(
                label: 'Name',
                hint: 'Enter contact name',
                icon: Icons.person_outline,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Name is required';
                if (v.trim().length < 2) return 'Name must be at least 2 characters';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration(
                label: 'Phone (optional)',
                hint: '+1 234 567 8900',
                icon: Icons.phone_outlined,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
          ),
        ),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Add', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      floatingLabelStyle: const TextStyle(color: AppColors.primary),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'name': _nameController.text,
        'phone': _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      });
    }
  }
}
