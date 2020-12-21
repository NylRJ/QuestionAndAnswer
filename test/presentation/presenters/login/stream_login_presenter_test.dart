import 'dart:async';

import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

class LoginState {
  String emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({@required this.validation});

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);

    _controller.add(_state);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  //variaveis Globais do Arrange
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  setUp(() {
    //Instanciando as variaveis Globais
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });
  test('Shuolt call Validation with correct email', () {
    //Act
    sut.validateEmail(email);

    //Assert
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Shuolt emti email error if validation fails', () {
    //Arrange
    when(validation.validate(
            field: anyNamed('field'), value: anyNamed('value')))
        .thenReturn('error');

    //Assert later
    expectLater(sut.emailErrorStream, emits('error'));

    //Act
    sut.validateEmail(email);
  });
}
