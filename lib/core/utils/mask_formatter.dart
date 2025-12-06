
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Mask for phone number text field.
final maskFormatter = MaskTextInputFormatter(
  mask: '+996 (###) ## ## ##',
  filter: {
    "#": RegExp(r'[0-9]'),
  },
);

final cardFormat = MaskTextInputFormatter(
  mask: '#### #### #### ####',
  filter: {
    "#": RegExp(r'[0-9]'),
  },
);

final maskFormatter2 = MaskTextInputFormatter(
  mask: '+996 (###) ## ## ##',
  filter: {
    "#": RegExp(r'[0-9]'),
  },
);

final maskCardFormatter = MaskTextInputFormatter(
  mask: '#### #### #### ####',
  filter: {
    "#": RegExp(r'[0-9]'),
  },
);


final maskCardDateFormatter = MaskTextInputFormatter(
  mask: '#### #### #### ####',
  filter: {
    "#": RegExp(r'[0-9]'),
  },
);
