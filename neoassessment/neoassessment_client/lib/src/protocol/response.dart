/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class Response extends _i1.SerializableEntity {
  Response({
    this.id,
    required this.candidate_id,
    required this.exam_id,
    this.score,
    this.assign_by,
    this.reviewed_by,
    required this.q_ids,
    required this.response,
    this.status,
  });

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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int candidate_id;

  int exam_id;

  int? score;

  int? assign_by;

  int? reviewed_by;

  List<int> q_ids;

  List<String> response;

  int? status;

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
}
