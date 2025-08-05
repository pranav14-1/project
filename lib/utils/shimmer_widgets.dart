import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Core shimmer wrapper – gives the classic moving highlight effect.
/// You can wrap any widget with `Shimmer.fromColors`, but these helpers
/// make common skeleton shapes quick to drop in.
class ShimmerLoader extends StatelessWidget {
  final Widget child;
  final Duration period;

  const ShimmerLoader({
    super.key,
    required this.child,
    this.period = const Duration(milliseconds: 1500),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: period,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}

/// A simple rectangular skeleton – useful for cards, list rows, etc.
class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// Circular skeleton – perfect for avatars or icon placeholders.
class ShimmerCircle extends StatelessWidget {
  final double size;

  const ShimmerCircle({super.key, this.size = 48});

  @override
  Widget build(BuildContext context) => ShimmerBox(
        height: size,
        width: size,
        borderRadius: BorderRadius.circular(size / 2),
      );
}

/// Convenience skeleton that mimics a ListTile (avatar + two lines).
class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ShimmerCircle(size: 40),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmerBox(height: 12, width: double.infinity),
              SizedBox(height: 6),
              ShimmerBox(height: 10, width: 140),
            ],
          ),
        ),
      ],
    );
  }
}
