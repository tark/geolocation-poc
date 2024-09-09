import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:geolocation_poc/util/context_extensions.dart';
import 'package:geolocation_poc/util/string_extensions.dart';
import 'package:geolocation_poc/util/util.dart';

import '../common_widgets/texts.dart';
import '../common_widgets/animated_icon.dart';
import '../ui_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final dateFormat = DateFormat('dd MMM yyyy');

enum MyInputType {
  text,
  date,
  phone,
  email,
  cardExpires,
  zip,
  money,
  name,
  password,
  number,
}

class MyInputTrailingButton {
  MyInputTrailingButton({
    required this.onPressed,
    this.iconData,
    this.icon,
    this.iconColor,
    this.iconSize,
  });

  final IconData? iconData;
  final Widget? icon;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback onPressed;
}

class DateEditingController extends ValueNotifier<DateTime?> {
  DateEditingController() : super(null);

  DateTime? get date => value;

  set date(DateTime? newDate) {
    value = newDate;
  }

  @override
  set value(DateTime? newDate) {
    super.value = newDate;
  }

  void clear() {
    value = null;
  }
}

class MyInput extends StatefulWidget {
  const MyInput({
    Key? key,
    required this.hint,
    this.controller,
    this.dateController,
    this.type = MyInputType.text,
    this.hideBorder = false,
    this.caps = false,
    this.trailing,
    this.inputFormatters,
    this.maxLength,
    this.error = false,
    this.disabled = false,
    this.trailingButton,
    this.valid,
  })  : assert(
          trailing == null || trailingButton == null,
          'You can use trailing OR trailingButton, not together.',
        ),
        super(key: key);

  final String hint;
  final TextEditingController? controller;
  final DateEditingController? dateController;
  final MyInputType type;
  final bool hideBorder;
  final bool caps;
  final Widget? trailing;
  final MyInputTrailingButton? trailingButton;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool error;
  final bool disabled;
  final bool? valid;

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  final _controller = TextEditingController();
  PhoneCountryData? _selectedCountry;
  CardSystemData? _selectedCardSystem;
  var _showCountryInfo = false;
  var _showPassword = false;
  final cardScanChannel = const MethodChannel('billfold.app/card_scan');

