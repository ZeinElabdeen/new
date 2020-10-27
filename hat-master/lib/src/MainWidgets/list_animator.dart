import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListAnimator extends StatefulWidget {
  final List<Widget> data;
  final int duration;
  final double verticalOffset;

  const ListAnimator({
    Key key,
    this.data,
    this.duration,
    this.verticalOffset,
  }) : super(key: key);

  @override
  _ListAnimatorState createState() => _ListAnimatorState();
}

class _ListAnimatorState extends State<ListAnimator> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.data.length,
        itemBuilder: (_, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: Duration(milliseconds: 400),
            child: SlideAnimation(
              duration: Duration(milliseconds: widget.duration ?? 400),
              verticalOffset: widget.verticalOffset ?? 50.0,
              child: FadeInAnimation(
                child: widget.data[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
