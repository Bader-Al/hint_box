part of hint_box;

class HintboxCubit extends Cubit<HintboxState> {
  HintboxCubit({required String? initialMessage})
      : super(HintboxMessage(message: initialMessage));

  newHintState(HintboxState newState) => emit(newState);
}

class HintboxMessenger {
  final BuildContext context;
  HintboxMessenger._(this.context); //! private
  static HintboxMessenger? of(context) => HintboxMessenger._(context);
  newHint({required HintboxState newState}) =>
      BlocProvider.of<HintboxCubit>(context).newHintState(newState);
}
