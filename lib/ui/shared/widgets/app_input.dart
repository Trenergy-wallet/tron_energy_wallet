import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Виджет текстового поля вввода.
///
/// [suffixIcon] - иконка справа. В случае добавления иконки справа обработчик
///   автоматически не добавляется, его нужно добавить вручную снаружи.
class AppInput extends StatefulWidget {
  /// Виджет текстового поля вввода.
  const AppInput({
    required this.controller,
    super.key,
    this.width,
    this.height = 44,
    this.obscuringCharacter,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.prefixText,
    this.suffixText,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.contentPadding,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.hintFocusText,
    this.hintText,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.prefix,
    this.title,
    this.titleColor,
    this.hintMaxLines,
    this.readOnly = false,
    this.fillColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.enabledBorder,
    this.focusedBorder,
    this.counterText,
    this.autoFocus = false,
    this.expands = false,
    this.hasError = false,
    this.showErrorText = true,
    this.errorText,
    this.focusNode,
    this.textInputAction,
    this.titleInsertBtn,
    this.contextMenuBuilder,
    this.scrollPadding = const EdgeInsets.all(20),
  });

  /// [AppInput.textarea]
  const AppInput.textarea({
    required this.controller,
    this.width,
    this.height,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.hintFocusText,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.prefix,
    this.title,
    this.titleColor,
    this.hintMaxLines,
    this.readOnly = false,
    this.fillColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.enabledBorder,
    this.focusedBorder,
    this.counterText,
    this.autoFocus = false,
    this.expands = false,
    this.hasError = false,
    this.showErrorText = true,
    this.errorText,
    this.focusNode,
    this.textInputAction,
    this.titleInsertBtn,
    this.contextMenuBuilder,
    super.key,
  })  : obscureText = false,
        obscuringCharacter = '•',
        keyboardType = TextInputType.multiline,
        textAlign = TextAlign.start,
        prefixText = null,
        suffixText = null,
        suffixIcon = null,
        prefixIcon = null,
        suffixIconConstraints = null,
        prefixIconConstraints = null,
        contentPadding =
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollPadding = const EdgeInsets.all(20);

  /// Ширина - стараемся использовать только в **крайнем** случае
  /// Не задаем напрямую, ограничиваем внешними пэддингами
  final double? width;

  /// Высота понадобилась, так как внезапно на экране 6.1.1
  /// решили сделать кастомную высоту ввода.
  final double? height;

  /// Прятать ли текст при воводе
  final bool? obscureText;

  /// Какой символ указывать, если прячем текст
  final String? obscuringCharacter;

  /// Пэддинг внутри поля
  final EdgeInsetsGeometry? contentPadding;

  /// Тип клавиатуры, которая открывается, когда поле получает фокус
  final TextInputType? keyboardType;

  /// Тип кнопки подтверждения
  final TextInputAction? textInputAction;

  /// Выравнивание текста.
  final TextAlign textAlign;

  /// Форматтеры для ограничения вводимых символов
  final List<TextInputFormatter>? inputFormatters;

  /// Заблокировано ли поле
  final bool readOnly;

  /// Виджет слева от текста
  final Widget? prefix;

  /// Префикс текста
  final String? prefixText;

  /// Суффикс текста
  final String? suffixText;

  /// Виджет справа от текста
  final Widget? suffixIcon;

  /// Ограничения на размер для suffixIcon
  final BoxConstraints? suffixIconConstraints;

  /// Иконка prefixIcon
  final Widget? prefixIcon;

  /// Ограничения на размер для  prefixIcon
  final BoxConstraints? prefixIconConstraints;

  /// Минимальное количество линий (полезно если нужно создать большое поле
  /// в высоту
  final int? minLines;

  /// Максимальное количество линий (используем если надо создать небольшое
  /// поле
  final int? maxLines;

  /// Ограничение на длину вводимого текста
  final int? maxLength;

  /// Подсказка, которая отображатеся на текстовом поле после того, как
  /// пользователь начал ввод
  final String? hintFocusText;

  /// Текст подсказки при отсутстии фокуса
  final String? hintText;

  /// Подсказка, отображающаяся внутри границы поля слева сверху, которая не
  /// мешает вводу
  final String? title;

  /// Цвет подсказки
  final Color? titleColor;

  /// Огранчение на длину подсказки
  final int? hintMaxLines;

  /// Коллбэк, срабатывающий каждый раз при изменении вводимого текста
  final ValueChanged<String>? onChanged;

  /// Контроллер ввода текста. Стараемся его указывать ВСЕГДА
  final TextEditingController controller;

  /// Коллбэк при нажатии на поле
  final GestureTapCallback? onTap;

  /// Коллбэк при завершении ввода (нажатии клавши ввод)
  final void Function(String)? onFieldSubmitted;

  /// Бэкграунд поля
  final Color? fillColor;

  /// Выравнивание по вертикали
  final CrossAxisAlignment crossAxisAlignment;

  /// Цвет границы при отсутствии фокуса
  final Color? enabledBorder;

