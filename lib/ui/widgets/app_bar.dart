import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocation_poc/ui/ui_constants.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import '../../util/log.dart';
import '../common_widgets/texts.dart';
import '../widgets/search_bar.dart' as my;

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.trailing,
    this.showBackButton = false,
    this.onSearchChange,
    this.searchProgress = false,
    this.willPop,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final bool showBackButton;
  final ValueChanged<String>? onSearchChange;
  final bool searchProgress;
  final Future<bool> Function()? willPop;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight * 1.2);
}

class _MyAppBarState extends State<MyAppBar> {
  var _showSearch = false;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.scaffoldBackground,
      child: Padding(
        padding: AppPadding.top(MediaQuery.of(context).viewPadding.top),
        child: SizedBox(
          height: kToolbarHeight * 1.1,
          child: _showSearch ? _searchContent() : _content(),
        ),
      ),
    );
  }

  //
  Widget _content() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Horizontal.micro(),
        if (widget.showBackButton)
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: IconTheme.of(context).color,
            ),
            onPressed: () async {
              final willPop = await widget.willPop?.call();
              if (mounted && (willPop == true || willPop == null)) {
                Navigator.of(context).pop();
              }
            },
          ),
        if (widget.leading != null) widget.leading!,
        Expanded(
          child: Padding(
            padding: AppPadding.horizontalNormal,
            child: Texts(
              widget.title,
              fontSize: AppSize.fontNormalBig,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (widget.onSearchChange != null)
          SizedBox(
            width: 36,
            height: 36,
            child: IconButton(
              padding: AppPadding.allZero,
              onPressed: () => setState(() => _showSearch = true),
              icon: const Icon(Icons.search),
            ),
          ),
        if (widget.trailing != null) widget.trailing!,
        const Horizontal.normal(),
      ],
    );
  }

  Widget _searchContent() {
    return Padding(
      padding: const AppPadding.vertical(10) + AppPadding.horizontalNormal,
      child: my.SearchBar(
        hint: 'search'.tr(),
        progress: widget.searchProgress,
        onChange: (query) async {
          widget.onSearchChange?.call(query);
        },
        onClosePressed: () {
          widget.onSearchChange?.call('');
          setState(() => _showSearch = false);
        },
      ),
    );
  }
}
