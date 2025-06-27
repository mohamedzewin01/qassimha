import 'package:hive/hive.dart';
part 'expense.g.dart';

@HiveType(typeId: 1)
class Expense extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String description;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String paidBy;

  @HiveField(4)
  List<String> participants;

  @HiveField(5)
  DateTime date;

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.participants,
    required this.date,
  });

  double get sharePerPerson => amount / participants.length;
}