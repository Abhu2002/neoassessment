/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class QuestionCategory extends _i1.TableRow {
  QuestionCategory({
    int? id,
    required this.domain_id,
    required this.name,
    this.description,
  }) : super(id);

  factory QuestionCategory.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return QuestionCategory(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      domain_id:
          serializationManager.deserialize<int>(jsonSerialization['domain_id']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      description: serializationManager
          .deserialize<String?>(jsonSerialization['description']),
    );
  }

  static final t = QuestionCategoryTable();

  int domain_id;

  String name;

  String? description;

  @override
  String get tableName => 'questioncategory';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'domain_id': domain_id,
      'name': name,
      'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'domain_id': domain_id,
      'name': name,
      'description': description,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'domain_id': domain_id,
      'name': name,
      'description': description,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'domain_id':
        domain_id = value;
        return;
      case 'name':
        name = value;
        return;
      case 'description':
        description = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<QuestionCategory>> find(
    _i1.Session session, {
    QuestionCategoryExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<QuestionCategory>(
      where: where != null ? where(QuestionCategory.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<QuestionCategory?> findSingleRow(
    _i1.Session session, {
    QuestionCategoryExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<QuestionCategory>(
      where: where != null ? where(QuestionCategory.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<QuestionCategory?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<QuestionCategory>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required QuestionCategoryExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QuestionCategory>(
      where: where(QuestionCategory.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    QuestionCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    QuestionCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    QuestionCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    QuestionCategoryExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QuestionCategory>(
      where: where != null ? where(QuestionCategory.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef QuestionCategoryExpressionBuilder = _i1.Expression Function(
    QuestionCategoryTable);

class QuestionCategoryTable extends _i1.Table {
  QuestionCategoryTable() : super(tableName: 'questioncategory');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final domain_id = _i1.ColumnInt('domain_id');

  final name = _i1.ColumnString('name');

  final description = _i1.ColumnString('description');

  @override
  List<_i1.Column> get columns => [
        id,
        domain_id,
        name,
        description,
      ];
}

@Deprecated('Use QuestionCategoryTable.t instead.')
QuestionCategoryTable tQuestionCategory = QuestionCategoryTable();
