import 'package:flutter/material.dart';
import '../theme.dart';

class PlannerSelection {
  final String day;
  final String mealType;

  const PlannerSelection({required this.day, required this.mealType});
}

class PlannerSheet extends StatefulWidget {
  final String title;
  final String confirmLabel;
  final String initialDay;
  final String initialMealType;
  final VoidCallback? onDelete; 

  const PlannerSheet({
    super.key,
    required this.title,
    required this.confirmLabel,
    this.initialDay = 'Monday',
    this.initialMealType = 'Breakfast',
    this.onDelete,
  });

  static const days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const mealTypes = ['Breakfast', 'Lunch', 'Dinner'];

  static Future<PlannerSelection?> show(
    BuildContext context, {
    required String title,
    required String confirmLabel,
    String initialDay = 'Monday',
    String initialMealType = 'Breakfast',
    VoidCallback? onDelete,
  }) {
    return showModalBottomSheet<PlannerSelection>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => PlannerSheet(
        title: title,
        confirmLabel: confirmLabel,
        initialDay: initialDay,
        initialMealType: initialMealType,
        onDelete: onDelete,
      ),
    );
  }

  @override
  State<PlannerSheet> createState() => _PlannerSheetState();
}

class _PlannerSheetState extends State<PlannerSheet> {
  late String _day = widget.initialDay;
  late String _mealType = widget.initialMealType;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: AppTextStyles.heading.copyWith(fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                ),
              ],
            ),

            _Section(
              label: 'DAY',
              child: DropdownButtonFormField<String>(
                value: _day,
                isExpanded: true,
                dropdownColor: AppColors.surface,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                ),
                style: AppTextStyles.body,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: _border(AppColors.divider),
                  enabledBorder: _border(AppColors.divider),
                  focusedBorder: _border(AppColors.primary),
                ),
                items: [
                  for (final d in PlannerSheet.days)
                    DropdownMenuItem(value: d, child: Text(d)),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _day = v);
                },
              ),
            ),

            _Section(
              label: 'MEAL',
              child: Row(
                spacing: 8,
                children: [
                  for (final m in PlannerSheet.mealTypes)
                    Expanded(
                      child: _OptionChip(
                        label: m,
                        selected: m == _mealType,
                        onTap: () => setState(() => _mealType = m),
                      ),
                    ),
                ],
              ),
            ),

            Row(
              spacing: 12,
              children: [
                if (widget.onDelete != null)
                  SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onDelete!();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.accent,
                        side: const BorderSide(color: AppColors.accent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Icon(Icons.delete_outline),
                    ),
                  ),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(
                        context,
                        PlannerSelection(day: _day, mealType: _mealType),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.check, size: 18),
                      label: Text(widget.confirmLabel, style: AppTextStyles.button),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String label;
  final Widget child;

  const _Section({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          label,
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        child,
      ],
    );
  }
}

class _OptionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OptionChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.onPrimary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}