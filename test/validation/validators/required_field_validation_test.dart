import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';

abstract class FieldValidation {
  String get field;
  String validate(String value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo Obrigatório';
  }
}

void main() {
  RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });
  test('Should return null if value is not empty', () {
    expect(sut.validate('any_field'), null);
  });

  test('Should return error if value is  empty', () {
    expect(sut.validate(''), 'Campo Obrigatório');
  });

  test('Should return error if value is  null', () {
    

    expect(sut.validate(null), 'Campo Obrigatório');
  });
}
