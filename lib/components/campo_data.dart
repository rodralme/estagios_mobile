import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoData extends DateTimeField {
  CampoData({
    DateFormat format,
    TextEditingController controller,
    String label,
    Function onSaved,
    onShowPicker,
  }) : super(
          format: format ?? DateFormat('dd/MM/yyyy'),
          controller: controller,
          decoration: InputDecoration(labelText: label),
          onSaved: (val) {
            onSaved((new DateFormat('yyy-MM-dd HH:mm:ss')).format(val));
          },
          onShowPicker: onShowPicker ??
              (context, currentValue) {
                return showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime.now().add(new Duration(days: 90)),
                );
              },
        );
}
