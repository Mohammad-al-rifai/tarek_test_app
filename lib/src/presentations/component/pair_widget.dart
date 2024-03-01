import 'package:flutter/material.dart';

class PairWidget extends StatelessWidget {
  const PairWidget({
    super.key,
    required this.label,
    required this.value,
    this.withDivider = true,
  });

  final String? label;
  final String? value;
  final bool withDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label ?? '',
              maxLines: 2,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          (withDivider)
              ? Container(
                  margin: const EdgeInsetsDirectional.only(
                    start: 4,
                    end: 8,
                  ),
                  width: 2.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadiusDirectional.circular(4),
                  ),
                )
              : const SizedBox(),
          Expanded(
            flex: 3,
            child: Text(
              value ?? '',
              maxLines: 5,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
