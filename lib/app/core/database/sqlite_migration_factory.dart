import 'package:todo_list/app/core/database/migrations/migration_v1.dart';
import 'package:todo_list/app/core/database/migrations/migrations.dart';

class SqliteMigrationFactory {
  List<Migrations> getCreateMigration() => [
        MigrationV1(),
      ];

  List<Migrations> getUpgradeMigration(int version) => [];
}
