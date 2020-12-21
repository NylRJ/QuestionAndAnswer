import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

class ValidationSpy extends Mock implements Validation {}

class StreamLoginPresenter {
  final Validation validation;
  StreamLoginPresenter({@required this.validation});

  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }
}

void main() {
  test('Shuolt call Validation with correct email', () {
    //Arrange
    final validation = ValidationSpy();
    final sut = StreamLoginPresenter(validation: validation);
    final email = faker.internet.email();

    //Act
    sut.validateEmail(email);

    //Assert

    verify(validation.validate(field: 'email', value: email)).called(1);
  });
}
