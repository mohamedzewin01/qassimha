import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:qassimha/models/group.dart';

import '../models/expense.dart';

class GroupsCubit extends Cubit<List<Group>> {
  late Box<Group> _groupsBox;

  GroupsCubit() : super([]) {
    _initHive();
  }

  Future<void> _initHive() async {
    _groupsBox = await Hive.openBox<Group>('groups');
    emit(_groupsBox.values.toList());
  }

  void addGroup(String name, List<String> members) {
    final group = Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      members: members,
      expenses: [],
      createdAt: DateTime.now(),
    );

    _groupsBox.add(group);
    emit(_groupsBox.values.toList());
  }

  void addExpense(String groupId, Expense expense) {
    final groups = List<Group>.from(state);
    final groupIndex = groups.indexWhere((g) => g.id == groupId);

    if (groupIndex != -1) {
      groups[groupIndex].expenses.add(expense);
      groups[groupIndex].save();
      emit(groups);
    }
  }

  void deleteGroup(String groupId) {
    final group = _groupsBox.values.firstWhere((g) => g.id == groupId);
    group.delete();
    emit(_groupsBox.values.toList());
  }

  void deleteExpense(String groupId, String expenseId) {
    final groups = List<Group>.from(state);
    final groupIndex = groups.indexWhere((g) => g.id == groupId);

    if (groupIndex != -1) {
      groups[groupIndex].expenses.removeWhere((e) => e.id == expenseId);
      groups[groupIndex].save();
      emit(groups);
    }
  }
}