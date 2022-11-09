import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget toSliver() {
    return SliverToBoxAdapter(
      child: this,
    );
  }
}
