import 'package:{{name.snakeCase()}}/app/resources/svg_assets.dart';
import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/styling_configurations.dart';
import 'package:{{name.snakeCase()}}/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? text;
  final String? prefixText;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<String>? onUnfocused;
  final ValueChanged<String>? onTextSubmitted;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? textInputFormatters;
  final TextInputType? textInputType;
  final InputDecoration? decoration;
  final bool disabled;
  final bool isError;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final Widget? prefix;
  final Widget? trailing;
  final bool showClearButton;

  const TextInput({
    Key? key,
    this.controller,
    this.placeholder,
    this.text,
    this.prefixText,
    this.onTextChanged,
    this.onUnfocused,
    this.onTextSubmitted,
    this.focusNode,
    this.textInputFormatters,
    this.textInputType,
    this.disabled = false,
    this.isError = false,
    this.textStyle,
    this.decoration,
    this.textAlign = TextAlign.start,
    this.prefix,
    this.trailing,
    this.showClearButton = false,
  }) : super(key: key);

  @override
  TextInputState createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  late TextEditingController _controller;
  late FocusNode _focus;
  bool isFocused = false;

  TextStyle get _fixedTextStyle => (widget.textStyle ?? AppTheme.typography.mediumLight).copyWith(height: 1);

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.text != null) {
      _controller.text = widget.text!;
    }
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != null && widget.text != oldWidget.text) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _controller.text = widget.text!;
          _onTextChanged(_controller.text);
        });
      });
    }
  }

  @override
  void dispose() {
    _focus.unfocus();

    /// Only internally created controller is being disposed automatically
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    var isFocusedNow = _focus.hasFocus;

    if (isFocused && !isFocusedNow) {
      var result = _controller.text;
      widget.onUnfocused?.call(result);
    }

    if (!mounted) return;
    setState(() {
      isFocused = isFocusedNow;
    });
  }

  void _onTextChanged(String text) {
    widget.onTextChanged?.call(text);
  }

  void _onSubmitted(String text) {
    widget.onTextSubmitted?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = StyleConfiguration.inputBorderRadius;
    final formFocusElements = FocusScope.of(context).traversalChildren;
    final isLastInForm = formFocusElements.isNotEmpty && formFocusElements.last == _focus;

    return Opacity(
      opacity: widget.disabled ? 0.5 : 1,
      child: Material(
        color: AppTheme.colors.transparent,
        child: TextFormField(
          keyboardType: widget.textInputType,
          controller: _controller,
          focusNode: _focus,
          textInputAction: isLastInForm ? TextInputAction.done : TextInputAction.next,
          inputFormatters: widget.textInputFormatters,
          enabled: !widget.disabled,
          onChanged: _onTextChanged,
          onFieldSubmitted: _onSubmitted,
          textAlign: widget.textAlign,
          maxLines: 1,
          style: _fixedTextStyle,
          scrollPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          textAlignVertical: TextAlignVertical.center,
          decoration: widget.decoration ??
              InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide:
                      BorderSide(color: widget.isError ? AppTheme.colors.negative : AppTheme.colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: widget.isError ? AppTheme.colors.negative : AppTheme.colors.focus),
                ),
                filled: true,
                fillColor: AppTheme.colors.componentsFillColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
                isDense: true,
                prefixStyle: _fixedTextStyle,
                prefixText: (isFocused || _controller.value.text.isNotEmpty) ? widget.prefixText : '',
                hintText: isFocused ? '' : widget.placeholder,
                hintStyle: AppTheme.typography.mediumLightWeak,
                prefixIcon: widget.prefix,
                suffixIcon: widget.showClearButton && _controller.text.isNotEmpty && isFocused
                    ? TextButton(
                        onPressed: _clearText,
                        style: StyleConfiguration.textButtonStyle,
                        child: SvgImage(
                          SvgAsset.clearField,
                          width: 22,
                          height: 22,
                          color: AppTheme.colors.backgroundAccent,
                        ),
                      )
                    : widget.trailing,
              ),
        ),
      ),
    );
  }

  void _clearText() {
    setState(() {
      _controller.text = '';
      _onTextChanged(_controller.text);
    });
  }
}
