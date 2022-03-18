// part of 'tooltip_cubit.dart';
part of hint_box;

@immutable
abstract class HintboxState {
  abstract final String? message;
}

class HintboxMessage extends HintboxState {
  HintboxMessage({required this.message});
  @override
  final String? message;
}

class HintboxError extends HintboxState {
  HintboxError({required this.message});
  @override
  final String? message;
}
