import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarek_test_app/src/core/utils/functions.dart';
import 'package:tarek_test_app/src/presentations/views/add_employee_view.dart';


class AddEmployeeWidget extends StatefulWidget {
  const AddEmployeeWidget({super.key});

  @override
  State<AddEmployeeWidget> createState() => _AddEmployeeWidgetState();
}

class _AddEmployeeWidgetState extends State<AddEmployeeWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      mini: false,
      onPressed: () {



        navigateTo(context, const AddEmployeeView());
      },
      child: const Icon(
        CupertinoIcons.add,
        color: Colors.black,
      ),
    );
  }
}
