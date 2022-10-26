import 'package:flutter/material.dart';

import '../../models/response_model.dart';

class Toast extends StatefulWidget {
  const Toast({required this.data, required this.destroy, Key? key}) : super(key: key);
  final ResponseModel data;
  final void Function() destroy;

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  final Duration _animationDuration = const Duration(milliseconds: 200);
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    _animation = Tween<double>(begin: 100, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeOut,
      ),
    );
    _start();
    super.initState();
  }

  Future<void> _start() async {
    await Future<void>.delayed(Duration.zero);
    await _animationController.forward();
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      await _animationController.reverse();
    }
    widget.destroy();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Positioned(
          bottom: -_animation.value,
          child: Opacity(
            opacity: 1 - (_animation.value / 100),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: const Offset(0, 5),
                        blurRadius: 12,
                        color: Colors.black.withOpacity(0.1),
                      )
                    ],
                    color: widget.data.getBgColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      widget.data.icon,
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.data.getPopupText,
                          style: TextStyle(color: widget.data.getTextColor, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
