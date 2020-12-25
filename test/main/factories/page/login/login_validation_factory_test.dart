import 'package:fordev/validation/validators/required_field_validation.dart';
import 'package:test/test.dart';

import 'package:fordev/validation/validators/validations.dart';
import 'package:fordev/main/factories/factories.dart';

void main() {
  test('Shuold return the corret validation', () {
    final validations = makeLoginValidation();
    expect(
      validations,[
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ]);
     
  });
}
