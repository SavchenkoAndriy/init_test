import 'package:flutter/material.dart';

import '../../constants/size_constants.dart';

class ScrollWithoutGlow extends StatefulWidget {
  const ScrollWithoutGlow({
    this.children,
    this.child,
    this.scrollDirection = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.padding = EdgeInsets.zero,
    this.withMinSize = true,
    Key? key,
  }) : super(key: key);

  final Axis scrollDirection;
  final List<Widget>? children;
  final Widget? child;
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool withMinSize;

  @override
  State<ScrollWithoutGlow> createState() => _ScrollWithoutGlowState();

}
class _ScrollWithoutGlowState extends State<ScrollWithoutGlow> with AutomaticKeepAliveClientMixin{

  Widget _buildChild(BuildContext context) {
    if (widget.child != null) {
      final double size = MediaQuery.of(context).size.height;
      return Container(
        constraints: BoxConstraints(
          minHeight: widget.withMinSize ? (size - SizeConstants.headerHeight - SizeConstants.menuHeight) : 0,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: widget.child,
      );
    } else {
      return Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisSize: widget.mainAxisSize,
        children: widget.children ?? <Widget>[],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        padding: widget.padding,
        scrollDirection: widget.scrollDirection,
        controller: ScrollController(),
        physics: const ClampingScrollPhysics(),
        child: _buildChild(context),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
