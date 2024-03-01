import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:tarek_test_app/src/data/models/employee_model.dart';

import '../../core/utils/functions.dart';
import '../views/employee_details_view.dart';

class EmployeeWidget extends StatelessWidget {
  const EmployeeWidget({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64.decode(employee.photo ?? '');
    return InkWell(
      onTap: () => navigateTo(context, EmployeeDetailsView(employee: employee)),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.all(12.0),
            padding: const EdgeInsetsDirectional.all(12.0),
            width: double.infinity,
            height: 250.0,
            decoration: getDeco(),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Hero(
                  tag: employee.name ?? '',
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.contain,
                    height: 220.0,
                    width: double.infinity,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${employee.name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            '${employee.position}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${employee.salary}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(' AED'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                await FlutterPhoneDirectCaller.callNumber(
                    '${employee.phoneNumber}');
              },
              icon: const Icon(
                CupertinoIcons.phone,
                size: 30.0,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
