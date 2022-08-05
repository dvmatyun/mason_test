import 'package:{{name.snakeCase()}}/app/resources/svg_assets.dart';
import 'package:{{name.snakeCase()}}/core/extensions/string.dart';
import 'package:{{name.snakeCase()}}/core/localization/extension.dart';
import 'package:{{name.snakeCase()}}/core/localization/locale_keys.g.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/input_formatters.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/styling_configurations.dart';
import 'package:{{name.snakeCase()}}/core/widgets/inputs/text_input.dart';
import 'package:{{name.snakeCase()}}/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<String>? onUnfocused;
  final bool disabled;
  final bool isError;
  final String? placeholder;

  const PhoneNumberInput({
    Key? key,
    this.controller,
    this.onTextChanged,
    this.onUnfocused,
    this.disabled = false,
    this.isError = false,
    this.placeholder,
  }) : super(key: key);

  // TODO: discuss source of the code (device/app specific)
  String get _code => LocaleKeys.phoneNumberCode.tr();

  void _onChanged(String text) {
    final formatted = '$_code${text.removeAllExceptNumbers()}';
    onTextChanged?.call(formatted);
  }

  void _onUnfocused(String text) {
    final formatted = '$_code${text.removeAllExceptNumbers()}';
    onUnfocused?.call(formatted);
  }

  Widget _buildLanguageIcon() => TextButton(
        onPressed: () {},
        style: StyleConfiguration.textButtonStyle,
        child: const SvgImage(
          SvgAsset.flagCz,
          width: 22,
          height: 16,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextInput(
      controller: controller,
      onTextChanged: _onChanged,
      onUnfocused: _onUnfocused,
      disabled: disabled,
      isError: isError,
      textInputType: TextInputType.number,
      textInputFormatters: [InputFormatters.getPhoneFormatter()],
      prefixText: '$_code ',
      placeholder: placeholder,
      prefix: _buildLanguageIcon(),
    );
  }
}
