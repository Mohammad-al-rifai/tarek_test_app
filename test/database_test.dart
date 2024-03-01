import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tarek_test_app/src/presentations/cubits/database_cubit/database_cubit.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  group('DatabaseCubit', () {
    late DatabaseCubit databaseCubit;
    late MockDatabase mockDatabase;

    setUp(() {
      mockDatabase = MockDatabase();
      databaseCubit = DatabaseCubit();
    });

    test('createDataBase - success', () async {
      when(openDatabase(
        join(await getDatabasesPath(), 'tarek.db'), // Use the full path here
        version: anyNamed('version'),
        onConfigure: anyNamed('onConfigure'),
        onCreate: anyNamed('onCreate'),
        onOpen: anyNamed('onOpen'),
      )).thenAnswer((_) => Future.value(mockDatabase));

      when(mockDatabase.execute('tarek.db')).thenAnswer((_) => Future.value());

      when(databaseCubit.getEmployees(mockDatabase))
          .thenAnswer((_) => Future.value());

      await databaseCubit.createDataBase();

      verify(openDatabase(
        join(await getDatabasesPath(), 'tarek.db'), // Use the full path here
        version: 1,
        onConfigure: anyNamed('onConfigure'),
        onCreate: anyNamed('onCreate'),
        onOpen: anyNamed('onOpen'),
      )).called(1);
      verify(mockDatabase.execute('tarek.db')).called(1);
      verify(databaseCubit.getEmployees(mockDatabase)).called(1);

      expect(databaseCubit.state, isA<CreateDatabaseDoneState>());
    });

    tearDown(() {
      databaseCubit.close();
    });
  });
}
