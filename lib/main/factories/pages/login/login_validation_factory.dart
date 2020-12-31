import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';
import '../../../builders/builders.dart';

Validation makeValidationComposite() {
  return ValidationComposite(makeLoginValidation());
} 

List<FieldValidation> makeLoginValidation() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().build()
  ];
}
