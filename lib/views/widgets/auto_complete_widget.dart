
import 'package:flutter/material.dart';

import '../../models/building_plan.dart';

class AutoCompleteInput extends StatelessWidget {
  final List<Building> buildingOptions;
  final Function handleSelect;
  const AutoCompleteInput(
      {Key? key, required this.buildingOptions, required this.handleSelect})
      : super(key: key);
  static String _displayStringForOption(Building option) => option.name;
  @override
  Widget build(BuildContext context) {
    return Autocomplete<Building>(
        onSelected: (selection) => handleSelect(selection),
        displayStringForOption: _displayStringForOption,
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<Building>.empty();
          }
          return buildingOptions.where((option) {
            return option.name
                .toString()
                .contains(textEditingValue.text.toUpperCase());
          });
        });
  }
}
