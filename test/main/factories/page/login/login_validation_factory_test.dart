import 'package:fordev/validation/validators/required_field_validation.dart';
import 'package:test/test.dart';

import 'package:fordev/validation/validators/validators.dart';
import 'package:fordev/main/factories/factories.dart';

void main() {
  test('Shuold return the corret validation', () {
    final validations = makeLoginValidations();
    expect(
      validations,[
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ]);
     
  });
}
