import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/plan_providers.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/theme/app_theme.dart';

class AddPlanScreen extends ConsumerStatefulWidget {
  const AddPlanScreen({super.key});

  @override
  ConsumerState<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends ConsumerState<AddPlanScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _days = <_DayEntry>[];
  final _formKey = GlobalKey<FormState>();
  bool _isRoundsMode = true;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (final day in _days) {
      day.dispose();
    }
    super.dispose();
  }

  void _addDay() {
    setState(() {
      _days.add(_DayEntry(dayNumber: _days.length + 1));
    });
  }

  void _removeDay(int index) {
    setState(() {
      _days[index].dispose();
      _days.removeAt(index);
      for (var i = 0; i < _days.length; i++) {
        _days[i].dayNumber = i + 1;
      }
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_days.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Add at least one day')));
      return;
    }

    final dao = ref.read(planDaoProvider);
    final beadsPerRound = _isRoundsMode ? 108 : 0;

    final planId = await dao.addPlan(
      BeadPlansTableCompanion.insert(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        isPredefined: const Value(false),
        beadsPerRound: Value(beadsPerRound),
        createdAt: DateTime.now(),
      ),
    );

    final existingGongDawDetails = await dao.getAllGongDawDetails();

    for (final day in _days) {
      final name = day.gongDawController.text.trim();

      var match = existingGongDawDetails
          .where((d) => d.name == name)
          .firstOrNull;

      int gongDawId;
      if (match != null) {
        gongDawId = match.id;
      } else {
        gongDawId = await dao.addGongDawDetail(
          GongDawDetailsTableCompanion.insert(
            name: name,
            meaning: day.gongDawDetailController.text.trim(),
          ),
        );
      }

      await dao.addPlanDay(
        PlanDaysTableCompanion.insert(
          planId: planId,
          dayNumber: day.dayNumber,
          gongDawId: gongDawId,
          targetRounds: int.tryParse(day.targetRoundsController.text) ?? 1,
          gongDawName: Value(name),
        ),
      );
    }

    ref.invalidate(allPlansProvider);
    ref.invalidate(planDaysProvider(planId));

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Plan created!')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New Plan',
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colors.foreground,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          children: [
            const AppSectionTitle(text: 'Title'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                color: colors.foreground,
              ),
              decoration: _inputDecoration('e.g., 21-Day Challenge'),
            ),
            const SizedBox(height: 20),
            const AppSectionTitle(text: 'Description'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                color: colors.foreground,
              ),
              decoration: _inputDecoration('Optional description'),
            ),
            const SizedBox(height: 20),
            const AppSectionTitle(text: 'Mode'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isRoundsMode = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isRoundsMode
                              ? colors.card
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _isRoundsMode
                              ? [
                                  BoxShadow(
                                    color: colors.foreground.withValues(alpha: 0.06),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'Rounds',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colors.foreground,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isRoundsMode = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isRoundsMode
                              ? Colors.transparent
                              : colors.card,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _isRoundsMode
                              ? null
                              : [
                                  BoxShadow(
                                    color: colors.foreground.withValues(alpha: 0.06),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                        ),
                        child: Center(
                          child: Text(
                            'Continuous',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colors.foreground,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Days',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.foreground,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _addDay,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text(
                    'Add Day',
                    style: TextStyle(fontFamily: 'Geist', fontSize: 14),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: colors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_days.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'Tap "Add Day" to create your plan schedule',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      color: colors.mutedForeground,
                    ),
                  ),
                ),
              ),
            ..._days.asMap().entries.map((entry) {
              final i = entry.key;
              final day = entry.value;
              return _DayCard(
                dayNumber: day.dayNumber,
                gongDawController: day.gongDawController,
                gongDawDetailController: day.gongDawDetailController,
                targetRoundsController: day.targetRoundsController,
                isRoundsMode: _isRoundsMode,
                onRemove: () => _removeDay(i),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        decoration: BoxDecoration(
          color: colors.background,
          boxShadow: [
            BoxShadow(
              color: colors.foreground.withValues(alpha:0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: AppButton.primary(
            label: 'Save Plan',
            onPressed: _save,
            height: 16,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    final colors = context.colors;
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: 'Geist',
        fontSize: 16,
        color: colors.mutedForeground,
      ),
      filled: true,
      fillColor: colors.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colors.primary, width: 1.5),
      ),
    );
  }
}

class _DayEntry {
  int dayNumber;
  final TextEditingController gongDawController;
  final TextEditingController gongDawDetailController;
  final TextEditingController targetRoundsController;

  _DayEntry({required this.dayNumber})
    : gongDawController = TextEditingController(),
      gongDawDetailController = TextEditingController(),
      targetRoundsController = TextEditingController(text: '1');

  void dispose() {
    gongDawController.dispose();
    gongDawDetailController.dispose();
    targetRoundsController.dispose();
  }
}

class _DayCard extends StatelessWidget {
  final int dayNumber;
  final TextEditingController gongDawController;
  final TextEditingController gongDawDetailController;
  final TextEditingController targetRoundsController;
  final bool isRoundsMode;
  final VoidCallback onRemove;

  const _DayCard({
    required this.dayNumber,
    required this.gongDawController,
    required this.gongDawDetailController,
    required this.targetRoundsController,
    required this.isRoundsMode,
    required this.onRemove,
  });

  void _increment() {
    final current = int.tryParse(targetRoundsController.text) ?? 1;
    targetRoundsController.text = '${current + 1}';
  }

  void _decrement() {
    final current = int.tryParse(targetRoundsController.text) ?? 1;
    if (current > 1) {
      targetRoundsController.text = '${current - 1}';
    }
  }

  Widget _buildTargetField(BuildContext context) {
    final colors = context.colors;
    if (isRoundsMode) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Target Rounds',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 48,
                  child: TextFormField(
                    controller: targetRoundsController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                    style: const TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _increment,
                  child: Container(
                    width: 32,
                    height: 40,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add_rounded,
                      size: 18,
                      color: colors.primary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _decrement,
                  child: Container(
                    width: 32,
                    height: 40,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.remove_rounded,
                      size: 18,
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bead Counts',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: targetRoundsController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'e.g., 500',
                hintStyle: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14,
                  color: colors.mutedForeground,
                ),
                filled: true,
                fillColor: colors.secondary,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppDayIndicator(number: dayNumber),
                const SizedBox(width: 10),
                Text(
                  'Day',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.foreground,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onRemove,
                  child: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: colors.mutedForeground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gong/Daw Name',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: colors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: gongDawController,
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 14,
                          color: colors.foreground,
                        ),
                        decoration: InputDecoration(
                          hintText: 'e.g., အရဟံ',
                          hintStyle: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 14,
                            color: colors.mutedForeground,
                          ),
                          filled: true,
                          fillColor: colors.secondary,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _buildTargetField(context),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gong/Daw Detail',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: colors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: gongDawDetailController,
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    color: colors.foreground,
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g., ပူဇော်အထူးကို ခံတော်မူထိုက်သော',
                    hintStyle: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      color: colors.mutedForeground,
                    ),
                    filled: true,
                    fillColor: colors.secondary,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
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
