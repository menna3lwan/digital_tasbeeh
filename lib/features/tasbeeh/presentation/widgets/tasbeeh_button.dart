import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';

class TasbeehButton extends StatefulWidget {
  const TasbeehButton({
    super.key,
    required this.onPressed,
    required this.isEnabled,
    this.size = 148,
  });

  final VoidCallback onPressed;
  final bool isEnabled;
  final double size;

  @override
  State<TasbeehButton> createState() => _TasbeehButtonState();
}

class _TasbeehButtonState extends State<TasbeehButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressController;
  late final Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _pressScale = Tween<double>(begin: 1, end: 0.93).animate(
      CurvedAnimation(
        parent: _pressController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) {
    if (!widget.isEnabled) return;
    _pressController.forward();
  }

  void _handleTapUp(TapUpDetails _) {
    if (!widget.isEnabled) return;
    _pressController.reverse();
  }

  void _handleTapCancel() {
    if (!widget.isEnabled) return;
    _pressController.reverse();
  }

  void _handleTap() {
    if (!widget.isEnabled) return;
    HapticFeedback.lightImpact();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final buttonSize = widget.size;

    return Semantics(
      button: true,
      label: 'Tap to count tasbeeh',
      enabled: widget.isEnabled,
      child: AnimatedBuilder(
        animation: _pressScale,
        builder: (context, child) {
          return Transform.scale(
            scale: _pressScale.value,
            child: child,
          );
        },
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: InkWell(
            onTap: widget.isEnabled ? _handleTap : null,
            onTapDown: widget.isEnabled ? _handleTapDown : null,
            onTapUp: widget.isEnabled ? _handleTapUp : null,
            onTapCancel: widget.isEnabled ? _handleTapCancel : null,
            customBorder: const CircleBorder(),
            splashColor: AppColors.onPrimary.withOpacity(0.18),
            highlightColor: AppColors.onPrimary.withOpacity(0.08),
            child: Ink(
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isEnabled
                      ? [
                          AppColors.primaryLight,
                          AppColors.primary,
                          AppColors.primaryDark,
                        ]
                      : [
                          AppColors.primaryLight.withOpacity(0.45),
                          AppColors.primary.withOpacity(0.45),
                        ],
                  stops: widget.isEnabled
                      ? const [0.0, 0.55, 1.0]
                      : const [0.0, 1.0],
                ),
                boxShadow: widget.isEnabled
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.28),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.08),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 32,
                    color: AppColors.onPrimary.withOpacity(
                      widget.isEnabled ? 1 : 0.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap',
                    style: AppTypography.tapLabel.copyWith(
                      color: AppColors.onPrimary.withOpacity(
                        widget.isEnabled ? 1 : 0.6,
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
