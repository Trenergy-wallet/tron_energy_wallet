part of 'splash_screen.cg.dart';

///
class SplashScreen extends ConsumerWidget {
  ///
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(_splashCtrlProvider);
    return Container(
      height: screenHeight / 2,
      width: screenWidth / 2,
      color: AppColors.primaryMid,
      child: const RiveSplashScreen(),
    );
  }
}
