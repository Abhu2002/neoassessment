/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'candidate.dart' as _i2;
import 'domain.dart' as _i3;
import 'exam.dart' as _i4;
import 'example.dart' as _i5;
import 'level.dart' as _i6;
import 'question.dart' as _i7;
import 'questionCategory.dart' as _i8;
import 'response.dart' as _i9;
import 'role.dart' as _i10;
import 'status.dart' as _i11;
import 'token.dart' as _i12;
import 'user.dart' as _i13;
export 'candidate.dart';
export 'domain.dart';
export 'exam.dart';
export 'example.dart';
export 'level.dart';
export 'question.dart';
export 'questionCategory.dart';
export 'response.dart';
export 'role.dart';
export 'status.dart';
export 'token.dart';
export 'user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.Candidate) {
      return _i2.Candidate.fromJson(data, this) as T;
    }
    if (t == _i3.Domain) {
      return _i3.Domain.fromJson(data, this) as T;
    }
    if (t == _i4.Exam) {
      return _i4.Exam.fromJson(data, this) as T;
    }
    if (t == _i5.Example) {
      return _i5.Example.fromJson(data, this) as T;
    }
    if (t == _i6.Level) {
      return _i6.Level.fromJson(data, this) as T;
    }
    if (t == _i7.Question) {
      return _i7.Question.fromJson(data, this) as T;
    }
    if (t == _i8.QuestionCategory) {
      return _i8.QuestionCategory.fromJson(data, this) as T;
    }
    if (t == _i9.Response) {
      return _i9.Response.fromJson(data, this) as T;
    }
    if (t == _i10.Role) {
      return _i10.Role.fromJson(data, this) as T;
    }
    if (t == _i11.Status) {
      return _i11.Status.fromJson(data, this) as T;
    }
    if (t == _i12.Token) {
      return _i12.Token.fromJson(data, this) as T;
    }
    if (t == _i13.User) {
      return _i13.User.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Candidate?>()) {
      return (data != null ? _i2.Candidate.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.Domain?>()) {
      return (data != null ? _i3.Domain.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.Exam?>()) {
      return (data != null ? _i4.Exam.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.Example?>()) {
      return (data != null ? _i5.Example.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.Level?>()) {
      return (data != null ? _i6.Level.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.Question?>()) {
      return (data != null ? _i7.Question.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.QuestionCategory?>()) {
      return (data != null ? _i8.QuestionCategory.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i9.Response?>()) {
      return (data != null ? _i9.Response.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i10.Role?>()) {
      return (data != null ? _i10.Role.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i11.Status?>()) {
      return (data != null ? _i11.Status.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i12.Token?>()) {
      return (data != null ? _i12.Token.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i13.User?>()) {
      return (data != null ? _i13.User.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as dynamic;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList()
          as dynamic;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i2.Candidate) {
      return 'Candidate';
    }
    if (data is _i3.Domain) {
      return 'Domain';
    }
    if (data is _i4.Exam) {
      return 'Exam';
    }
    if (data is _i5.Example) {
      return 'Example';
    }
    if (data is _i6.Level) {
      return 'Level';
    }
    if (data is _i7.Question) {
      return 'Question';
    }
    if (data is _i8.QuestionCategory) {
      return 'QuestionCategory';
    }
    if (data is _i9.Response) {
      return 'Response';
    }
    if (data is _i10.Role) {
      return 'Role';
    }
    if (data is _i11.Status) {
      return 'Status';
    }
    if (data is _i12.Token) {
      return 'Token';
    }
    if (data is _i13.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Candidate') {
      return deserialize<_i2.Candidate>(data['data']);
    }
    if (data['className'] == 'Domain') {
      return deserialize<_i3.Domain>(data['data']);
    }
    if (data['className'] == 'Exam') {
      return deserialize<_i4.Exam>(data['data']);
    }
    if (data['className'] == 'Example') {
      return deserialize<_i5.Example>(data['data']);
    }
    if (data['className'] == 'Level') {
      return deserialize<_i6.Level>(data['data']);
    }
    if (data['className'] == 'Question') {
      return deserialize<_i7.Question>(data['data']);
    }
    if (data['className'] == 'QuestionCategory') {
      return deserialize<_i8.QuestionCategory>(data['data']);
    }
    if (data['className'] == 'Response') {
      return deserialize<_i9.Response>(data['data']);
    }
    if (data['className'] == 'Role') {
      return deserialize<_i10.Role>(data['data']);
    }
    if (data['className'] == 'Status') {
      return deserialize<_i11.Status>(data['data']);
    }
    if (data['className'] == 'Token') {
      return deserialize<_i12.Token>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i13.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
