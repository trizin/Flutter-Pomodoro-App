import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedFlipCounter extends StatelessWidget {
  final String value;
  final Duration duration;
  final double size;
  final Color color;

  const AnimatedFlipCounter({
    Key key,
    @required this.value,
    @required this.duration,
    this.size = 72,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> digits = [];

    digits =
        value.split(":").join("").split("").map((x) => int.parse(x)).toList();
    digits = new List.from(digits.reversed);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _SingleDigitFlipCounter(
          key: ValueKey(3),
          value: digits[3].toDouble(),
          duration: duration,
          height: size,
          width: size / 1.8,
          color: color,
        ),
        _SingleDigitFlipCounter(
          key: ValueKey(2),
          value: digits[2].toDouble(),
          duration: duration,
          height: size,
          width: size / 1.8,
          color: color,
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        _SingleDigitFlipCounter(
          key: ValueKey(1),
          value: digits[1].toDouble(),
          duration: duration,
          height: size,
          width: size / 1.8,
          color: color,
        ),
        _SingleDigitFlipCounter(
          key: ValueKey(0),
          value: digits[0].toDouble(),
          duration: duration,
          height: size,
          width: size / 1.8,
          color: color,
        ),
      ],
    );
  }
}

class _SingleDigitFlipCounter extends StatelessWidget {
  final double value;
  final Duration duration;
  final double height;
  final double width;
  final Color color;

  const _SingleDigitFlipCounter({
    Key key,
    @required this.value,
    @required this.duration,
    @required this.height,
    @required this.width,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: value, end: value),
      duration: duration,
      builder: (context, value, child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        return SizedBox(
          height: height,
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildSingleDigit(
                context,
                digit: whole % 10,
                offset: height * decimal,
                opacity: 1 - decimal,
              ),
              _buildSingleDigit(
                context,
                digit: (whole + 1) % 10,
                offset: height * decimal - height,
                opacity: decimal,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDigit(context,
      {int digit, double offset, double opacity}) {
    return Positioned(
      child: SizedBox(
        width: width,
        child: Opacity(
          opacity: opacity,
          child: Text(
            "$digit",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottom: offset,
    );
  }
}
