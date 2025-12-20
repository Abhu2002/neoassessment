/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Exam extends _i1.TableRow {
  Exam({
    int? id,
    required this.name,
    this.description,
    required this.domain_id,
    required this.no_of_questions,
    required this.level,
    this.question_ids,
    required this.passing_score,
  }) : super(id);

  factory Exam.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Exam(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      description: serializationManager
          .deserialize<String?>(jsonSerialization['description']),
      domain_id:
          serializationManager.deserialize<int>(jsonSerialization['domain_id']),
      no_of_questions: serializationManager
          .deserialize<int>(jsonSerialization['no_of_questions']),
      level: serializationManager.deserialize<int>(jsonSerialization['level']),
      question_ids: serializationManager
          .deserialize<List<int>?>(jsonSerialization['question_ids']),
      passing_score: serializationManager
          .deserialize<int>(jsonSerialization['passing_score']),
    );
  }

  static final t = ExamTable();

  String name;

  String? description;

  int domain_id;

  int no_of_questions;

  int level;

  List<int>? question_ids;

  int passing_score;

  @override
  String get tableName => 'exams';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'domain_id': domain_id,
      'no_of_questions': no_of_questions,
      'level': level,
      'question_ids': question_ids,
      'passing_score': passing_score,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'domain_id': domain_id,
      'no_of_questions': no_of_questions,
      'level': level,
      'question_ids': question_ids,
      'passing_score': passing_score,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'domain_id': domain_id,
      'no_of_questions': no_of_questions,
      'level': level,
      'question_ids': question_ids,
      'passing_score': passing_score,
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
      case 'name':
        name = value;
        return;
      case 'description':
        description = value;
        return;
      case 'domain_id':
        domain_id = value;
        return;
      case 'no_of_questions':
        no_of_questions = value;
        return;
      case 'level':
        level = value;
        return;
      case 'question_ids':
        question_ids = value;
        return;
      case 'passing_score':
        passing_score = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Exam>> find(
    _i1.Session session, {
    ExamExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Exam>(
      where: where != null ? where(Exam.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Exam?> findSingleRow(
    _i1.Session session, {
    ExamExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Exam>(
      where: where != null ? where(Exam.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Exam?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Exam>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required ExamExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Exam>(
      where: where(Exam.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Exam row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Exam row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Exam row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    ExamExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Exam>(
      where: where != null ? where(Exam.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef ExamExpressionBuilder = _i1.Expression Function(ExamTable);

class ExamTable extends _i1.Table {
  ExamTable() : super(tableName: 'exams');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final name = _i1.ColumnString('name');

  final description = _i1.ColumnString('description');

  final domain_id = _i1.ColumnInt('domain_id');

  final no_of_questions = _i1.ColumnInt('no_of_questions');

  final level = _i1.ColumnInt('level');

  final question_ids = _i1.ColumnSerializable('question_ids');

  final passing_score = _i1.ColumnInt('passing_score');

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        domain_id,
        no_of_questions,
        level,
        question_ids,
        passing_score,
      ];
}

@Deprecated('Use ExamTable.t instead.')
ExamTable tExam = ExamTable();
