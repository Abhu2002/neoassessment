/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class QuestionCategory extends _i1.SerializableEntity {
  QuestionCategory({
    this.id,
    required this.domain_id,
    required this.name,
    this.description,
  });

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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int domain_id;

  String name;

  String? description;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'domain_id': domain_id,
      'name': name,
      'description': description,
    };
  }
}
