part of hint_box;

final _shakeKey = GlobalKey<ShakeWidgetState>();

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

class HintBox extends StatelessWidget {
  final Function()? onTap;
  const HintBox({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      BlocProvider.of<HintboxCubit>(context); //! breaks out of try here
      return ShakeWidget(
        key: _shakeKey,
        shakeCount: 3,
        shakeOffset: 10,
        shakeDuration: const Duration(milliseconds: 400),
        child: BlocBuilder<HintboxCubit, HintboxState>(
          builder: (context, state) {
            bool isError = false;
            if (state is HintboxError) {
              _shakeKey.currentState?.shake();
              isError = true;
            }
            return HintboxWidget(
              message: state.message ?? 'ok',
              textColor: isError ? Colors.red : Colors.white,
              isError: isError,
              onTap: onTap,
            );
          },
        ),
      );
    } catch (e) {
      return HintboxWidget(
        message: "HintboxCubit not provided :(",
        onTap: onTap,
      );
    }
  }
}

class HintboxWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color bulbColor;
  final double borderWidth;
  final String message;
  final Color textColor;
  final bool isError;
  final Function()? onTap;
  const HintboxWidget({
    Key? key,
    this.backgroundColor = const Color(0xff212121),
    this.bulbColor = const Color(0xffFBC53C),
    this.borderColor = const Color(0xff121212),
    this.textColor = Colors.white,
    this.borderWidth = 1,
    this.isError = false,
    this.message = "smn wrong",
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          constraints: BoxConstraints(
            minWidth: 250,
            maxWidth: 350,
          ),
          height: 100,
          // child: Text(mock),
          child: Stack(clipBehavior: Clip.none, children: [
            Opacity(
                //only here to control stack's size
                opacity: 0,
                child: HintboxText(
                  message: message,
                  textColor: textColor,
                )),
            Positioned.fill(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    alignment: Alignment.center,
                    child: HintboxText(
                      message: message,
                      textColor: textColor,
                    ))),
            Positioned(
                top: -19,
                left: 0,
                right: 0,
                child: Center(
                    child: HintboxIcon(
                  backgroundColor: backgroundColor,
                  bulbColor: bulbColor,
                  isError: isError,
                )))
          ]),
        ),
      ),
    );
  }
}

class HintboxIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color bulbColor;
  final bool isError;
  const HintboxIcon({
    Key? key,
    this.backgroundColor = const Color(0xff212121),
    this.bulbColor = const Color(0xffFBC53C),
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(
        isError ? EvaIcons.alertTriangleOutline : EvaIcons.bulbOutline,
        color: isError ? Colors.red : bulbColor,
        size: 29,
      ),
    );
  }
}

class HintboxText extends StatelessWidget {
  final String message;
  final Color textColor;
  const HintboxText({Key? key, required this.message, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle _msgStyle = TextStyle(
      package: "parrot_styles",
      fontFamily: "MontserratAlternates",
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: textColor,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: _msgStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6),
        Text(
          "learn more",
          style: _msgStyle.copyWith(
              fontSize: 10, fontStyle: FontStyle.italic, color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
