import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarek_test_app/src/presentations/component/text_form_field.dart';
import 'package:tarek_test_app/src/presentations/cubits/database_cubit/database_cubit.dart';

import '../../data/models/employee_model.dart';
import '../widgets/employee_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();

  List<Employee> employees = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TFF(
                  controller: searchController,
                  label: 'Search',
                  prefixIcon: CupertinoIcons.search,
                  validator: (String value) {},
                  onChanged: (String value) async {
                    setState(() async {
                      employees = await cubit.searchEmployees(value);
                    });
                  },
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return EmployeeWidget(employee: employees[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: employees.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
