/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class Candidate extends _i1.SerializableEntity {
  Candidate({
    this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    this.dob,
    required this.domain_id,
    required this.experience,
    required this.password,
    this.access_token,
    this.phone,
  });

  factory Candidate.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Candidate(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      first_name: serializationManager
          .deserialize<String>(jsonSerialization['first_name']),
      last_name: serializationManager
          .deserialize<String>(jsonSerialization['last_name']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      dob:
          serializationManager.deserialize<DateTime?>(jsonSerialization['dob']),
      domain_id:
          serializationManager.deserialize<int>(jsonSerialization['domain_id']),
      experience: serializationManager
          .deserialize<int>(jsonSerialization['experience']),
      password: serializationManager
          .deserialize<String>(jsonSerialization['password']),
      access_token: serializationManager
          .deserialize<String?>(jsonSerialization['access_token']),
      phone:
          serializationManager.deserialize<String?>(jsonSerialization['phone']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String first_name;

  String last_name;

  String email;

  DateTime? dob;

  int domain_id;

  int experience;

  String password;

  String? access_token;

  String? phone;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'dob': dob,
      'domain_id': domain_id,
      'experience': experience,
      'password': password,
      'access_token': access_token,
      'phone': phone,
    };
  }
}
