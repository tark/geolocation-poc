import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import '../common_widgets/inputs.dart';
import '../common_widgets/spinner.dart';
import '../ui_constants.dart';

const _debounceDelayTime = 500;

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.onChange,
    this.hint,
    this.progress = false,
    this.onClosePressed,
  }) : super(key: key);

  final String? hint;
  final ValueChanged<String> onChange;
  final bool progress;
  final VoidCallback? onClosePressed;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    _controller.addListener(() {
      _onSearchChanged(_controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.cardBackground,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const AppPadding.left(14),
            child: SvgPicture.asset(
              AppImages.searchIcon,
              height: 14,
              width: 14,
              color: context.secondary,
            ),
          ),
          const Horizontal.micro(),
          Expanded(
            child: Inputs(
              borderWidth: 0,
              borderColor: Colors.transparent,
              borderWidthFocused: 0,
              borderColorFocused: Colors.transparent,
              hint: widget.hint ?? 'search'.tr(),
              hintColor: context.secondary,
              height: 1.1,
              textSize: AppSize.fontNormal,
              paddingVertical: 0,
              paddingHorizontal: 8,
              controller: _controller,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (widget.progress)
            const Padding(
              padding: AppPadding.right(18),
              child: SizedBox(
                width: 12,
                height: 12,
                child: Spinner(
                  color: Colors.black38,
                  strokeWidth: 1.4,
                ),
              ),
            ),
          if (!widget.progress)
            IconButton(
              onPressed: () {
                _controller.text = '';
                widget.onClosePressed?.call();
              },
              iconSize: 20,
              icon: Icon(
                Icons.close_rounded,
                color: context.primary.withOpacity(0.4),
              ),
            ),
        ],
      ),
    );
  }

  void _onSearchChanged(String search) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(
      const Duration(
        milliseconds: _debounceDelayTime,
      ),
      () {
        widget.onChange.call(search);
      },
    );
  }
}
