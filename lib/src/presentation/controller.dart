part of hint_box;

class HintboxProvider extends StatelessWidget {
  final Widget child;
  final String initialText;
  const HintboxProvider(
      {Key? key, required this.child, required this.initialText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HintboxCubit>(
      create: (context) => HintboxCubit(initialMessage: initialText),
      child: child,
    );
  }
}
