import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../validation/validators/validations.dart';

Validation makeValidationComposite() {
  return ValidationComposite(makeLoginValidation());
}

List<FieldValidation> makeLoginValidation() {
  return [
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ];
}
