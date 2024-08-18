import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'date_picker.dart';

class DatePickerModal extends StatefulWidget {
  const DatePickerModal({
    Key? key,
    this.initialDate,
    this.isRange = false,
  }) : super(key: key);

  final DateTime? initialDate;
  final bool isRange;

  @override
  State<DatePickerModal> createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  final _controller = DateRangePickerController();

  @override
  void initState() {
    _controller.selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      initialDate: widget.initialDate,
      isRange: widget.isRange,
      onDateSelected: (date) => Navigator.of(context).pop(date),
    );
  }
}