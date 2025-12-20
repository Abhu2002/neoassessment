/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class Question extends _i1.SerializableEntity {
  Question({
    this.id,
    required this.domain_id,
    required this.level_id,
    required this.question,
    required this.question_category_id,
    required this.op1,
    required this.op2,
    required this.op3,
    required this.op4,
    required this.correct_op,
  });

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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

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
}
