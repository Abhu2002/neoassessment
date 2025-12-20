/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class Exam extends _i1.SerializableEntity {
  Exam({
    this.id,
    required this.name,
    this.description,
    required this.domain_id,
    required this.no_of_questions,
    required this.level,
    this.question_ids,
    required this.passing_score,
  });

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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? description;

  int domain_id;

  int no_of_questions;

  int level;

  List<int>? question_ids;

  int passing_score;

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
}
