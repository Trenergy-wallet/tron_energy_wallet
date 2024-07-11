import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenergy_wallet/core/ext.dart';

/// Отладочный скрин лога
class DebugLogScreen extends ConsumerWidget {
  /// Отладочный скрин лога
  const DebugLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final m = ref.watch(appScaffoldAuthCtrlProvider);
    // final c = ref.watch(appScaffoldAuthCtrlProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Debug log'.hardcoded),
          actions: [
            IconButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) {
                    return AlertDialog.adaptive(
                      title: Text('Clean log'.hardcoded),
                      actions: <Widget>[
                        _adaptiveAction(
                          context: context,
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'.hardcoded),
                        ),
                        _adaptiveAction(
                          context: context,
                          onPressed: () {
                            // c.cleanLog();
                            Navigator.pop(context);
                          },
                          child: Text('OK'.hardcoded),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SelectableText(
                'm.log',
                textAlign: TextAlign.left,
                showCursor: true,
                scrollPhysics: ClampingScrollPhysics(),
                textScaler: TextScaler.linear(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adaptiveAction({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}