  /// Цвет границы при фокусе
  final Color? focusedBorder;

  /// Счетчик текста внизу теперь опциональный.
  final String? counterText;

  /// Запрашивать ли фокус?
  final bool autoFocus;

  ///
  final bool expands;

  /// Показывать ли ошибку
  final bool hasError;

  /// Показывать текст ошибки
  final bool showErrorText;

  /// Текст ошибки
  final String? errorText;

  /// Внешний фокус для инпута.
  final FocusNode? focusNode;

  /// Отступ вниз от поля ввода при скроллинге (актуально при выползаниии клавы)
  final EdgeInsets scrollPadding;

  /// Коллбэк при нажатии на кнопку "вставить"
  final void Function()? titleInsertBtn;

  ///
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _onKeyTap() {
    _audioPlayer.play(
      AssetSource('sounds/audio-editor-output.wav'),
      position: Duration.zero,
    );
    HapticFeedback.vibrate();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = 12.sbWidth;
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          if (widget.title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.bodySmallText(
                  widget.title ?? '',
                  color: widget.titleColor,
                ),
                if (widget.titleInsertBtn != null)
                  AppButtonText(
                    text: 'mobile.insert'.tr(),
                    onTap: widget.titleInsertBtn,
                  ),
              ],
            ),
            8.sbHeight,
          ],
          SizedBox(
            height: widget.height,
            child: TextFormField(
              controller: widget.controller,
              textAlignVertical: TextAlignVertical.top,
              textAlign: widget.textAlign,
              autofocus: widget.autoFocus,
              focusNode: widget.focusNode,
              maxLength: widget.maxLength,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              expands: widget.expands,
              readOnly: widget.readOnly,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              contextMenuBuilder: widget.contextMenuBuilder,
              onChanged: (v) {
                _onKeyTap();
                widget.onChanged?.call(v);
              },
              onTap: widget.onTap,
              onFieldSubmitted: widget.onFieldSubmitted,
              cursorColor: AppColors.blueVioletBright,
              scrollPadding: widget.scrollPadding,
              textInputAction: widget.textInputAction,
              style: AppStyles.placeholderMediumCond.copyWith(
                decorationThickness: 0,
                decorationColor: Colors.transparent,
                color: widget.hasError ? AppColors.negativeBright : null,
              ),
              obscureText: widget.obscureText ?? false,
              obscuringCharacter: widget.obscuringCharacter ?? '*',
              decoration: InputDecoration(
                prefixText: widget.prefixText,
                suffixText: widget.suffixText,
                counterText: widget.counterText,
                hintText: widget.hintText,
                errorStyle: AppStyles.placeholderMediumCond.copyWith(
                  color: AppColors.negativeBright,
                ),
                // Паддинг справа от иконки удалось добавить
                // только таким образом.
                suffixIcon: widget.suffixIcon != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          8.sbWidth,
                          widget.suffixIcon!,
                          gap,
                        ],
                      )
                    : null,
                suffixIconConstraints: widget.suffixIconConstraints ??
                    BoxConstraints(maxHeight: 20.r),
                // Паддинг слева от иконки удалось добавить
                // только таким образом.
                prefixIcon: widget.prefixIcon != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          gap,
                          widget.prefixIcon!,
                          8.sbWidth,
                        ],
                      )
                    : null,
                prefixIconConstraints: widget.prefixIconConstraints ??
                    BoxConstraints(maxHeight: 20.r),
                hintMaxLines: widget.hintMaxLines,
                prefix: widget.prefix,
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 12),
                hintStyle: AppStyles.placeholderMediumCond.copyWith(
                  color: AppColors.bwGrayMid,
                ),
                error: widget.hasError ? const SizedBox.shrink() : null,
                filled: true,
                fillColor: widget.fillColor ??
                    (widget.hasError
                        ? AppColors.negativeLightDull
                        : widget.readOnly
                            ? AppColors.primaryMid
                            : AppColors.primaryMid),
                enabledBorder: OutlineInputBorder(
                  borderRadius: Consts.borderRadiusAll12,
                  borderSide: BorderSide(
                    color: widget.readOnly
                        ? AppColors.bwGrayMid
                        : widget.enabledBorder ?? AppColors.bwBrightPrimary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: Consts.borderRadiusAll12,
                  borderSide: BorderSide(
                    // по умолчанию цвет из конструктора BorderSide
                    color: widget.readOnly
                        ? AppColors.transparent
                        : widget.focusedBorder ?? AppColors.blueVioletBright,
                  ),
                ),

                errorBorder: OutlineInputBorder(
                  borderRadius: Consts.borderRadiusAll12,
                  borderSide: BorderSide(color: AppColors.negativeBright),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: Consts.borderRadiusAll12,
                  borderSide: BorderSide(color: AppColors.negativeBright),
                ),
              ),
            ),
          ),
          if (widget.hasError && widget.showErrorText) ...[
            4.sbHeight,
            AppText.bodySmallTextCond(
              widget.errorText,
              color: AppColors.negativeBright,
            ),
          ],
        ],
      ),
    );
  }
}
