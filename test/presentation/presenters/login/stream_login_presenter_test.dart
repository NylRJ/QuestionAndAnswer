import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fordev/presentation/presenters/presenters.dart';
import 'package:fordev/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  //variaveis Globais do Arrange
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;
  PostExpectation mockValidationCall(String field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    //Instanciando as variaveis Globais
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });
  test('Shuolt call Validation with correct email', () {
    //Act
    sut.validateEmail(email);

    //Assert
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Shuolt emti email error if validation fails', () {
    //Arrange
    mockValidation(value: 'error');
    //Assert later
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    

    //Act
    sut.validateEmail(email);
    sut.validateEmail(email);
    
  });
}
