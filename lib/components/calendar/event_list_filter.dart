import 'package:flutter/material.dart';
import 'package:dw_flutter_app/constants/event_constants.dart';
import 'package:dw_flutter_app/utility/string_utility.dart';

class EventListFilter extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onSelected;

  const EventListFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map(
            (category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FilterChip(
                  label: Text(capitalize(category)),
                  avatar: Icon(
                    EventConstants.getIcon(category),
                    color: selectedCategory == category
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  selected: selectedCategory ==
                      EventConstants.getUnifiedCategoryName(category),
                  onSelected: (bool selected) {
                    onSelected(selected ? category : null);
                  },
                  showCheckmark: false,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle: TextStyle(
                    color: selectedCategory == category
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: selectedCategory == category
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
