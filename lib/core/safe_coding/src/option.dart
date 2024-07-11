import 'package:flutter/foundation.dart';
import 'package:trenergy_wallet/core/safe_coding/safe_coding.dart';

// ignore_for_file: public_member_api_docs

abstract class Option<A> {
  const Option();

  B fold<B>(B Function() ifNone, B Function(A a) ifSome);

  Option<A> orElse(Option<A> Function() other) => fold(other, (_) => this);
  A getOrElse(A Function() dflt) => fold(dflt, (A a) => a);
  Either<B, A> toEither<B>(B Function() ifNone) =>
      fold(() => left(ifNone()), right);
  Either<dynamic, A> operator %(A ifNone) => toEither(() => ifNone);
  A operator |(A dflt) => getOrElse(() => dflt);

  Option<B> map<B>(B Function(A a) f) => fold(none, (A a) => some(f(a)));
  Option<B> andThen<B>(Option<B> next) => fold(none, (_) => next);

  bool isSome() => fold(() => false, (_) => true);

  bool isNone() => !isSome();

  @override
  String toString() => fold(() => 'None', (a) => 'Some($a)');

  void forEach(void Function(A a) sideEffect) => fold(() => Null, sideEffect);
}

@immutable
class Some<A> extends Option<A> {
  const Some(this._a);
  final A _a;
  A get value => _a;
  @override
  B fold<B>(B Function() ifNone, B Function(A a) ifSome) => ifSome(_a);
  @override
  bool operator ==(Object other) => other is Some && other._a == _a;
  @override
  int get hashCode => _a.hashCode;
}

@immutable
class None<A> extends Option<A> {
  const None();
  @override
  B fold<B>(B Function() ifNone, B Function(A a) ifSome) => ifNone();
  @override
  bool operator ==(Object other) => other is None;
  @override
  int get hashCode => 0;
}

Option<A> none<A>() => const None();
Option<A> some<A>(A a) => Some(a);
// ignore: avoid_positional_boolean_parameters
Option<A> option<A>(bool test, A value) => test ? some(value) : none();
Option<A> optionOf<A>(A value) => value != null ? some(value) : none();
