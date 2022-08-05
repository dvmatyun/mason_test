import 'package:flutter_mason/app/resources/svg_assets.dart';
import 'package:flutter_mason/core/controllers/debouncer.dart';
import 'package:flutter_mason/core/widgets/helpers/styling_configurations.dart';
import 'package:flutter_mason/core/widgets/inputs/text_input.dart';
import 'package:flutter_mason/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class AddressInput extends StatelessWidget {
  static const height = 51.0;

  final ValueChanged<String>? onTextChanged;
  final ValueChanged<String>? onUnfocused;
  final ValueChanged<String>? onSubmitted;
  final String? placeholder;
  final bool disabled;
  final bool isError;
  final FocusNode? focusNode;
  final String? addressText;

  /// Enables 'location' button when not null
  final VoidCallback? onLocationButtonPressed;

  final _debouncer = Debouncer(delayMs: 1000);

  AddressInput({
    Key? key,
    this.onTextChanged,
    this.onUnfocused,
    this.onSubmitted,
    this.placeholder,
    this.disabled = false,
    this.isError = false,
    this.focusNode,
    this.addressText,
    this.onLocationButtonPressed,
  }) : super(key: key);

  void _onChanged(String text) {
    _debouncer.run(() {
      onTextChanged?.call(text);
    });
  }

  void _onUnfocused(String text) {
    _debouncer.run(() {
      onUnfocused?.call(text);
    });
  }

  void _onSubmitted(String text) {
    onSubmitted?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      textInputType: TextInputType.streetAddress,
      onTextChanged: _onChanged,
      onUnfocused: _onUnfocused,
      onTextSubmitted: _onSubmitted,
      disabled: disabled,
      focusNode: focusNode,
      text: addressText,
      placeholder: placeholder,
      isError: isError,
      trailing: onLocationButtonPressed == null
          ? null
          : TextButton(
              onPressed: onLocationButtonPressed,
              style: StyleConfiguration.textButtonStyle,
              child: const SvgImage(SvgAsset.location, width: 16),
            ),
      showClearButton: true,
    );
  }
}
