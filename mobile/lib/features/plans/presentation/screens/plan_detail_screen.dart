import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/providers/app_database_providers.dart';
import '../../../../core/database/providers/plan_providers.dart';
import '../widgets/day_list_tile.dart';

class PlanDetailScreen extends ConsumerStatefulWidget {
  final int planId;

  const PlanDetailScreen({super.key, required this.planId});

  @override
  ConsumerState<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends ConsumerState<PlanDetailScreen> {
  bool _isEditing = false;
  List<PlanDay> _editableDays = [];
  final Set<int> _deletedDayIds = {};
  bool _isAddingDay = false;
  final _newGongDawController = TextEditingController();
  final _newGongDawDetailController = TextEditingController();
  final _newTargetRoundsController = TextEditingController(text: '1');
  int _nextTempId = -1;
  final _newDayData = <_NewDayData>[];

  @override
  void initState() {
    super.initState();
    _newGongDawController.addListener(_onNewGongDawChanged);
  }

  void _onNewGongDawChanged() {
    setState(() {});
  }

  void _enterEditMode(
    List<PlanDay> planDays,
    UserPlanProgress? activeProgress,
  ) {
    if (activeProgress?.planId == widget.planId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot edit an active plan')),
      );
      return;
    }
    setState(() {
      _editableDays = List.from(planDays);
      _deletedDayIds.clear();
      _isEditing = true;
      _isAddingDay = false;
      _newDayData.clear();
      _nextTempId = -1;
    });
  }

  void _cancelEdit() {
    _newGongDawController.clear();
    _newGongDawDetailController.clear();
    _newTargetRoundsController.text = '1';
    setState(() {
      _isEditing = false;
      _editableDays = [];
      _deletedDayIds.clear();
      _isAddingDay = false;
      _newDayData.clear();
      _nextTempId = -1;
    });
  }

  void _cancelAddDay() {
    setState(() {
      _isAddingDay = false;
    });
    _newGongDawController.clear();
    _newGongDawDetailController.clear();
    _newTargetRoundsController.text = '1';
  }

  void _saveNewDay() {
    final name = _newGongDawController.text.trim();
    if (name.isEmpty) return;

    final data = _NewDayData(
      gongDawName: name,
      gongDawDetail: _newGongDawDetailController.text.trim(),
      targetRounds: int.tryParse(_newTargetRoundsController.text) ?? 1,
    );

    final newDay = PlanDay(
      id: _nextTempId--,
      planId: widget.planId,
      dayNumber: _editableDays.length + 1,
      gongDawId: 0,
      targetRounds: data.targetRounds,
      gongDawName: data.gongDawName,
    );

    setState(() {
      _editableDays.add(newDay);
      _newDayData.add(data);
      _isAddingDay = false;
    });
    _newGongDawController.clear();
    _newGongDawDetailController.clear();
    _newTargetRoundsController.text = '1';
  }

