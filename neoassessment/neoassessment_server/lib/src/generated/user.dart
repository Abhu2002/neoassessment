/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class User extends _i1.TableRow {
  User({
    int? id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.domain_id,
    required this.role_id,
    required this.experience,
    required this.password,
    this.access_token,
  }) : super(id);

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      first_name: serializationManager
          .deserialize<String>(jsonSerialization['first_name']),
      last_name: serializationManager
          .deserialize<String>(jsonSerialization['last_name']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      phone:
          serializationManager.deserialize<String>(jsonSerialization['phone']),
      dob: serializationManager.deserialize<DateTime>(jsonSerialization['dob']),
      domain_id:
          serializationManager.deserialize<int>(jsonSerialization['domain_id']),
      role_id:
          serializationManager.deserialize<int>(jsonSerialization['role_id']),
      experience: serializationManager
          .deserialize<int>(jsonSerialization['experience']),
      password: serializationManager
          .deserialize<String>(jsonSerialization['password']),
      access_token: serializationManager
          .deserialize<String?>(jsonSerialization['access_token']),
    );
  }

  static final t = UserTable();

  String first_name;

  String last_name;

  String email;

  String phone;

  DateTime dob;

  int domain_id;

  int role_id;

  int experience;

  String password;

  String? access_token;

  @override
  String get tableName => 'users';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'dob': dob,
      'domain_id': domain_id,
      'role_id': role_id,
      'experience': experience,
      'password': password,
      'access_token': access_token,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'dob': dob,
      'domain_id': domain_id,
      'role_id': role_id,
      'experience': experience,
      'password': password,
      'access_token': access_token,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'dob': dob,
      'domain_id': domain_id,
      'role_id': role_id,
      'experience': experience,
      'password': password,
      'access_token': access_token,
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
      case 'first_name':
        first_name = value;
        return;
      case 'last_name':
        last_name = value;
        return;
      case 'email':
        email = value;
        return;
      case 'phone':
        phone = value;
        return;
      case 'dob':
        dob = value;
        return;
      case 'domain_id':
        domain_id = value;
        return;
      case 'role_id':
        role_id = value;
        return;
      case 'experience':
        experience = value;
        return;
      case 'password':
        password = value;
        return;
      case 'access_token':
        access_token = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<User>> find(
    _i1.Session session, {
    UserExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<User>(
      where: where != null ? where(User.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<User?> findSingleRow(
    _i1.Session session, {
    UserExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<User>(
      where: where != null ? where(User.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<User?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<User>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required UserExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    UserExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where != null ? where(User.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef UserExpressionBuilder = _i1.Expression Function(UserTable);

class UserTable extends _i1.Table {
  UserTable() : super(tableName: 'users');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final first_name = _i1.ColumnString('first_name');

  final last_name = _i1.ColumnString('last_name');

  final email = _i1.ColumnString('email');

  final phone = _i1.ColumnString('phone');

  final dob = _i1.ColumnDateTime('dob');

  final domain_id = _i1.ColumnInt('domain_id');

  final role_id = _i1.ColumnInt('role_id');

  final experience = _i1.ColumnInt('experience');

  final password = _i1.ColumnString('password');

  final access_token = _i1.ColumnString('access_token');

  @override
  List<_i1.Column> get columns => [
        id,
        first_name,
        last_name,
        email,
        phone,
        dob,
        domain_id,
        role_id,
        experience,
        password,
        access_token,
      ];
}

@Deprecated('Use UserTable.t instead.')
UserTable tUser = UserTable();
