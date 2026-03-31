// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringPayment {

 String get id; String get name; double get amount; TransactionType get type; String get categoryId; String get accountId; RecurrenceFrequency get frequency; DateTime get startDate; DateTime? get endDate; int? get customDays;
/// Create a copy of RecurringPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringPaymentCopyWith<RecurringPayment> get copyWith => _$RecurringPaymentCopyWithImpl<RecurringPayment>(this as RecurringPayment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.customDays, customDays) || other.customDays == customDays));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,amount,type,categoryId,accountId,frequency,startDate,endDate,customDays);

@override
String toString() {
  return 'RecurringPayment(id: $id, name: $name, amount: $amount, type: $type, categoryId: $categoryId, accountId: $accountId, frequency: $frequency, startDate: $startDate, endDate: $endDate, customDays: $customDays)';
}


}

/// @nodoc
abstract mixin class $RecurringPaymentCopyWith<$Res>  {
  factory $RecurringPaymentCopyWith(RecurringPayment value, $Res Function(RecurringPayment) _then) = _$RecurringPaymentCopyWithImpl;
@useResult
$Res call({
 String id, String name, double amount, TransactionType type, String categoryId, String accountId, RecurrenceFrequency frequency, DateTime startDate, DateTime? endDate, int? customDays
});




}
/// @nodoc
class _$RecurringPaymentCopyWithImpl<$Res>
    implements $RecurringPaymentCopyWith<$Res> {
  _$RecurringPaymentCopyWithImpl(this._self, this._then);

  final RecurringPayment _self;
  final $Res Function(RecurringPayment) _then;

/// Create a copy of RecurringPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? type = null,Object? categoryId = null,Object? accountId = null,Object? frequency = null,Object? startDate = null,Object? endDate = freezed,Object? customDays = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,customDays: freezed == customDays ? _self.customDays : customDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringPayment].
extension RecurringPaymentPatterns on RecurringPayment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringPayment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringPayment value)  $default,){
final _that = this;
switch (_that) {
case _RecurringPayment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringPayment value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringPayment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double amount,  TransactionType type,  String categoryId,  String accountId,  RecurrenceFrequency frequency,  DateTime startDate,  DateTime? endDate,  int? customDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringPayment() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.type,_that.categoryId,_that.accountId,_that.frequency,_that.startDate,_that.endDate,_that.customDays);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double amount,  TransactionType type,  String categoryId,  String accountId,  RecurrenceFrequency frequency,  DateTime startDate,  DateTime? endDate,  int? customDays)  $default,) {final _that = this;
switch (_that) {
case _RecurringPayment():
return $default(_that.id,_that.name,_that.amount,_that.type,_that.categoryId,_that.accountId,_that.frequency,_that.startDate,_that.endDate,_that.customDays);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double amount,  TransactionType type,  String categoryId,  String accountId,  RecurrenceFrequency frequency,  DateTime startDate,  DateTime? endDate,  int? customDays)?  $default,) {final _that = this;
switch (_that) {
case _RecurringPayment() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.type,_that.categoryId,_that.accountId,_that.frequency,_that.startDate,_that.endDate,_that.customDays);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringPayment implements RecurringPayment {
  const _RecurringPayment({required this.id, required this.name, required this.amount, required this.type, required this.categoryId, required this.accountId, required this.frequency, required this.startDate, this.endDate, this.customDays});
  

@override final  String id;
@override final  String name;
@override final  double amount;
@override final  TransactionType type;
@override final  String categoryId;
@override final  String accountId;
@override final  RecurrenceFrequency frequency;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  int? customDays;

/// Create a copy of RecurringPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringPaymentCopyWith<_RecurringPayment> get copyWith => __$RecurringPaymentCopyWithImpl<_RecurringPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.customDays, customDays) || other.customDays == customDays));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,amount,type,categoryId,accountId,frequency,startDate,endDate,customDays);

@override
String toString() {
  return 'RecurringPayment(id: $id, name: $name, amount: $amount, type: $type, categoryId: $categoryId, accountId: $accountId, frequency: $frequency, startDate: $startDate, endDate: $endDate, customDays: $customDays)';
}


}

/// @nodoc
abstract mixin class _$RecurringPaymentCopyWith<$Res> implements $RecurringPaymentCopyWith<$Res> {
  factory _$RecurringPaymentCopyWith(_RecurringPayment value, $Res Function(_RecurringPayment) _then) = __$RecurringPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double amount, TransactionType type, String categoryId, String accountId, RecurrenceFrequency frequency, DateTime startDate, DateTime? endDate, int? customDays
});




}
/// @nodoc
class __$RecurringPaymentCopyWithImpl<$Res>
    implements _$RecurringPaymentCopyWith<$Res> {
  __$RecurringPaymentCopyWithImpl(this._self, this._then);

  final _RecurringPayment _self;
  final $Res Function(_RecurringPayment) _then;

/// Create a copy of RecurringPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? type = null,Object? categoryId = null,Object? accountId = null,Object? frequency = null,Object? startDate = null,Object? endDate = freezed,Object? customDays = freezed,}) {
  return _then(_RecurringPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,customDays: freezed == customDays ? _self.customDays : customDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
