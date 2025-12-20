/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class Token extends _i1.SerializableEntity {
  Token({required this.tokenData});

  factory Token.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Token(
        tokenData: serializationManager
            .deserialize<String>(jsonSerialization['tokenData']));
  }

  String tokenData;

  @override
  Map<String, dynamic> toJson() {
    return {'tokenData': tokenData};
  }
}
