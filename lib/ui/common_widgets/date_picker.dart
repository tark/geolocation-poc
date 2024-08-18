import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../ui_constants.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    this.initialDate,
    this.isRange = false,
    this.onDateSelected,
  }) : super(key: key);

  final DateTime? initialDate;
  final bool isRange;
  final ValueChanged<DateTime>? onDateSelected;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final _controller = DateRangePickerController();

  @override
  void initState() {
    _controller.selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.paddingNormal,
        right: AppSize.paddingBig,
        left: AppSize.paddingBig,
        bottom: AppSize.paddingBig,
      ),
      child: SizedBox(
        height: 330,
        child: SfDateRangePicker(
          selectionTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
          rangeTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
            leadingDatesDecoration: const BoxDecoration(
              color: Colors.red,
            ),
            todayTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
            todayCellDecoration: BoxDecoration(
              //color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                width: 2,
              ),
            ),
          ),
          monthViewSettings: DateRangePickerMonthViewSettings(
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ))),
          headerStyle: DateRangePickerHeaderStyle(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
              fontSize: AppSize.fontNormal,
            ),
            textAlign: TextAlign.center,
          ),
          headerHeight: 70,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          yearCellStyle: DateRangePickerYearCellStyle(
            textStyle:  TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
              fontSize: AppSize.fontNormal,
            ),
            todayTextStyle:  TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
              fontSize: AppSize.fontNormal,
            ),
            disabledDatesTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
              fontSize: AppSize.fontNormal,
            ),
            leadingDatesTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
              fontSize: AppSize.fontNormal,
            ),
            todayCellDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                width: 2,
              ),
            ),
          ),
          todayHighlightColor: Theme.of(context).colorScheme.secondary,
          selectionColor: Theme.of(context).colorScheme.secondary,
          controller: _controller,
          showNavigationArrow: true,
          selectionMode: widget.isRange
              ? DateRangePickerSelectionMode.range
              : DateRangePickerSelectionMode.single,
          onSelectionChanged: (s) {
            widget.onDateSelected?.call(s.value);
          },
        ),
      ),
    );
  }
}
