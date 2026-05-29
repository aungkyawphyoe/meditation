import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/plan_providers.dart';

class AddPlanScreen extends ConsumerStatefulWidget {
  const AddPlanScreen({super.key});

  @override
  ConsumerState<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends ConsumerState<AddPlanScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _beadsController = TextEditingController(text: '108');
  final _days = <_DayEntry>[];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _beadsController.dispose();
    for (final day in _days) {
      day.dispose();
    }
    super.dispose();
  }

  void _addDay() {
    setState(() {
      _days.add(_DayEntry(
        dayNumber: _days.length + 1,
      ));
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one day')),
      );
      return;
    }

    final dao = ref.read(planDaoProvider);
    final beadsPerRound = int.tryParse(_beadsController.text) ?? 108;

    await dao.addPlan(BeadPlan(
      id: 0,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      isPredefined: false,
      beadsPerRound: beadsPerRound,
      createdAt: DateTime.now(),
    ));

    ref.invalidate(allPlansProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plan created!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F3F0),
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Plan',
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111111),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          children: [
            _buildSectionTitle('Title'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
              style: const TextStyle(fontFamily: 'Geist', fontSize: 16),
              decoration: _inputDecoration('e.g., 21-Day Challenge'),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Description'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              style: const TextStyle(fontFamily: 'Geist', fontSize: 16),
              decoration: _inputDecoration('Optional description'),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Beads per Round'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _beadsController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 16),
              decoration: _inputDecoration('108'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  'Days',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
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
                  style: TextButton.styleFrom(foregroundColor: const Color(0xFFFF8400)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_days.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'Tap "Add Day" to create your plan schedule',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      color: Color(0xFF888888),
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
                targetRoundsController: day.targetRoundsController,
                onRemove: () => _removeDay(i),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F3F0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: _save,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFF8400),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Plan',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Geist',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111111),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontFamily: 'Geist',
        fontSize: 16,
        color: Color(0xFF999999),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFFF8400), width: 1.5),
      ),
    );
  }
}

class _DayEntry {
  int dayNumber;
  final TextEditingController gongDawController;
  final TextEditingController targetRoundsController;

  _DayEntry({
    required this.dayNumber,
  })  : gongDawController = TextEditingController(),
        targetRoundsController = TextEditingController(text: '1');

  void dispose() {
    gongDawController.dispose();
    targetRoundsController.dispose();
  }
}

class _DayCard extends StatelessWidget {
  final int dayNumber;
  final TextEditingController gongDawController;
  final TextEditingController targetRoundsController;
  final VoidCallback onRemove;

  const _DayCard({
    required this.dayNumber,
    required this.gongDawController,
    required this.targetRoundsController,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8400),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '$dayNumber',
                      style: const TextStyle(
                        fontFamily: 'JetBrains Mono',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Day',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF999999)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gong/Daw Name',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF888888),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: gongDawController,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                        style: const TextStyle(fontFamily: 'Geist', fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'e.g., အရဟံ',
                          hintStyle: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 14,
                            color: Color(0xFF999999),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF2F3F0),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Target Rounds',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF888888),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: targetRoundsController,
                        keyboardType: TextInputType.number,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                        style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 14),
                        decoration: InputDecoration(
                          hintText: '1',
                          hintStyle: const TextStyle(
                            fontFamily: 'JetBrains Mono',
                            fontSize: 14,
                            color: Color(0xFF999999),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF2F3F0),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
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
