import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

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
