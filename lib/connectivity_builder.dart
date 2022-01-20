// Created By Amit Jangid on 20/01/22

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum Position { top, bottom }

class ConnectivityBuilder extends StatelessWidget {
  /// for background color of default offline widget
  final Color bgColor;

  /// for setting custom message of default offline widget
  final String message;

  /// for setting the position of default offline widget
  final Position position;

  /// for giving gradient effect to default offline widget
  final Gradient? gradient;

  /// for setting text style of default offline widget
  final TextStyle textStyle;

  /// for setting custom offline widget
  final Widget? offlineWidget;

  /// for disabling interaction of the widgets if user is not connected to internet
  final bool disableInteraction;

  /// for setting the alignment of message text inside of the default offline widget
  final AlignmentGeometry alignment;

  /// for building your own UI
  final Widget Function(bool isConnected) builder;

  const ConnectivityBuilder({
    Key? key,
    required this.builder,
    this.gradient,
    this.offlineWidget,
    this.bgColor = Colors.red,
    this.position = Position.bottom,
    this.disableInteraction = false,
    this.alignment = Alignment.center,
    this.message = 'Internet Connection not Available.',
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.white),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case ConnectivityResult.wifi:
          case ConnectivityResult.mobile:
            return builder(true);

          case ConnectivityResult.none:
          default:
            return Stack(
              children: [
                builder(false),
                disableInteraction
                    ? Column(
                        children: <Widget>[
                          Flexible(child: Container(decoration: const BoxDecoration(color: Colors.black38))),
                        ],
                      )
                    : const SizedBox.shrink(),
                offlineWidget ??
                    Positioned(
                      left: 0,
                      right: 0,
                      top: position == Position.top ? 0 : null,
                      bottom: position == Position.bottom ? 0 : null,
                      child: Container(
                        alignment: alignment,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: bgColor, gradient: gradient),
                        child: Text(message, style: textStyle),
                      ),
                    ),
              ],
            );
        }
      },
    );
  }
}
