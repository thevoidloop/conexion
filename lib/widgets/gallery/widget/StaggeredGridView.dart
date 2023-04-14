import 'package:flutter/material.dart';

class StaggeredGridView extends StatelessWidget {
  const StaggeredGridView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 0.0,
    this.aspectRatio = 0.5,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspectRatio;
      final height = constraints.maxHeight + itemHeight;

      return OverflowBox(
        maxHeight: height,
        minHeight: height,
        maxWidth: width,
        minWidth: width,
        child: GridView.builder(
          padding: EdgeInsets.only(top: itemHeight * 0.5, bottom: itemHeight),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemBuilder: (context, index) {
            return Transform.translate(
              offset: Offset(0.0, index.isOdd ? (itemHeight * 0.5) : 0.0),
              child: itemBuilder(context, index),
            );
          }),
        );
      }
    );
  }
}