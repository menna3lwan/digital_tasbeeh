import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({
    super.key,
    required this.onPressed,
    required this.isEnabled,
  });

  final VoidCallback onPressed;
  final bool isEnabled;

  Future<void> _showConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Counter'),
          content: const Text(
            'Are you sure you want to reset the counter to zero?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.error,
                elevation: 0,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Reset counter',
      enabled: isEnabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? () => _showConfirmation(context) : null,
          borderRadius: BorderRadius.circular(24),
          splashColor: AppColors.onBackgroundMuted.withOpacity(0.08),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isEnabled ? 1 : 0.4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.onBackgroundMuted.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.refresh_rounded,
                    size: 16,
                    color: AppColors.onBackgroundMuted.withOpacity(
                      isEnabled ? 0.85 : 0.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Reset',
                    style: AppTypography.resetLabel.copyWith(
                      color: AppColors.onBackgroundMuted.withOpacity(
                        isEnabled ? 0.85 : 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
