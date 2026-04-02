import 'package:finflow_app/core/database/app_database.dart';
import 'package:finflow_app/core/database/daos/categories_dao.dart';
import 'package:finflow_app/features/categories/domain/category.dart';

class CategoriesRepository {
  final CategoriesDao _dao;

  CategoriesRepository(this._dao);

  Stream<List<Category>> watchAll() {
    return _dao.watchAllCategories().map(
      (rows) => rows.map(_toEntity).toList(),
    );
  }

  Future<void> add({
    required String name,
    required String icon,
    required int color,
  }) {
    return _dao.insertCategory(
      CategoriesTableCompanion.insert(name: name, icon: icon, color: color),
    );
  }

  Future<void> delete(String id) {
    return _dao.deleteCategory(int.parse(id));
  }

  static Category _toEntity(CategoriesTableData row) {
    return Category(
      id: row.id.toString(),
      name: row.name,
      icon: row.icon,
      color: row.color,
      isDefault: row.isDefault,
    );
  }
}
