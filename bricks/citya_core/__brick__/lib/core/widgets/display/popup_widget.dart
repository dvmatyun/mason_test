import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:{{name.snakeCase()}}/core/widgets/controls/basic_button.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/styling_configurations.dart';
import 'package:flutter/material.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({
    required this.text,
    this.okButtonProperties,
    this.cancelButtonProperties,
    this.textStyle,
    this.title,
    this.alignButtonsAsColumn = true,
    Key? key,
  }) : super(key: key);

  final String text;
  final String? title;
  final PopupButtonProperties? okButtonProperties;
  final PopupButtonProperties? cancelButtonProperties;
  final TextStyle? textStyle;
  final bool alignButtonsAsColumn;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppTheme.colors.backgroundMain,
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Column(
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(title!, style: AppTheme.typography.bigBoldSecondary),
                  ),
                Text(
                  text,
                  style: textStyle ?? AppTheme.typography.normal,
                  textAlign: TextAlign.center,
                ),
                if (alignButtonsAsColumn)
                  Column(
                    children: [
                      if (okButtonProperties != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          child: BasicButton(
                            onPressed: okButtonProperties!.callback,
                            text: okButtonProperties!.text,
                          ),
                        ),
                      if (cancelButtonProperties != null)
                        OutlinedButton(
                          onPressed: cancelButtonProperties!.callback,
                          style: StyleConfiguration.outlinedButtonStyle,
                          child: Text(
                            cancelButtonProperties!.text,
                            style: AppTheme.typography.mediumLight,
                            textHeightBehavior: StyleConfiguration.textHeightBehavior,
                          ),
                        ),
                    ],
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (cancelButtonProperties != null)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: cancelButtonProperties!.callback,
                              style: StyleConfiguration.outlinedButtonStyle,
                              child: Text(
                                cancelButtonProperties!.text,
                                style: AppTheme.typography.mediumLight,
                                textHeightBehavior: StyleConfiguration.textHeightBehavior,
                              ),
                            ),
                          ),
                        if (okButtonProperties != null && cancelButtonProperties != null)
                          const SizedBox(
                            width: 8,
                          ),
                        if (okButtonProperties != null)
                          Expanded(
                            child: BasicButton(
                              onPressed: okButtonProperties!.callback,
                              text: okButtonProperties!.text,
                            ),
                          ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      );
}

class PopupButtonProperties {
  final String text;
  final VoidCallback callback;

  PopupButtonProperties({required this.text, required this.callback});
}
