import 'package:flutter/material.dart';

class ScrollableItemsList extends StatelessWidget {
  final int itemCount;
  final double width;
  final double height;
  final double itemHeight;

  const ScrollableItemsList({
    super.key,
    this.itemCount = 10,
    this.width = 360,
    this.height = 320,
    this.itemHeight = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: itemCount,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
            color: Colors.white,
          ),
          itemBuilder: (context, index) {
            return SizedBox(
              height: itemHeight,
              child: const Center(
                child: Icon(
                  Icons.article_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 