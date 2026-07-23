import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../cubit/tasbeeh_cubit.dart';
import '../../cubit/tasbeeh_state.dart';
import '../widgets/counter_display.dart';
import '../widgets/reset_button.dart';
import '../widgets/tasbeeh_button.dart';

class TasbeehPage extends StatefulWidget {
  const TasbeehPage({super.key});

  @override
  State<TasbeehPage> createState() => _TasbeehPageState();
}

class _TasbeehPageState extends State<TasbeehPage> {
  @override
  void initState() {
    super.initState();
    context.read<TasbeehCubit>().loadCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundTop,
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<TasbeehCubit, TasbeehState>(
            listener: (context, state) {
              if (state is TasbeehError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
              }
            },
            builder: (context, state) {
              final isLoading =
                  state is TasbeehLoading || state is TasbeehInitial;
              final count = state is TasbeehLoaded ? state.count : 0;
              final isInteractive = state is TasbeehLoaded;

              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2.5,
                  ),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final isLandscape =
                      constraints.maxWidth > constraints.maxHeight;

                  if (isLandscape) {
                    return _LandscapeLayout(
                      count: count,
                      isInteractive: isInteractive,
                      onIncrement: () =>
                          context.read<TasbeehCubit>().increment(),
                      onReset: () => context.read<TasbeehCubit>().reset(),
                    );
                  }

                  return _PortraitLayout(
                    count: count,
                    isInteractive: isInteractive,
                    onIncrement: () =>
                        context.read<TasbeehCubit>().increment(),
                    onReset: () => context.read<TasbeehCubit>().reset(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          AppConstants.appName,
          style: AppTypography.title,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6),
        Text(
          'Tap to count your dhikr',
          style: AppTypography.subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({
    required this.count,
    required this.isInteractive,
    required this.onIncrement,
    required this.onReset,
  });

  final int count;
  final bool isInteractive;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final tapSize = screenHeight < 700 ? 136.0 : 148.0;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const _PageHeader(),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CounterDisplay(count: count),
                  const SizedBox(height: AppSpacing.counterToButton),
                  TasbeehButton(
                    size: tapSize,
                    onPressed: onIncrement,
                    isEnabled: isInteractive,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ResetButton(
              onPressed: onReset,
              isEnabled: isInteractive && count > 0,
            ),
          ),
          const SizedBox(height: AppSpacing.bottomSafe),
        ],
      ),
    );
  }
}

class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout({
    required this.count,
    required this.isInteractive,
    required this.onIncrement,
    required this.onReset,
  });

  final int count;
  final bool isInteractive;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _PageHeader(),
                const SizedBox(height: AppSpacing.sectionGap),
                CounterDisplay(count: count),
                const SizedBox(height: 24),
                ResetButton(
                  onPressed: onReset,
                  isEnabled: isInteractive && count > 0,
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Center(
            child: TasbeehButton(
              size: 132,
              onPressed: onIncrement,
              isEnabled: isInteractive,
            ),
          ),
        ],
      ),
    );
  }
}
