import 'package:flutter/material.dart';

import '../../../../global/design_system/colors/colors.dart';
import '../../../../global/design_system/sizing/sizing.dart';

class FilterChipLists extends StatelessWidget {
  const FilterChipLists({
    required this.chips,
    required this.onTap,
    required this.oldSelections,
    super.key,
  });

  final List<String> chips;
  final List<String> oldSelections;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: Sp.px8,
        runSpacing: Sp.px8,
        runAlignment: WrapAlignment.center,
        children: <Widget>[
          for (int i = 0; i < chips.length; i++)
            FilterChips(
              text: chips[i],
              onChipsTap: onTap,
              isSelected: oldSelections.contains(chips[i]),
              isDisabled: !oldSelections.contains(chips[i]) &&
                  oldSelections.length >= 3,
            ),
        ],
      ),
    );
  }
}

class FilterChips extends StatelessWidget {
  const FilterChips({
    required this.text,
    required this.isSelected,
    required this.onChipsTap,
    super.key,
    this.isDisabled = false,
  });

  final String text;
  final bool isSelected;
  final bool isDisabled;
  final void Function(String) onChipsTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChipsTap(text),
      child: Container(
        height: Sp.px36,
        decoration: BoxDecoration(
          color: isSelected ? Indra.blue : Indra.white.withOpacity(0.1),
          border: Border.all(
            color: isSelected ? Indra.white : Indra.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Sp.px12,
          vertical: Sp.px4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: isSelected ? Indra.white : Indra.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