  Future<void> _saveEdit() async {
    final dao = ref.read(planDaoProvider);
    for (final dayId in _deletedDayIds) {
      await dao.deletePlanDay(dayId);
    }

    final existingGongDawDetails = await dao.getAllGongDawDetails();
    var newDayIndex = 0;
    for (var i = 0; i < _editableDays.length; i++) {
      final day = _editableDays[i];
      final newNumber = i + 1;

      if (day.id < 0) {
        final data = _newDayData[newDayIndex++];
        var match = existingGongDawDetails
            .where((d) => d.name == data.gongDawName)
            .firstOrNull;
        int gongDawId;
        if (match != null) {
          gongDawId = match.id;
        } else {
          gongDawId = await dao.addGongDawDetail(
            GongDawDetailsTableCompanion.insert(
              name: data.gongDawName,
              meaning: data.gongDawDetail,
            ),
          );
        }
        await dao.addPlanDay(
          PlanDaysTableCompanion.insert(
            planId: widget.planId,
            dayNumber: newNumber,
            gongDawId: gongDawId,
            targetRounds: data.targetRounds,
            gongDawName: Value(data.gongDawName),
          ),
        );
      } else {
        if (day.dayNumber != newNumber) {
          await dao.updatePlanDayDayNumber(day.id, newNumber);
        }
      }
    }

    ref.invalidate(planDaysProvider(widget.planId));
    setState(() {
      _isEditing = false;
      _editableDays = [];
      _deletedDayIds.clear();
      _newDayData.clear();
      _nextTempId = -1;
    });
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Plan updated')));
    }
  }

  Future<void> _deletePlan(BeadPlan plan) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Plan'),
        content: const Text(
          'Are you sure you want to delete this plan? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final dao = ref.read(planDaoProvider);
    await dao.deletePlan(plan.id);
    ref.invalidate(allPlansProvider);
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final planAsync = ref.watch(planProvider(widget.planId));
    final planDaysAsync = ref.watch(planDaysProvider(widget.planId));
    final userAsync = ref.watch(userInfoProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F3F0),
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _isEditing ? 'Edit Plan' : 'Plan Details',
          style: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111111),
          ),
        ),
        actions: [
          if (!_isEditing &&
              planAsync.valueOrNull != null &&
              !planAsync.valueOrNull!.isPredefined)
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Color(0xFF111111),
              ),
              onSelected: (value) {
                if (value == 'edit') {
                  final planDays = planDaysAsync.valueOrNull ?? [];
                  final activeProgress = ref
                      .read(activePlanProvider(userAsync.valueOrNull?.id ?? -1))
                      .valueOrNull;
                  _enterEditMode(planDays, activeProgress);
                } else if (value == 'delete') {
                  _deletePlan(planAsync.valueOrNull!);
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_rounded, size: 18),
                      SizedBox(width: 10),
                      Text('Edit', style: TextStyle(fontFamily: 'Geist')),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_rounded, size: 18, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        'Delete',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: planAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plan) {
          if (plan == null) {
            return const Center(child: Text('Plan not found'));
          }
          return planDaysAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (planDays) {
              return userAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (user) {
                  return _buildContent(plan, planDays, user?.id);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildContent(BeadPlan plan, List<PlanDay> planDays, int? userId) {
    final activePlanAsync = ref.watch(activePlanProvider(userId ?? -1));

    return activePlanAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (activeProgress) {
        final isThisPlanActive = activeProgress?.planId == plan.id;
        final isCompleted =
            !isThisPlanActive && (activeProgress?.status == 'completed');
        final displayDays = _isEditing ? _editableDays : planDays;

        return Column(
          children: [
            Expanded(
              child: _isEditing
                  ? _buildEditDayList(displayDays)
                  : _buildDayList(
                      plan,
                      planDays,
                      activeProgress,
                      isThisPlanActive,
                      isCompleted,
                    ),
            ),
            _isEditing
                ? _buildEditBottomBar()
                : _BottomAction(
                    isThisPlanActive: isThisPlanActive,
                    isCompleted: isCompleted,
                    onStart: userId != null
                        ? () => _startPlan(context, ref, userId)
                        : null,
                    onCompleteDay: isThisPlanActive && activeProgress != null
                        ? () => _advanceDay(
                            context,
                            ref,
                            activeProgress,
                            planDays.length,
                          )
                        : null,
                    onCompletePlan: isThisPlanActive && activeProgress != null
                        ? () => _finishPlan(context, ref, activeProgress)
                        : null,
                  ),
          ],
        );
      },
    );
  }

  Widget _buildDayList(
    BeadPlan plan,
    List<PlanDay> planDays,
    UserPlanProgress? activeProgress,
    bool isThisPlanActive,
    bool isCompleted,
  ) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (plan.isPredefined)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8400).withAlpha(25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'PREDEFINED',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF8400),
                      letterSpacing: 1,
                    ),
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                plan.title,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${plan.beadsPerRound} beads per round · ${planDays.length} days',
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
              if (plan.description.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  plan.description,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF666666),
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Days',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ...planDays.asMap().entries.map((entry) {
          final day = entry.value;
          final dayNum = entry.key + 1;
          final isCurrent =
              isThisPlanActive && activeProgress!.currentDay == dayNum;
          final isCompletedDay =
              isThisPlanActive && activeProgress!.currentDay > dayNum;

          return DayListTile(
            dayNumber: dayNum,
            planDay: day,
            gongDawName: day.gongDawName ?? 'Day $dayNum',
            isCurrentDay: isCurrent,
            isCompleted: isCompletedDay,
          );
        }),
      ],
    );
  }

  Widget _buildEditDayList(List<PlanDay> days) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Row(
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
                onPressed: () => setState(() => _isAddingDay = true),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text(
                  'Add Day',
                  style: TextStyle(fontFamily: 'Geist', fontSize: 14),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFFF8400),
                ),
              ),
            ],
          ),
        ),
        if (_isAddingDay)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: _AddDayCard(
              dayNumber: days.length + 1,
              gongDawController: _newGongDawController,
              gongDawDetailController: _newGongDawDetailController,
              targetRoundsController: _newTargetRoundsController,
              isValid: _newGongDawController.text.trim().isNotEmpty,
              onSave: _saveNewDay,
              onCancel: _cancelAddDay,
            ),
          ),
        const SizedBox(height: 8),
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            itemCount: days.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final day = _editableDays.removeAt(oldIndex);
                _editableDays.insert(newIndex, day);
              });
            },
            itemBuilder: (context, index) {
              final day = days[index];
              final dayNum = index + 1;

              return Dismissible(
                key: ValueKey(day.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.delete_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                confirmDismiss: (direction) async {
                  return true;
                },
                onDismissed: (direction) {
                  setState(() {
                    _deletedDayIds.add(day.id);
                    _editableDays.removeAt(index);
                  });
                },
                child: Container(
                  key: ValueKey(day.id),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ReorderableDragStartListener(
                          index: index,
                          child: const Icon(
                            Icons.drag_handle_rounded,
                            color: Color(0xFF999999),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '$dayNum',
                              style: const TextStyle(
                                fontFamily: 'JetBrains Mono',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      'Day $dayNum',
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111111),
                      ),
                    ),
                    subtitle: Text(
                      '${day.gongDawName ?? 'Gong/Daw #${day.gongDawId}'} · ${day.targetRounds} rounds',
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF888888),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          _deletedDayIds.add(day.id);
                          _editableDays.removeAt(index);
                        });
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEditBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: _cancelEdit,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF666666),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextButton(
              onPressed: () {
                if (_editableDays.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Plan must have at least one day'),
                    ),
                  );
                  return;
                }
                _saveEdit();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFF8400),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startPlan(BuildContext context, WidgetRef ref, int uid) async {
    final dao = ref.read(planDaoProvider);
    final existingProgress = await dao.getActivePlan(uid);
    if (existingProgress != null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'You already have an active plan. Complete or pause it first.',
          ),
        ),
      );
      return;
    }
    await dao.activatePlan(uid, widget.planId);
    ref.invalidate(activePlanProvider(uid));
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Plan activated!')));
    }
  }

  Future<void> _advanceDay(
    BuildContext context,
    WidgetRef ref,
    UserPlanProgress progress,
    int totalDays,
  ) async {
    if (progress.currentDay >= totalDays) return;
    final dao = ref.read(planDaoProvider);
    await dao.advanceDay(progress.id);
    ref.invalidate(activePlanProvider(userIdForProgress));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Day ${progress.currentDay} complete!')),
      );
    }
  }

  Future<void> _finishPlan(
    BuildContext context,
    WidgetRef ref,
    UserPlanProgress progress,
  ) async {
    final dao = ref.read(planDaoProvider);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Complete Plan'),
        content: const Text(
          'Are you sure you want to mark this plan as complete?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await dao.completePlan(progress.id);
    ref.invalidate(activePlanProvider(userIdForProgress));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plan completed! Great work.')),
      );
      Navigator.pop(context);
    }
  }

  int get userIdForProgress => ref.read(userInfoProvider).valueOrNull?.id ?? -1;

  @override
  void dispose() {
    _newGongDawController.removeListener(_onNewGongDawChanged);
    _newGongDawController.dispose();
    _newGongDawDetailController.dispose();
    _newTargetRoundsController.dispose();
    super.dispose();
  }
}

