import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fordev/domain/usecases/authentication.dart';

import 'package:fordev/presentation/presenters/presenters.dart';
import 'package:fordev/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

void main() {
  //variaveis Globais do Arrange
  AuthenticationSpy authentication;
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;
  String password;
  PostExpectation mockValidationCall(String field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    //Instanciando as variaveis Globais
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(validation: validation, authentication:authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
  });
  test('Should call Validation with correct email', () {
    //Act
    sut.validateEmail(email);

    //Assert
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emti email error if validation fails', () {
    //Arrange
    mockValidation(value: 'error');
    //Assert later
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    //Act
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit no error if email validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct password', () {
    //Act
    sut.validatePassword(password);

    //Assert
    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emti password error if validation fails', () {
    //Arrange
    mockValidation(value: 'error');
    //Assert later
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    //Act
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit no error if password validation succeeds', () {
    sut.passwordErrorStream
        .listen((expectAsync1((error) => expect(error, null))));
    sut.isFormValidStream
        .listen((expectAsync1((isValid) => expect(isValid, false))));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit form invalid if any field is invalid', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit form invalid if any field is invalid', () {
    mockValidation(field: 'password', value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit form valid if form is valid', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication with correct values', () async {
    //Arrange
    sut.validateEmail(email);
    sut.validatePassword(password);

    //Atc
    await sut.auth();

    //Assert
    verify(authentication
            .auth(AuthenticationParams(email: email, secret: password)))
        .called(1);
  });
}
