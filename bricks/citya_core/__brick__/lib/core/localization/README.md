# Localization
For text internationalization [easy_localization](https://pub.dev/packages/easy_localization) is being used. All translatable resources are located at `.lib/core/localization/translations`

## Get started
First thing first we need to generate the asset loader class
###
`flutter pub run easy_localization:generate -S lib/core/localization/translations -O lib/core/localization -o localization_asset_loader.g.dart`
###
Then, to make translations accessible through the variables with compile-time checks, you should run one more command
###
`flutter pub run easy_localization:generate -S lib/core/localization/translations -O lib/core/localization -o locale_keys.g.dart -f keys`
###
Now you are ready to go! Don't forget to rerun code generation steps after you perform changes in your localization files!

## Usage
To translate string, call `tr()` method on it. Like so: `'textKey'.tr()`
###
Previous code generation steps allow us to reference keys from the single generated class `LocaleKeys`. So, with this fact in mind, previously mentioned example will turn into `LocaleKeys.textKey.tr()`.


###
For more details regarding arguments, plurals and language switching, reference the official library page

