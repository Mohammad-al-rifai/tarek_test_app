import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tarek_test_app/src/core/utils/functions.dart';
import 'package:tarek_test_app/src/data/models/employee_model.dart';
import 'package:path/path.dart';

import '../../../core/utils/dio_helper.dart';

part 'database_states.dart';

class DatabaseCubit extends Cubit<DatabaseStates> {
  DatabaseCubit() : super(DatabaseInitialState());

  static DatabaseCubit get(context) => BlocProvider.of(context);

  late Database database;

  TextEditingController city = TextEditingController();

  setCity(String newCity) {
    city.text = newCity;
    emit(SetCityDoneState());
  }

  Future<void> createDataBase() async {
    openDatabase(
      join(await getDatabasesPath(), 'tarek.db'),
      version: 1,
      onConfigure: (Database db) async {
        await db.execute('PRAGMA key = "Tarek_Task";');
      },
      onCreate: (Database database, int version) async {
        myPrint(text: 'Tarek database Created Successfully ❤❤');

        await database.execute('''
        CREATE TABLE employees (
          id INTEGER PRIMARY KEY,
          name TEXT,
          position TEXT,
          salary REAL,
          email TEXT,
          phoneNumber TEXT,
          address TEXT,
          department TEXT,
          photo TEXT
        )
      ''').then((value) {
          emit(CreateTableDoneState());
          myPrint(text: 'Table Created Successfully');
        }).catchError((error) {
          emit(CreateTableErrorState());
          myPrint(text: 'Error When Table Created ${error.toString()}');
        });
      },
      onOpen: (Database database) async {
        await getEmployees(database);
        myPrint(text: 'Database opened Successfully');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseDoneState());
    });
  }

  addEmployee({required Employee employee}) async {
    emit(AddEmployeeLoadingState());
    try {
      await database.transaction((txn) async {
        return await txn.insert(
          "employees",
          employee.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });

      emit(AddEmployeeDoneState());
      getEmployees(database);
    } catch (error) {
      emit(AddEmployeeErrorState());
    }
  }

// Get All Employees.
  List<Employee> employees = [];

  getEmployees(Database database) async {
    employees = [];
    emit(GetEmployeesLoadingState());

    await database
        .rawQuery(
      'SELECT * FROM employees',
    )
        .then((value) {
      for (var element in value) {
        employees.add(Employee.fromMap(element));
      }

      for (var e in employees) {
        myPrint(text: e.photo.toString());
      }

      emit(GetEmployeesDoneState());
    }).catchError((error) {
      myPrint(text: error.toString());
      emit(GetEmployeesErrorState());
    });
  }

  deleteEmployee({
    required int empId,
  }) async {
    emit(DeleteEmployeesLoadingState());

    await database.transaction((txn) {
      return txn.rawDelete(
        'DELETE FROM employees WHERE (id = ?)',
        [empId],
      );
    }).then((value) async {
      emit(DeleteEmployeesDoneState());
      getEmployees(database);
    }).catchError((error) {
      emit(DeleteEmployeesErrorState());
    });
  }

  // Search for employees by name or position
  Future<List<Employee>> searchEmployees(String searchTerm) async {
    emit(SearchEmployeesLoadingState());
    List<Map<String, dynamic>> result = [];
    await database.rawQuery(
      '''
      SELECT * FROM employees
      WHERE name LIKE ? OR position LIKE ?
      ''',
      ['%$searchTerm%', '%$searchTerm%'],
    ).then((value) {
      result = value;
      emit(SearchEmployeesDoneState());
    }).catchError((error) {
      emit(SearchEmployeesErrorState());
    });

    // Convert the List<Map<String, dynamic>> to List<Employee>
    List<Employee> employees =
        result.map((map) => Employee.fromMap(map)).toList();

    return employees;
  }

  convertPosToReality(myLocation) async {
    try {
      emit(GetEmployeesLocationLoadingState());
      final response = await DioHelper.instance.getData(
        url:
            'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${myLocation.latitude}&longitude=${myLocation.longitude}&localityLanguage=en',
      );
      String address =
          "${response.data['principalSubdivision']}-${response.data['localityInfo']['administrative'][2]['name']}";

      emit(GetEmployeesLocationDoneState());

      return address;
    } catch (err) {
      emit(GetEmployeesLocationErrorState());
    }
  }
}