class _NewDayData {
  final String gongDawName;
  final String gongDawDetail;
  final int targetRounds;

  _NewDayData({
    required this.gongDawName,
    required this.gongDawDetail,
    required this.targetRounds,
  });
}

class _BottomAction extends StatelessWidget {
  final bool isThisPlanActive;
  final bool isCompleted;
  final VoidCallback? onStart;
  final VoidCallback? onCompleteDay;
  final VoidCallback? onCompletePlan;

  const _BottomAction({
    required this.isThisPlanActive,
    required this.isCompleted,
    this.onStart,
    this.onCompleteDay,
    this.onCompletePlan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: isCompleted
              ? null
              : isThisPlanActive
              ? onCompletePlan ?? onCompleteDay
              : onStart,
          style: TextButton.styleFrom(
            backgroundColor: isCompleted
                ? const Color(0xFFE0E0E0)
                : const Color(0xFFFF8400),
            foregroundColor: isCompleted
                ? const Color(0xFF999999)
                : Colors.white,
            disabledBackgroundColor: const Color(0xFFE0E0E0),
            disabledForegroundColor: const Color(0xFF999999),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isCompleted
                ? 'Completed'
                : isThisPlanActive
                ? 'Complete Plan'
                : 'Start This Plan',
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddDayCard extends StatelessWidget {
  final int dayNumber;
  final TextEditingController gongDawController;
  final TextEditingController gongDawDetailController;
  final TextEditingController targetRoundsController;
  final bool isValid;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const _AddDayCard({
    required this.dayNumber,
    required this.gongDawController,
    required this.gongDawDetailController,
    required this.targetRoundsController,
    required this.isValid,
    required this.onSave,
    required this.onCancel,
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
                IconButton(
                  onPressed: isValid ? onSave : null,
                  icon: Icon(
                    Icons.check_rounded,
                    size: 20,
                    color: isValid
                        ? const Color(0xFFFF8400)
                        : const Color(0xFFCCCCCC),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                  splashRadius: 16,
                ),
                GestureDetector(
                  onTap: onCancel,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: Color(0xFF999999),
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
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'e.g., အရဟံ',
                          hintStyle: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 14,
                            color: Color(0xFF999999),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF2F3F0),
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
                Column(
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
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F0),
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
                              child: const Icon(
                                Icons.add_rounded,
                                size: 18,
                                color: Color(0xFFFF8400),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _decrement,
                            child: Container(
                              width: 32,
                              height: 40,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.remove_rounded,
                                size: 18,
                                color: Color(0xFFFF8400),
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
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gong/Daw Detail',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: gongDawDetailController,
                  style: const TextStyle(fontFamily: 'Geist', fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'e.g., ပူဇော်အထူးကို ခံတော်မူထိုက်သော',
                    hintStyle: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14,
                      color: Color(0xFF999999),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF2F3F0),
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
