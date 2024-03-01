import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarek_test_app/src/core/utils/functions.dart';
import 'package:tarek_test_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:tarek_test_app/src/presentations/views/search_view.dart';
import 'package:tarek_test_app/src/presentations/widgets/employee_widget.dart';

import '../widgets/add_employee_widget.dart';

class EmployeeView extends StatefulWidget {
  const EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
      floatingActionButton: const AddEmployeeWidget(),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      title: const Text('Employees'),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12.0),
          child: IconButton(
            onPressed: () => navigateTo(context, const SearchView()),
            icon: const Icon(
              CupertinoIcons.search,
              size: 30.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget getBody() {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return EmployeeWidget(employee: cubit.employees[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox();
          },
          itemCount: cubit.employees.length,
        );
      },
    );
  }
}