  @override
  void initState() {
    widget.controller?.addListener(() {
      if (_isPhone()) {
        _refreshShowCountryInfo(widget.controller?.text);
      }
    });

    widget.dateController?.addListener(() {
      if (_isDate()) {
        final date = widget.dateController?.date;
        if (date != null) {
          _controller.text = dateFormat.format(date);
        }
      }
    });

    switch (widget.type) {
      case MyInputType.phone:
        var text = widget.controller?.text ?? '';
        _refreshShowCountryInfo(text);
        if (text.isNotEmpty) {
          text = formatAsPhoneNumber(text) ?? '';
        }
        break;
      case MyInputType.date:
        // do it here, because sometimes initState
        // called AFTER dateController date has been set.
        final date = widget.dateController?.date;
        if (date != null) {
          _controller.text = dateFormat.format(date);
        }
        break;
      default:
        // do nothing
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.hideBorder
                  ? Colors.transparent
                  : (widget.error
                      ? context.error
                      : Theme.of(context)
                              .inputDecorationTheme
                              .border
                              ?.borderSide
                              .color ??
                          Colors.transparent),
              width: widget.hideBorder ? 0 : (widget.error ? 2 : 1),
            ),
            //color: Colors.white,
          ),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    keyboardType: _keyboardType(),
                    controller: _isDate() ? _controller : widget.controller,
                    enabled: _enabled(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    inputFormatters: [
                      // using this instead of maxLength InputDecoration property,
                      // because that shows counter text and padding are broken
                      if (widget.maxLength != null)
                        LengthLimitingTextInputFormatter(widget.maxLength),
                      if (_isPhone())
                        PhoneInputFormatter(
                          onCountrySelected: _onCountrySelected,
                        ),
                      if (_isCard())
                        CreditCardNumberInputFormatter(
                          onCardSystemSelected: (s) {
                            setState(() => _selectedCardSystem = s);
                          },
                        ),
                      if (widget.type == MyInputType.cardExpires)
                        CreditCardExpirationDateFormatter(),
                      // if (_isMoney())
                      // CurrencyTextInputFormatter(
                      //   locale: 'en',
                      //   decimalDigits: 0,
                      //   symbol: '\$',
                      // ),
                      if (widget.caps) UpperCaseTextFormatter(),
                      if (_isName()) CapitalizationFormatter(),
                    ],
                    obscureText: _isPassword() && !_showPassword,
                    decoration: InputDecoration(
                      labelText: widget.hint,
                      labelStyle: TextStyle(
                        color: widget.error ? context.error : context.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        bottom: 11,
                        top: 11,
                        right: 15,
                      ),
                    ),
                  ),
                ),
                if (_isPhone() && _showCountryInfo) _countryInfo(),
                if (_isCard()) _cardInfo(),
                // if (_isCard() && !_isValid() && widget.onCardScanned != null)
                IconButton(
                  onPressed: () => cardScanChannel.invokeMethod('scanCard'),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: context.secondary.withOpacity(0.2),
                  ),
                ),
                if (!_isValid() && widget.trailing != null) widget.trailing!,
                if (!_isValid() && widget.trailingButton != null)
                  _trailingButton(),
                if (_isValid()) _checkIcon(),
                if (_isPassword()) _eyeIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  void _refreshShowCountryInfo(String? text) {
    final showCountryInfo = text != null && text.isNotEmpty;
    if (showCountryInfo != _showCountryInfo) {
      setState(() => _showCountryInfo = showCountryInfo);
    }
  }

  void _onCountrySelected(PhoneCountryData? data) {
    setState(() => _selectedCountry = data);
  }

  bool _isPhone() {
    return widget.type == MyInputType.phone;
  }

  bool _isZip() {
    return widget.type == MyInputType.zip;
  }

  bool _isCard() {
    return false;
  }

  bool _isEmail() {
    return widget.type == MyInputType.email;
  }

  bool _isNumber() {
    return widget.type == MyInputType.number;
  }

  bool _isDate() {
    return widget.type == MyInputType.date;
  }

  bool _isName() {
    return widget.type == MyInputType.name;
  }

  bool _isMoney() {
    return widget.type == MyInputType.money;
  }

  bool _isValid() {
    return widget.valid == true;
  }

  bool _isPassword() {
    return widget.type == MyInputType.password;
  }

  Widget _countryInfo() {
    final code = _selectedCountry?.countryCode ?? 'us';
    return Row(
      children: [
        Texts(
          code.toUpperCase(),
          fontWeight: FontWeight.w500,
          fontSize: AppSize.fontNormal,
        ),
        const Horizontal.small(),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.network(
            'https://flagsapi.com/${code.toUpperCase()}/flat/64.png',
            width: 24,
            height: 24,
            fit: BoxFit.fill,
            errorBuilder: (c, child, e) {
              return SizedBox(
                height: 16,
                width: 24,
                child: ColoredBox(
                  color: c.secondary.withOpacity(0.15),
                ),
              );
            },
            loadingBuilder: (c, child, e) {
              if (e?.cumulativeBytesLoaded == e?.expectedTotalBytes) {
                return child;
              }

              return const SizedBox(
                height: 16,
                width: 24,
                child: ColoredBox(
                  color: Colors.black12,
                ),
              );
            },
          ),
        ),
        if (widget.trailing == null && widget.trailingButton == null)
          const Horizontal.normal(),
      ],
    );
  }

  Widget _cardInfo() {
    if (_selectedCardSystem == null) {
      return Container();
    }

    var image = '';
    IconData? faIcon;

    switch (_selectedCardSystem?.system) {
      case CardSystem.VISA:
        image = AppImages.visaIcon;
        break;
      case CardSystem.MASTERCARD:
        image = AppImages.mastercardIcon;
        break;
      case CardSystem.AMERICAN_EXPRESS:
        faIcon = FontAwesomeIcons.ccAmex;
        break;
      case CardSystem.DINERS_CLUB:
        faIcon = FontAwesomeIcons.ccDinersClub;
        break;
      case CardSystem.DISCOVER:
        faIcon = FontAwesomeIcons.ccDiscover;
        break;
      case CardSystem.JCB:
        faIcon = FontAwesomeIcons.ccJcb;
        break;
      case CardSystem.UNION_PAY:
      case CardSystem.MIR:
      case CardSystem.MAESTRO:
      default:
        faIcon = FontAwesomeIcons.creditCard;
        break;
    }

    if (faIcon != null) {
      return Padding(
        padding: AppPadding.right(0),
        child: FaIcon(
          faIcon,
          color: Colors.black26,
        ),
      );
    }

    if (image.isNotEmpty) {
      return Padding(
        padding: AppPadding.right(0),
        child: SvgPicture.asset(
          image,
          width: 32,
          height: 24,
        ),
      );
    }

    return Container();
  }

  TextInputType? _keyboardType() {
    if (_isCard() || _isNumber() || _isZip()) {
      return TextInputType.number;
    }

    if (_isPhone()) {
      return TextInputType.phone;
    }

    if (_isEmail()) {
      return TextInputType.emailAddress;
    }

    return null;
  }

  Widget _eyeIcon() {
    return Padding(
      padding: AppPadding.rightMicro,
      child: IconButton(
        icon: Icon(
          _showPassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: widget.error ? context.error : context.secondary,
          size: 20,
        ),
        onPressed: () => setState(() => _showPassword = !_showPassword),
      ),
    );
  }

  bool _enabled() {
    if (widget.disabled == true) {
      return false;
    }

    if (widget.type == MyInputType.date) {
      return false;
    }

    return true;
  }

  Widget _checkIcon() {
    return Padding(
      padding: const AppPadding.horizontal(16),
      child: MyAnimatedIcon(
        color: AppColors.greenAccent,
        size: 20,
        child: SvgPicture.asset(
          AppImages.checkCircleIcon,
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _trailingButton() {
    final child = widget.trailingButton?.icon;
    final icon = widget.trailingButton?.iconData;
    final iconColor = widget.trailingButton?.iconColor;
    final iconSize = widget.trailingButton?.iconSize;
    return Padding(
      padding: AppPadding.horizontalSmall,
      child: SizedBox(
        width: 36,
        height: 36,
        child: IconButton(
          padding: AppPadding.allZero,
          onPressed: widget.trailingButton?.onPressed,
          icon: icon != null
              ? Icon(
                  icon,
                  color: iconColor ?? context.secondary.withOpacity(0.2),
                  size: iconSize ?? 20,
                )
              : (child ?? const SizedBox.shrink()),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CapitalizationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.capitalize(),
      selection: newValue.selection,
    );
  }
}
