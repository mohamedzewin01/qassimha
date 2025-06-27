import 'package:hive/hive.dart';
import 'package:qassimha/main.dart';

import 'expense.dart';


part 'group.g.dart';
@HiveType(typeId: 0)
class Group extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<String> members;

  @HiveField(3)
  List<Expense> expenses;

  @HiveField(4)
  DateTime createdAt;

  Group({
    required this.id,
    required this.name,
    required this.members,
    required this.expenses,
    required this.createdAt,
  });

  double get totalExpenses {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  Map<String, double> getBalances() {
    Map<String, double> balances = {};

    // Initialize balances
    for (String member in members) {
      balances[member] = 0.0;
    }

    // Calculate balances
    for (Expense expense in expenses) {
      // Add paid amount to payer
      balances[expense.paidBy] = (balances[expense.paidBy] ?? 0) + expense.amount;

      // Subtract share from each participant
      double sharePerPerson = expense.amount / expense.participants.length;
      for (String participant in expense.participants) {
        balances[participant] = (balances[participant] ?? 0) - sharePerPerson;
      }
    }

    return balances;
  }
}