/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Question extends _i1.TableRow {
  Question({
    int? id,
    required this.domain_id,
    required this.level_id,
    required this.question,
    required this.question_category_id,
    required this.op1,
    required this.op2,
    required this.op3,
    required this.op4,
    required this.correct_op,
  }) : super(id);

  factory Question.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Question(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      domain_id:
          serializationManager.deserialize<int>(jsonSerialization['domain_id']),
      level_id:
          serializationManager.deserialize<int>(jsonSerialization['level_id']),
      question: serializationManager
          .deserialize<String>(jsonSerialization['question']),
      question_category_id: serializationManager
          .deserialize<int>(jsonSerialization['question_category_id']),
      op1: serializationManager.deserialize<String>(jsonSerialization['op1']),
      op2: serializationManager.deserialize<String>(jsonSerialization['op2']),
      op3: serializationManager.deserialize<String>(jsonSerialization['op3']),
      op4: serializationManager.deserialize<String>(jsonSerialization['op4']),
      correct_op: serializationManager
          .deserialize<String>(jsonSerialization['correct_op']),
    );
  }

  static final t = QuestionTable();

  int domain_id;

  int level_id;

  String question;

  int question_category_id;

  String op1;

  String op2;

  String op3;

  String op4;

  String correct_op;

  @override
  String get tableName => 'question';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'domain_id': domain_id,
      'level_id': level_id,
      'question': question,
      'question_category_id': question_category_id,
      'op1': op1,
      'op2': op2,
      'op3': op3,
      'op4': op4,
      'correct_op': correct_op,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'domain_id': domain_id,
      'level_id': level_id,
      'question': question,
      'question_category_id': question_category_id,
      'op1': op1,
      'op2': op2,
      'op3': op3,
      'op4': op4,
      'correct_op': correct_op,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'domain_id': domain_id,
      'level_id': level_id,
      'question': question,
      'question_category_id': question_category_id,
      'op1': op1,
      'op2': op2,
      'op3': op3,
      'op4': op4,
      'correct_op': correct_op,
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
      case 'level_id':
        level_id = value;
        return;
      case 'question':
        question = value;
        return;
      case 'question_category_id':
        question_category_id = value;
        return;
      case 'op1':
        op1 = value;
        return;
      case 'op2':
        op2 = value;
        return;
      case 'op3':
        op3 = value;
        return;
      case 'op4':
        op4 = value;
        return;
      case 'correct_op':
        correct_op = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Question>> find(
    _i1.Session session, {
    QuestionExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Question>(
      where: where != null ? where(Question.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Question?> findSingleRow(
    _i1.Session session, {
    QuestionExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Question>(
      where: where != null ? where(Question.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Question?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Question>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required QuestionExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Question>(
      where: where(Question.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    QuestionExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Question>(
      where: where != null ? where(Question.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef QuestionExpressionBuilder = _i1.Expression Function(QuestionTable);

class QuestionTable extends _i1.Table {
  QuestionTable() : super(tableName: 'question');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final domain_id = _i1.ColumnInt('domain_id');

  final level_id = _i1.ColumnInt('level_id');

  final question = _i1.ColumnString('question');

  final question_category_id = _i1.ColumnInt('question_category_id');

  final op1 = _i1.ColumnString('op1');

  final op2 = _i1.ColumnString('op2');

  final op3 = _i1.ColumnString('op3');

  final op4 = _i1.ColumnString('op4');

  final correct_op = _i1.ColumnString('correct_op');

  @override
  List<_i1.Column> get columns => [
        id,
        domain_id,
        level_id,
        question,
        question_category_id,
        op1,
        op2,
        op3,
        op4,
        correct_op,
      ];
}

@Deprecated('Use QuestionTable.t instead.')
QuestionTable tQuestion = QuestionTable();
