/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Response extends _i1.TableRow {
  Response({
    int? id,
    required this.candidate_id,
    required this.exam_id,
    this.score,
    this.assign_by,
    this.reviewed_by,
    required this.q_ids,
    required this.response,
    this.status,
  }) : super(id);

  factory Response.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Response(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      candidate_id: serializationManager
          .deserialize<int>(jsonSerialization['candidate_id']),
      exam_id:
          serializationManager.deserialize<int>(jsonSerialization['exam_id']),
      score: serializationManager.deserialize<int?>(jsonSerialization['score']),
      assign_by: serializationManager
          .deserialize<int?>(jsonSerialization['assign_by']),
      reviewed_by: serializationManager
          .deserialize<int?>(jsonSerialization['reviewed_by']),
      q_ids: serializationManager
          .deserialize<List<int>>(jsonSerialization['q_ids']),
      response: serializationManager
          .deserialize<List<String>>(jsonSerialization['response']),
      status:
          serializationManager.deserialize<int?>(jsonSerialization['status']),
    );
  }

  static final t = ResponseTable();

  int candidate_id;

  int exam_id;

  int? score;

  int? assign_by;

  int? reviewed_by;

  List<int> q_ids;

  List<String> response;

  int? status;

  @override
  String get tableName => 'responses';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'candidate_id': candidate_id,
      'exam_id': exam_id,
      'score': score,
      'assign_by': assign_by,
      'reviewed_by': reviewed_by,
      'q_ids': q_ids,
      'response': response,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'candidate_id': candidate_id,
      'exam_id': exam_id,
      'score': score,
      'assign_by': assign_by,
      'reviewed_by': reviewed_by,
      'q_ids': q_ids,
      'response': response,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'candidate_id': candidate_id,
      'exam_id': exam_id,
      'score': score,
      'assign_by': assign_by,
      'reviewed_by': reviewed_by,
      'q_ids': q_ids,
      'response': response,
      'status': status,
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
      case 'candidate_id':
        candidate_id = value;
        return;
      case 'exam_id':
        exam_id = value;
        return;
      case 'score':
        score = value;
        return;
      case 'assign_by':
        assign_by = value;
        return;
      case 'reviewed_by':
        reviewed_by = value;
        return;
      case 'q_ids':
        q_ids = value;
        return;
      case 'response':
        response = value;
        return;
      case 'status':
        status = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Response>> find(
    _i1.Session session, {
    ResponseExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Response>(
      where: where != null ? where(Response.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Response?> findSingleRow(
    _i1.Session session, {
    ResponseExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Response>(
      where: where != null ? where(Response.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Response?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Response>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required ResponseExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Response>(
      where: where(Response.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Response row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Response row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Response row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    ResponseExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Response>(
      where: where != null ? where(Response.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef ResponseExpressionBuilder = _i1.Expression Function(ResponseTable);

class ResponseTable extends _i1.Table {
  ResponseTable() : super(tableName: 'responses');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final candidate_id = _i1.ColumnInt('candidate_id');

  final exam_id = _i1.ColumnInt('exam_id');

  final score = _i1.ColumnInt('score');

  final assign_by = _i1.ColumnInt('assign_by');

  final reviewed_by = _i1.ColumnInt('reviewed_by');

  final q_ids = _i1.ColumnSerializable('q_ids');

  final response = _i1.ColumnSerializable('response');

  final status = _i1.ColumnInt('status');

  @override
  List<_i1.Column> get columns => [
        id,
        candidate_id,
        exam_id,
        score,
        assign_by,
        reviewed_by,
        q_ids,
        response,
        status,
      ];
}

@Deprecated('Use ResponseTable.t instead.')
ResponseTable tResponse = ResponseTable();
