// // import 'dart:io';
// //
// // import 'package:path_provider/path_provider.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart' as pw;
// // import 'package:share_plus/share_plus.dart';
// //
// // import '../models/group.dart';
// //
// // class PdfService {
// //   static Future<void> generateAndSharePdf(Group group) async {
// //     final pdf = pw.Document();
// //     final balances = group.getBalances();
// //     final settlements = _calculateSettlements(balances);
// //
// //     pdf.addPage(
// //       pw.Page(
// //         pageFormat: PdfPageFormat.a4,
// //         build: (pw.Context context) {
// //           return pw.Column(
// //             crossAxisAlignment: pw.CrossAxisAlignment.start,
// //             children: [
// //               // Header
// //               pw.Text(
// //                 'Qassimha - Expense Report',
// //                 style: pw.TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: pw.FontWeight.bold,
// //                 ),
// //               ),
// //               pw.SizedBox(height: 10),
// //               pw.Text(
// //                 'Group: ${group.name}',
// //                 style: pw.TextStyle(fontSize: 18),
// //               ),
// //               pw.Text(
// //                 'Generated on: ${DateTime.now().toString().split(' ')[0]}',
// //                 style: pw.TextStyle(fontSize: 12, color: PdfColors.grey),
// //               ),
// //               pw.SizedBox(height: 20),
// //
// //               // Summary
// //               pw.Container(
// //                 padding: const pw.EdgeInsets.all(12),
// //                 decoration: pw.BoxDecoration(
// //                   border: pw.Border.all(color: PdfColors.grey300),
// //                   borderRadius: const pw.BorderRadius.all(
// //                     pw.Radius.circular(5),
// //                   ),
// //                 ),
// //                 child: pw.Row(
// //                   mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
// //                   children: [
// //                     pw.Column(
// //                       children: [
// //                         pw.Text(
// //                           '${group.expenses.length}',
// //                           style: pw.TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: pw.FontWeight.bold,
// //                           ),
// //                         ),
// //                         pw.Text('Total Expenses'),
// //                       ],
// //                     ),
// //                     pw.Column(
// //                       children: [
// //                         pw.Text(
// //                           '\${group.totalExpenses.toStringAsFixed(2)}',
// //                           style: pw.TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: pw.FontWeight.bold,
// //                           ),
// //                         ),
// //                         pw.Text('Total Amount'),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               pw.SizedBox(height: 20),
// //
// //               // Expenses Table
// //               pw.Text(
// //                 'Expenses',
// //                 style: pw.TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: pw.FontWeight.bold,
// //                 ),
// //               ),
// //               pw.SizedBox(height: 10),
// //               pw.Table(
// //                 border: pw.TableBorder.all(color: PdfColors.grey300),
// //                 children: [
// //                   // Header
// //                   pw.TableRow(
// //                     decoration: const pw.BoxDecoration(
// //                       color: PdfColors.grey100,
// //                     ),
// //                     children: [
// //                       pw.Padding(
// //                         padding: const pw.EdgeInsets.all(8),
// //                         child: pw.Text(
// //                           'Description',
// //                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
// //                         ),
// //                       ),
// //                       pw.Padding(
// //                         padding: const pw.EdgeInsets.all(8),
// //                         child: pw.Text(
// //                           'Amount',
// //                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
// //                         ),
// //                       ),
// //                       pw.Padding(
// //                         padding: const pw.EdgeInsets.all(8),
// //                         child: pw.Text(
// //                           'Paid By',
// //                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
// //                         ),
// //                       ),
// //                       pw.Padding(
// //                         padding: const pw.EdgeInsets.all(8),
// //                         child: pw.Text(
// //                           'Date',
// //                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   // Data rows
// //                   ...group.expenses.map(
// //                     (expense) => pw.TableRow(
// //                       children: [
// //                         pw.Padding(
// //                           padding: const pw.EdgeInsets.all(8),
// //                           child: pw.Text(expense.description),
// //                         ),
// //                         pw.Padding(
// //                           padding: const pw.EdgeInsets.all(8),
// //                           child: pw.Text(
// //                             '\${expense.amount.toStringAsFixed(2)}',
// //                           ),
// //                         ),
// //                         pw.Padding(
// //                           padding: const pw.EdgeInsets.all(8),
// //                           child: pw.Text(expense.paidBy),
// //                         ),
// //                         pw.Padding(
// //                           padding: const pw.EdgeInsets.all(8),
// //                           child: pw.Text(
// //                             '${expense.date.day}/${expense.date.month}/${expense.date.year}',
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               pw.SizedBox(height: 20),
// //
// //               // Balances
// //               pw.Text(
// //                 'Final Balances',
// //                 style: pw.TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: pw.FontWeight.bold,
// //                 ),
// //               ),
// //               pw.SizedBox(height: 10),
// //               pw.Table(
// //                 border: pw.TableBorder.all(color: PdfColors.grey300),
// //                 children: [
// //                   // Header
// //                   pw.TableRow(
// //                     decoration: const pw.BoxDecoration(
// //                       color: PdfColors.grey100,
// //                     ),
// //                     children: [
// //                       pw.Padding(
// //                         padding: const pw.EdgeInsets.all(8),
// //                         child: pw.Text(
// //                           'Member',
// //                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
// //                         ),
// //                       ),
// //                       pw.Padding(
// //                         padding: const pw.EdgeInsets.all(8),
// //                         child: pw.Text(
// //                           'Balance',
// //                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   // Data rows
// //                   ...balances.entries.map(
// //                     (entry) => pw.TableRow(
// //                       children: [
// //                         pw.Padding(
// //                           padding: const pw.EdgeInsets.all(8),
// //                           child: pw.Text(entry.key),
// //                         ),
// //                         pw.Padding(
// //                           padding: const pw.EdgeInsets.all(8),
// //                           child: pw.Text(
// //                             entry.value.abs() < 0.01
// //                                 ? 'Settled'
// //                                 : '${entry.value > 0 ? '+' : ''}\${entry.value.toStringAsFixed(2)}',
// //                             style: pw.TextStyle(
// //                               color: entry.value.abs() < 0.01
// //                                   ? PdfColors.grey
// //                                   : entry.value > 0
// //                                   ? PdfColors.green
// //                                   : PdfColors.red,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //
// //               // Settlements
// //               if (settlements.isNotEmpty) ...[
// //                 pw.SizedBox(height: 20),
// //                 pw.Text(
// //                   'Suggested Settlements',
// //                   style: pw.TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: pw.FontWeight.bold,
// //                   ),
// //                 ),
// //                 pw.SizedBox(height: 10),
// //                 ...settlements.map(
// //                   (settlement) => pw.Container(
// //                     margin: const pw.EdgeInsets.only(bottom: 8),
// //                     padding: const pw.EdgeInsets.all(12),
// //                     decoration: pw.BoxDecoration(
// //                       border: pw.Border.all(color: PdfColors.blue300),
// //                       borderRadius: const pw.BorderRadius.all(
// //                         pw.Radius.circular(5),
// //                       ),
// //                     ),
// //                     child: pw.Text(
// //                       "${settlement['from']} owes ${settlement['to']} \$${(settlement['amount'] as num).toStringAsFixed(2)}",
// //                       style: const pw.TextStyle(fontSize: 14),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //
// //     // Save and share the PDF
// //     final output = await getTemporaryDirectory();
// //     final file = File(
// //       '${output.path}/qassimha_${group.name.replaceAll(' ', '_')}_report.pdf',
// //     );
// //     await file.writeAsBytes(await pdf.save());
// //
// //     await Share.shareXFiles([
// //       XFile(file.path),
// //     ], text: 'Expense report for ${group.name}');
// //   }
// //
// //   static List<Map<String, dynamic>> _calculateSettlements(
// //     Map<String, double> balances,
// //   ) {
// //     final List<Map<String, dynamic>> settlements = [];
// //     final creditors = <String, double>{};
// //     final debtors = <String, double>{};
// //
// //     // Separate creditors and debtors
// //     balances.forEach((person, balance) {
// //       if (balance > 0.01) {
// //         creditors[person] = balance;
// //       } else if (balance < -0.01) {
// //         debtors[person] = -balance;
// //       }
// //     });
// //
// //     // Calculate settlements
// //     final creditorsList = creditors.entries.toList();
// //     final debtorsList = debtors.entries.toList();
// //
// //     for (var debtor in debtorsList) {
// //       double remainingDebt = debtor.value;
// //
// //       for (var creditor in creditorsList) {
// //         if (remainingDebt <= 0.01) break;
// //
// //         double currentCredit = creditors[creditor.key] ?? 0;
// //         if (currentCredit <= 0.01) continue;
// //
// //         double settlementAmount = remainingDebt < currentCredit
// //             ? remainingDebt
// //             : currentCredit;
// //
// //         settlements.add({
// //           'from': debtor.key,
// //           'to': creditor.key,
// //           'amount': settlementAmount,
// //         });
// //
// //         creditors[creditor.key] = currentCredit - settlementAmount;
// //         remainingDebt -= settlementAmount;
// //       }
// //     }
// //
// //     return settlements;
// //   }
// // }
//
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:share_plus/share_plus.dart';
// import '../models/group.dart';
//
// class PdfService {
//   static Future<void> generateAndSharePdf(Group group) async {
//     final pdf = pw.Document();
//
//     final balances = group.getBalances();
//     final settlements = _calculateSettlements(balances);
//
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.all(24),
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               // Header
//               pw.Text(
//                 'Qassimha - Expense Report',
//                 style: pw.TextStyle(
//                   fontSize: 24,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//               pw.SizedBox(height: 8),
//               pw.Text(
//                 'Group: ${group.name}',
//                 style: pw.TextStyle(fontSize: 16),
//               ),
//               pw.Text(
//                 'Generated on: ${DateTime.now().toString().split(' ')[0]}',
//                 style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
//               ),
//               pw.Divider(thickness: 1),
//               pw.SizedBox(height: 16),
//
//               // Summary
//               pw.Container(
//                 padding: const pw.EdgeInsets.all(12),
//                 decoration: pw.BoxDecoration(
//                   border: pw.Border.all(color: PdfColors.grey300),
//                   borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
//                 ),
//                 child: pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _summaryItem('${group.expenses.length}', 'Total Expenses'),
//                     _summaryItem('${group.totalExpenses.toStringAsFixed(2)} \$', 'Total Amount'),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//
//               // Expenses Table
//               pw.Text(
//                 'Expenses',
//                 style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.SizedBox(height: 10),
//               pw.Table(
//                 border: pw.TableBorder.all(color: PdfColors.grey300),
//                 columnWidths: {
//                   0: const pw.FlexColumnWidth(3),
//                   1: const pw.FlexColumnWidth(2),
//                   2: const pw.FlexColumnWidth(2),
//                   3: const pw.FlexColumnWidth(2),
//                 },
//                 children: [
//                   // Header
//                   pw.TableRow(
//                     decoration: const pw.BoxDecoration(color: PdfColors.grey100),
//                     children: _tableHeaders(['Description', 'Amount', 'Paid By', 'Date']),
//                   ),
//                   // Data
//                   ...group.expenses.map(
//                         (expense) => pw.TableRow(
//                       children: [
//                         _tableCell(expense.description),
//                         _tableCell('${expense.amount.toStringAsFixed(2)} \$'),
//                         _tableCell(expense.paidBy),
//                         _tableCell('${expense.date.day}/${expense.date.month}/${expense.date.year}'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               pw.SizedBox(height: 20),
//               pw.Divider(thickness: 1),
//
//               // Final Balances
//               pw.Text(
//                 'Final Balances',
//                 style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
//               ),
//               pw.SizedBox(height: 10),
//               pw.Table(
//                 border: pw.TableBorder.all(color: PdfColors.grey300),
//                 columnWidths: {
//                   0: const pw.FlexColumnWidth(3),
//                   1: const pw.FlexColumnWidth(2),
//                 },
//                 children: [
//                   pw.TableRow(
//                     decoration: const pw.BoxDecoration(color: PdfColors.grey100),
//                     children: _tableHeaders(['Member', 'Balance']),
//                   ),
//                   ...balances.entries.map(
//                         (entry) => pw.TableRow(
//                       children: [
//                         _tableCell(entry.key),
//                         _tableCell(
//                           entry.value.abs() < 0.01
//                               ? 'Settled'
//                               : '${entry.value > 0 ? '+' : ''}${entry.value.toStringAsFixed(2)} \$',
//                           color: entry.value.abs() < 0.01
//                               ? PdfColors.grey
//                               : entry.value > 0
//                               ? PdfColors.green
//                               : PdfColors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               // Settlements
//               if (settlements.isNotEmpty) ...[
//                 pw.SizedBox(height: 20),
//                 pw.Divider(thickness: 1),
//                 pw.Text(
//                   'Suggested Settlements',
//                   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
//                 ),
//                 pw.SizedBox(height: 10),
//                 ...settlements.map(
//                       (settlement) => pw.Container(
//                     margin: const pw.EdgeInsets.only(bottom: 8),
//                     padding: const pw.EdgeInsets.all(10),
//                     decoration: pw.BoxDecoration(
//                       border: pw.Border.all(color: PdfColors.blue300),
//                       borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
//                     ),
//                     child: pw.Text(
//                       "${settlement['from']} owes ${settlement['to']} \$${(settlement['amount'] as num).toStringAsFixed(2)}",
//                       style: const pw.TextStyle(fontSize: 12),
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           );
//         },
//       ),
//     );
//
//     // Save and share
//     final output = await getTemporaryDirectory();
//     final file = File('${output.path}/qassimha_${group.name.replaceAll(' ', '_')}_report.pdf');
//     await file.writeAsBytes(await pdf.save());
//
//     await Share.shareXFiles(
//       [XFile(file.path)],
//       text: 'Expense report for ${group.name}',
//     );
//   }
//
//   static pw.Widget _summaryItem(String value, String label) {
//     return pw.Column(
//       children: [
//         pw.Text(
//           value,
//           style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.Text(label),
//       ],
//     );
//   }
//
//   static List<pw.Widget> _tableHeaders(List<String> titles) {
//     return titles
//         .map((title) => pw.Padding(
//       padding: const pw.EdgeInsets.all(8),
//       child: pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//     ))
//         .toList();
//   }
//
//   static pw.Widget _tableCell(String text, {PdfColor? color}) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.all(8),
//       child: pw.Text(
//         text,
//         style: color != null ? pw.TextStyle(color: color) : null,
//       ),
//     );
//   }
//
//   static List<Map<String, dynamic>> _calculateSettlements(Map<String, double> balances) {
//     final List<Map<String, dynamic>> settlements = [];
//     final creditors = <String, double>{};
//     final debtors = <String, double>{};
//
//     balances.forEach((person, balance) {
//       if (balance > 0.01) {
//         creditors[person] = balance;
//       } else if (balance < -0.01) {
//         debtors[person] = -balance;
//       }
//     });
//
//     final creditorsList = creditors.entries.toList();
//     final debtorsList = debtors.entries.toList();
//
//     for (var debtor in debtorsList) {
//       double remainingDebt = debtor.value;
//
//       for (var creditor in creditorsList) {
//         if (remainingDebt <= 0.01) break;
//
//         double currentCredit = creditors[creditor.key] ?? 0;
//         if (currentCredit <= 0.01) continue;
//
//         double settlementAmount = remainingDebt < currentCredit ? remainingDebt : currentCredit;
//
//         settlements.add({
//           'from': debtor.key,
//           'to': creditor.key,
//           'amount': settlementAmount,
//         });
//
//         creditors[creditor.key] = currentCredit - settlementAmount;
//         remainingDebt -= settlementAmount;
//       }
//     }
//
//     return settlements;
//   }
// }

