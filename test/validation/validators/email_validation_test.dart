import 'package:test/test.dart';

import 'package:fordev/validation/validators/validations.dart';




void main() {
  EmailValidation sut;
  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('Should return  null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return  null if email is null', () {
      expect(sut.validate(null), null);
  });

  test('Should return  null if email is valid', () {
    expect(sut.validate('moises.souza@gmail.com'), null);
  });
  
  test('Should return  error if email is invalid', () {
    expect(sut.validate('moises.souza'), 'Campo Inválido');
  });
}