import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemAsString;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final double? maxHeight;

  const CustomDropdown({
    super.key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    required this.itemAsString,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.contentPadding,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<T>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemAsString(item),
                style: theme.textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: enabled ? onChanged : null,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: theme.brightness == Brightness.light
                ? AppColors.gray50
                : AppColors.gray800,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.brightness == Brightness.light
                    ? AppColors.borderLight
                    : AppColors.borderDark,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.brightness == Brightness.light
                    ? AppColors.primary
                    : AppColors.primaryLight,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
          ),
          menuMaxHeight: maxHeight ?? 300,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.gray400,
          ),
        ),
      ],
    );
  }
}

class MultiSelectDropdown<T> extends StatefulWidget {
  final String? label;
  final String? hint;
  final List<T> selectedValues;
  final List<T> items;
  final String Function(T) itemAsString;
  final void Function(List<T>)? onChanged;
  final String? Function(List<T>?)? validator;
  final bool enabled;
  final Widget? prefixIcon;
  final int? maxSelections;
  final bool showChips;

  const MultiSelectDropdown({
    super.key,
    this.label,
    this.hint,
    required this.selectedValues,
    required this.items,
    required this.itemAsString,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.maxSelections,
    this.showChips = true,
  });

  @override
  State<MultiSelectDropdown<T>> createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  late List<T> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.selectedValues);
  }

  @override
  void didUpdateWidget(MultiSelectDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValues != oldWidget.selectedValues) {
      _selectedValues = List.from(widget.selectedValues);
    }
  }

  void _showMultiSelectDialog() async {
    final result = await showDialog<List<T>>(
      context: context,
      builder: (context) => _MultiSelectDialog<T>(
        title: widget.label ?? 'Select Items',
        items: widget.items,
        selectedItems: _selectedValues,
        itemAsString: widget.itemAsString,
        maxSelections: widget.maxSelections,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedValues = result;
      });
      widget.onChanged?.call(_selectedValues);
    }
  }

  void _removeItem(T item) {
    setState(() {
      _selectedValues.remove(item);
    });
    widget.onChanged?.call(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
        ],
        InkWell(
          onTap: widget.enabled ? _showMultiSelectDialog : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.light
                  ? AppColors.gray50
                  : AppColors.gray800,
              border: Border.all(
                color: theme.brightness == Brightness.light
                    ? AppColors.borderLight
                    : AppColors.borderDark,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  widget.prefixIcon!,
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: _selectedValues.isEmpty
                      ? Text(
                          widget.hint ?? 'Select items',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.gray400,
                          ),
                        )
                      : Text(
                          '${_selectedValues.length} items selected',
                          style: theme.textTheme.bodyMedium,
                        ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.gray400,
                ),
              ],
            ),
          ),
        ),
        if (widget.showChips && _selectedValues.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _selectedValues.map((item) {
              return Chip(
                label: Text(
                  widget.itemAsString(item),
                  style: theme.textTheme.bodySmall,
                ),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 18,
                ),
                onDeleted: widget.enabled ? () => _removeItem(item) : null,
                backgroundColor: theme.brightness == Brightness.light
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.primaryLight.withOpacity(0.2),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

class _MultiSelectDialog<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemAsString;
  final int? maxSelections;

  const _MultiSelectDialog({
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.itemAsString,
    this.maxSelections,
  });

  @override
  State<_MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<_MultiSelectDialog<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  void _onItemToggle(T item, bool selected) {
    setState(() {
      if (selected) {
        if (widget.maxSelections == null ||
            _selectedItems.length < widget.maxSelections!) {
          _selectedItems.add(item);
        }
      } else {
        _selectedItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final isSelected = _selectedItems.contains(item);
            final canSelect = widget.maxSelections == null ||
                _selectedItems.length < widget.maxSelections! ||
                isSelected;

            return CheckboxListTile(
              title: Text(widget.itemAsString(item)),
              value: isSelected,
              onChanged: canSelect
                  ? (selected) => _onItemToggle(item, selected ?? false)
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_selectedItems),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
