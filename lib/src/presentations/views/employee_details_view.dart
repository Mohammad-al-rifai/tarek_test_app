import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarek_test_app/src/core/utils/functions.dart';
import 'package:tarek_test_app/src/data/models/employee_model.dart';
import 'package:tarek_test_app/src/presentations/component/button.dart';
import 'package:tarek_test_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/pair_widget.dart';

class EmployeeDetailsView extends StatefulWidget {
  const EmployeeDetailsView({super.key, required this.employee});

  final Employee employee;

  @override
  State<EmployeeDetailsView> createState() => _EmployeeDetailsViewState();
}

class _EmployeeDetailsViewState extends State<EmployeeDetailsView> {
  late Uint8List bytes;

  @override
  void initState() {
    bytes = base64.decode(widget.employee.photo ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {
        if (state is DeleteEmployeesDoneState) {
          popScreen(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                getMainImage(),
                getDetailsWidget(),
                getSaveContactWidget(),
                getDeleteWidget(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getMainImage() {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Hero(
          tag: widget.employee.name ?? '',
          child: Image.memory(
            bytes,
            fit: BoxFit.contain,
            height: 220.0,
            width: double.infinity,
          ),
        ),
        IconButton(
          onPressed: () {
            popScreen(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        )
      ],
    );
  }

  Widget getDetailsWidget() {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.all(12.0),
          margin: const EdgeInsetsDirectional.all(12.0),
          decoration: getDeco(),
          child: Column(
            children: [
              PairWidget(
                label: 'Full name',
                value: '${widget.employee.name}',
              ),
              PairWidget(
                label: 'Position',
                value: '${widget.employee.position}',
              ),
              PairWidget(
                label: 'Salary',
                value: '${widget.employee.salary}',
              ),
              PairWidget(
                label: 'E-mail',
                value: '${widget.employee.email}',
              ),
              PairWidget(
                label: 'Phone',
                value: '${widget.employee.phoneNumber}',
              ),
              PairWidget(
                label: 'Address',
                value: '${widget.employee.address}',
              ),
              PairWidget(
                label: 'Department',
                value: '${widget.employee.department}',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: () {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: widget.employee.email,
                query: encodeQueryParameters(<String, String>{
                  'subject': 'This is Mohammad AlRifai.dev',
                }),
              );

              launchUrl(emailLaunchUri);
            },
            icon: const Icon(
              CupertinoIcons.mail,
              size: 30.0,
              color: Colors.green,
            ),
          ),
        )
      ],
    );
  }

  Widget getDeleteWidget() {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: DefaultButton(
            function: () {
              cubit.deleteEmployee(empId: widget.employee.id ?? 1);
            },
            text: 'Delete',
            background: Colors.red,
            isLoading: state is DeleteEmployeesLoadingState,
          ),
        );
      },
    );
  }

  Widget getSaveContactWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DefaultButton(
        function: () async {},
        text: 'Save Contact',
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
