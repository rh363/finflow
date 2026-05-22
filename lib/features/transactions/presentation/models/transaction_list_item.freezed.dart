// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionListItem {

 String get id; String get categoryIcon; String get categoryName; DateTime get date; double get amount; String get currency; TransactionType get type; String? get note;
/// Create a copy of TransactionListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionListItemCopyWith<TransactionListItem> get copyWith => _$TransactionListItemCopyWithImpl<TransactionListItem>(this as TransactionListItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,categoryIcon,categoryName,date,amount,currency,type,note);

@override
String toString() {
  return 'TransactionListItem(id: $id, categoryIcon: $categoryIcon, categoryName: $categoryName, date: $date, amount: $amount, currency: $currency, type: $type, note: $note)';
}


}

/// @nodoc
abstract mixin class $TransactionListItemCopyWith<$Res>  {
  factory $TransactionListItemCopyWith(TransactionListItem value, $Res Function(TransactionListItem) _then) = _$TransactionListItemCopyWithImpl;
@useResult
$Res call({
 String id, String categoryIcon, String categoryName, DateTime date, double amount, String currency, TransactionType type, String? note
});




}
/// @nodoc
class _$TransactionListItemCopyWithImpl<$Res>
    implements $TransactionListItemCopyWith<$Res> {
  _$TransactionListItemCopyWithImpl(this._self, this._then);

  final TransactionListItem _self;
  final $Res Function(TransactionListItem) _then;

/// Create a copy of TransactionListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryIcon = null,Object? categoryName = null,Object? date = null,Object? amount = null,Object? currency = null,Object? type = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: null == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionListItem].
extension TransactionListItemPatterns on TransactionListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionListItem value)  $default,){
final _that = this;
switch (_that) {
case _TransactionListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionListItem value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String categoryIcon,  String categoryName,  DateTime date,  double amount,  String currency,  TransactionType type,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionListItem() when $default != null:
return $default(_that.id,_that.categoryIcon,_that.categoryName,_that.date,_that.amount,_that.currency,_that.type,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String categoryIcon,  String categoryName,  DateTime date,  double amount,  String currency,  TransactionType type,  String? note)  $default,) {final _that = this;
switch (_that) {
case _TransactionListItem():
return $default(_that.id,_that.categoryIcon,_that.categoryName,_that.date,_that.amount,_that.currency,_that.type,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String categoryIcon,  String categoryName,  DateTime date,  double amount,  String currency,  TransactionType type,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TransactionListItem() when $default != null:
return $default(_that.id,_that.categoryIcon,_that.categoryName,_that.date,_that.amount,_that.currency,_that.type,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionListItem implements TransactionListItem {
  const _TransactionListItem({required this.id, required this.categoryIcon, required this.categoryName, required this.date, required this.amount, required this.currency, required this.type, this.note});
  

@override final  String id;
@override final  String categoryIcon;
@override final  String categoryName;
@override final  DateTime date;
@override final  double amount;
@override final  String currency;
@override final  TransactionType type;
@override final  String? note;

/// Create a copy of TransactionListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionListItemCopyWith<_TransactionListItem> get copyWith => __$TransactionListItemCopyWithImpl<_TransactionListItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,categoryIcon,categoryName,date,amount,currency,type,note);

@override
String toString() {
  return 'TransactionListItem(id: $id, categoryIcon: $categoryIcon, categoryName: $categoryName, date: $date, amount: $amount, currency: $currency, type: $type, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TransactionListItemCopyWith<$Res> implements $TransactionListItemCopyWith<$Res> {
  factory _$TransactionListItemCopyWith(_TransactionListItem value, $Res Function(_TransactionListItem) _then) = __$TransactionListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String categoryIcon, String categoryName, DateTime date, double amount, String currency, TransactionType type, String? note
});




}
/// @nodoc
class __$TransactionListItemCopyWithImpl<$Res>
    implements _$TransactionListItemCopyWith<$Res> {
  __$TransactionListItemCopyWithImpl(this._self, this._then);

  final _TransactionListItem _self;
  final $Res Function(_TransactionListItem) _then;

/// Create a copy of TransactionListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryIcon = null,Object? categoryName = null,Object? date = null,Object? amount = null,Object? currency = null,Object? type = null,Object? note = freezed,}) {
  return _then(_TransactionListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: null == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
