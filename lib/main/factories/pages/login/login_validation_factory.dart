import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validations.dart';


Validation makeValidationComposite() {

  return ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ]);
}