import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../models/group.dart';

class PdfService {
  static Future<void> generateAndSharePdf(Group group) async {
    final pdf = pw.Document();

    // تحميل الخط العربي من assets
    final arabicFontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
    final arabicFont = pw.Font.ttf(arabicFontData);

    final balances = group.getBalances();
    final settlements = _calculateSettlements(balances);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl, // اتجاه من اليمين إلى اليسار
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'تقرير المصاريف - قسّمه',
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'المجموعة: ${group.name}',
                  style: pw.TextStyle(font: arabicFont, fontSize: 16),
                ),
                pw.Text(
                  'تاريخ الإنشاء: ${DateTime.now().toString().split(' ')[0]}',
                  style: pw.TextStyle(font: arabicFont, fontSize: 10, color: PdfColors.grey700),
                ),
                pw.Divider(thickness: 1),
                pw.SizedBox(height: 16),

                // الملخص
                pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      _summaryItem('${group.expenses.length}', 'إجمالي المصاريف', arabicFont),
                      _summaryItem('${group.totalExpenses.toStringAsFixed(2)} ر.س', 'المبلغ الكلي', arabicFont),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),

                // جدول المصاريف
                pw.Text(
                  'المصاريف',
                  style: pw.TextStyle(font: arabicFont, fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    // رأس الجدول
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                      children: _tableHeaders(['الوصف', 'المبلغ', 'الدافع', 'التاريخ'], arabicFont),
                    ),
                    // بيانات المصاريف
                    ...group.expenses.map(
                          (expense) => pw.TableRow(
                        children: [
                          _tableCell(expense.description, arabicFont),
                          _tableCell('${expense.amount.toStringAsFixed(2)} ر.س', arabicFont),
                          _tableCell(expense.paidBy, arabicFont),
                          _tableCell('${expense.date.day}/${expense.date.month}/${expense.date.year}', arabicFont),
                        ],
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),
                pw.Divider(thickness: 1),

                // الأرصدة النهائية
                pw.Text(
                  'الأرصدة النهائية',
                  style: pw.TextStyle(font: arabicFont, fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                      children: _tableHeaders(['العضو', 'الرصيد'], arabicFont),
                    ),
                    ...balances.entries.map(
                          (entry) => pw.TableRow(
                        children: [
                          _tableCell(entry.key, arabicFont),
                          _tableCell(
                            entry.value.abs() < 0.01
                                ? 'تم التسوية'
                                : '${entry.value > 0 ? '+' : ''}${entry.value.toStringAsFixed(2)} ر.س',
                            arabicFont,
                            color: entry.value.abs() < 0.01
                                ? PdfColors.grey
                                : entry.value > 0
                                ? PdfColors.green
                                : PdfColors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (settlements.isNotEmpty) ...[
                  pw.SizedBox(height: 20),
                  pw.Divider(thickness: 1),
                  pw.Text(
                    'التسويات المقترحة',
                    style: pw.TextStyle(font: arabicFont, fontSize: 18, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 10),
                  ...settlements.map(
                        (settlement) => pw.Container(
                      margin: const pw.EdgeInsets.only(bottom: 8),
                      padding: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.blue300),
                        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
                      ),
                      child: pw.Text(
                        "${settlement['from']} مدين لـ ${settlement['to']} بمبلغ ${ (settlement['amount'] as num).toStringAsFixed(2)} ر.س",
                        style: pw.TextStyle(font: arabicFont, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );

    // حفظ ومشاركة ملف PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/qassimha_${group.name.replaceAll(' ', '_')}_report.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'تقرير المصاريف للمجموعة ${group.name}',
    );
  }

  static pw.Widget _summaryItem(String value, String label, pw.Font font) {
    return pw.Column(
      children: [
        pw.Text(
          value,
          style: pw.TextStyle(font: font, fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(label, style: pw.TextStyle(font: font)),
      ],
    );
  }

  static List<pw.Widget> _tableHeaders(List<String> titles, pw.Font font) {
    return titles
        .map((title) => pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(title, style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
    ))
        .toList();
  }

  static pw.Widget _tableCell(String text, pw.Font font, {PdfColor? color}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(text, style: pw.TextStyle(font: font, color: color)),
    );
  }

  static List<Map<String, dynamic>> _calculateSettlements(Map<String, double> balances) {
    final List<Map<String, dynamic>> settlements = [];
    final creditors = <String, double>{};
    final debtors = <String, double>{};

    balances.forEach((person, balance) {
      if (balance > 0.01) {
        creditors[person] = balance;
      } else if (balance < -0.01) {
        debtors[person] = -balance;
      }
    });

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
