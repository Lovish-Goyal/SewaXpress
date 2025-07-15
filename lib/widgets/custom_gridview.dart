import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final List<dynamic> list;
  final Widget Function(dynamic item) itemBuilder;

  const CustomGridView({
    super.key,
    required this.list,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final item = list[index];
            return itemBuilder(item);
          },
        ),
      ),
    );
  }
}
