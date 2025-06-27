import 'package:flutter/material.dart';
import 'package:qassimha/models/group.dart';

class BalanceScreen extends StatelessWidget {
  final Group group;

  const BalanceScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final balances = group.getBalances();
    final settlements = _calculateSettlements(balances);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Balances'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Individual Balances',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...balances.entries.map((entry) {
                    final isPositive = entry.value > 0;
                    final isZero = entry.value.abs() < 0.01;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            isZero
                                ? 'Settled'
                                : '${isPositive ? '+' : ''}\$${entry.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isZero
                                  ? Colors.grey
                                  : isPositive
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (settlements.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Suggested Settlements',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...settlements.map((settlement) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                        "${settlement['from']} owes ${settlement['to']} \$${(settlement['amount'] as double).toStringAsFixed(2)}",

                          style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const Icon(Icons.arrow_forward, color: Colors.blue),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _calculateSettlements(Map<String, double> balances) {
    final List<Map<String, dynamic>> settlements = [];
    final creditors = <String, double>{};
    final debtors = <String, double>{};

    // Separate creditors and debtors
    balances.forEach((person, balance) {
      if (balance > 0.01) {
        creditors[person] = balance;
      } else if (balance < -0.01) {
        debtors[person] = -balance;
      }
    });

    // Calculate settlements
    final creditorsList = creditors.entries.toList();
    final debtorsList = debtors.entries.toList();

    for (var debtor in debtorsList) {
      double remainingDebt = debtor.value;

      for (var creditor in creditorsList) {
        if (remainingDebt <= 0.01) break;

        double currentCredit = creditors[creditor.key] ?? 0;
        if (currentCredit <= 0.01) continue;

        double settlementAmount = remainingDebt < currentCredit ? remainingDebt : currentCredit;

        settlements.add({
          'from': debtor.key,
          'to': creditor.key,
          'amount': settlementAmount,
        });

        creditors[creditor.key] = currentCredit - settlementAmount;
        remainingDebt -= settlementAmount;
      }
    }

    return settlements;
  }
}