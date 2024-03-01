import 'package:flutter/cupertino.dart';

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return getChild();
  }

  Widget getChild() {
    return const SizedBox(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
