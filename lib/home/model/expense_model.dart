import 'dart:typed_data';

class ExpenseIncomeModel {
  int? id, amount, status;
  String? date, time, cate, notes;
  Uint8List? imagePath;

  ExpenseIncomeModel(
      {this.id,
      this.amount,
      this.status,
      this.date,
      this.time,
      this.cate,
      this.notes,
      this.imagePath});
}
