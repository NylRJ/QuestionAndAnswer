import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:fordev/validation/protocols/field_validation.dart';
import 'package:fordev/presentation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validtions;

  ValidationComposite(this.validtions);

  String validate({@required String field, @required String value}) {
    String error;
    for (final validation in validtions.where((v) => v.field == field)) {

      error = validation.validate(value);
      //(error?.isNotEmpty == true) == (error != null && error.isNotEmpty)
      if (error?.isNotEmpty == true) {
        return error;
      }
    }
    return error;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;

  void mockValidation1(String error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(String error) {
    when(validation2.validate(any)).thenReturn(error);
  }

  void mockValidation3(String error) {
    when(validation3.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('other_field');
    mockValidation1(null);

    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);

    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('any_field');
    mockValidation3(null);

    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validation return null or empty', () {
    mockValidation2('');
    expect(sut.validate(field: 'any_field', value: 'any_value'), null);
  });

  test('Should return the first error', () {
    mockValidation1('error_1');
    mockValidation2('error_2');
    mockValidation3('error_3');

    expect(sut.validate(field: 'any_field', value: 'any_value'), 'error_2');
  });

  
}
