part of 'chat_screen.cg.dart';

///
class ChatScreen extends ConsumerWidget {
  ///
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppScaffold(
      navBarEnable: false,
      body: Center(
        child: RiveComingSoon(),
      ),
    );
  }
}
