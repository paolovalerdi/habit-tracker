import 'dart:ui';

import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  const Toolbar({
    Key? key,
    this.leading,
    this.title,
    this.actions,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: Material(
          color: Colors.white.withOpacity(0.85),
          child: Builder(
            builder: (context) {
              final styles = Theme.of(context).textTheme;
              return DefaultTextStyle(
                style: styles.headline6!.copyWith(color: Colors.black),
                child: SafeArea(
                  child: SizedBox(
                    height: preferredSize.height,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (leading != null)
                          Positioned(
                            left: 4,
                            child: leading!,
                          ),
                        if (title != null) title!,
                        if (actions != null)
                          Positioned(
                            right: 4,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: actions!,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
