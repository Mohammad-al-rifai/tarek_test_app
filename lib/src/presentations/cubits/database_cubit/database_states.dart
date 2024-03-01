part of 'database_cubit.dart';

@immutable
abstract class DatabaseStates {}

class DatabaseInitialState extends DatabaseStates {}

// Creation States:
class CreateDatabaseDoneState extends DatabaseStates {}

class CreateTableDoneState extends DatabaseStates {}

class CreateTableErrorState extends DatabaseStates {}

// Add Employee States:

class AddEmployeeLoadingState extends DatabaseStates {}

class AddEmployeeDoneState extends DatabaseStates {}

class AddEmployeeErrorState extends DatabaseStates {}

// Get Employees States:

class GetEmployeesLoadingState extends DatabaseStates {}

class GetEmployeesDoneState extends DatabaseStates {}

class GetEmployeesErrorState extends DatabaseStates {}

// Delete Employees States:

class DeleteEmployeesLoadingState extends DatabaseStates {}

class DeleteEmployeesDoneState extends DatabaseStates {}

class DeleteEmployeesErrorState extends DatabaseStates {}


// Search Employees States:

class SearchEmployeesLoadingState extends DatabaseStates {}

class SearchEmployeesDoneState extends DatabaseStates {}

class SearchEmployeesErrorState extends DatabaseStates {}


// Employee Location States:

class GetEmployeesLocationLoadingState extends DatabaseStates {}

class GetEmployeesLocationDoneState extends DatabaseStates {}

class GetEmployeesLocationErrorState extends DatabaseStates {}


// Set City States:

class SetCityDoneState extends DatabaseStates {}