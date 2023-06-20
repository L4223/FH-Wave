import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/dark_mode_controller.dart';
import '../../models/building_plan.dart';

class AutoCompleteInput extends StatelessWidget {
  final List<Building> buildingOptions;
  final void Function(Building)? handleSelect;

  const AutoCompleteInput(
      {Key? key, required this.buildingOptions, required this.handleSelect})
      : super(key: key);

  static String _displayStringForOption(Building option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeController>(builder: (context, controller, _) {
      return Autocomplete<Building>(
          onSelected: handleSelect,
          displayStringForOption: _displayStringForOption,
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<Building>.empty();
            }
            return buildingOptions.where((option) {
              ShapeDecoration.fromBoxDecoration(context as BoxDecoration).color;
              return option.name
                  .toString()
                  .contains(textEditingValue.text.toUpperCase());
            });
          });
    });
  }
}
