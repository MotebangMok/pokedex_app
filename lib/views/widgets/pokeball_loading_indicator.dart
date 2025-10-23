import 'package:flutter/material.dart';

class PokeballLoadingIndicator extends StatefulWidget {
  final double size;

  const PokeballLoadingIndicator({super.key, this.size = 60.0});

  @override
  State<PokeballLoadingIndicator> createState() =>
      _PokeballLoadingIndicatorState();
}

class _PokeballLoadingIndicatorState extends State<PokeballLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Top half (red)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: widget.size / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.red.shade400, Colors.red.shade700],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.size / 2),
                        topRight: Radius.circular(widget.size / 2),
                      ),
                    ),
                  ),
                ),
                // Bottom half (white)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: widget.size / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(widget.size / 2),
                        bottomRight: Radius.circular(widget.size / 2),
                      ),
                    ),
                  ),
                ),
                // Middle line
                Center(
                  child: Container(
                    height: widget.size * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                // Center circle
                Center(
                  child: Container(
                    width: widget.size * 0.35,
                    height: widget.size * 0.35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black87,
                        width: widget.size * 0.06,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.all(widget.size * 0.05),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [Colors.white, Colors.grey.shade200],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
