import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class DateFormField extends FormField<DateTime> {
  final ValueChanged<DateTime> onChanged;

  DateFormField({
    DateTime initialValue,
    ValueChanged<DateTime> onChanged,
    FormFieldValidator<DateTime> validator,
  })  : onChanged = onChanged,
        super(
          initialValue: initialValue,
          validator: validator,
          builder: (FormFieldState formFieldState) => Ink(
            child: InkWell(
              onTap: () async {
                var newDate = await showDatePicker(
                  context: formFieldState.context,
                  initialDate: formFieldState.value,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                // Don't change the date if the date picker returns null.
                if (newDate == null) {
                  return;
                }

                // Don't use formFieldState.setValue; it's protected.
                formFieldState.didChange(newDate);

                // Notify the parent widget that the date changed.
                onChanged(newDate);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style:
                          Theme.of(formFieldState.context).textTheme.bodyText1,
                    ),
                    Text(
                      intl.DateFormat.yMd().format(formFieldState.value),
                      style:
                          Theme.of(formFieldState.context).textTheme.subtitle1,
                    ),
                    if (!formFieldState.isValid)
                      Text(
                        formFieldState.errorText ?? "",
                        style: Theme.of(formFieldState.context)
                            .textTheme
                            .caption
                            .copyWith(
                                color: Theme.of(formFieldState.context)
                                    .errorColor),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
}
