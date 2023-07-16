import 'dart:typed_data';

import 'package:expense_tracker/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IncomeExpenseController extends GetxController {
  RxString selectCategory = "Select Category".obs;
  RxString selectedDate =
      "${DateFormat('dd-MM-yyyy').format(DateTime.now())}".obs;
  RxString selectedTime = "${TimeOfDay.now()}".obs;
  RxInt selectStatus = 0.obs;
  RxList dbDataList = [].obs;
  RxString imaegePath = "".obs;
  Uint8List? byte;
  RxList cateList = <String>[
    'Select Category',
    'Food',
    'Salary',
    'Sales',
    'Purchased',
    'Rent',
    'Repair',
    'Entertainment',
    'Travel',
    'Education',
  ].obs;
  Future<void> transactionData() async {
    DBhelper dBhelper = DBhelper();
    dbDataList.value = await dBhelper.readDB();
    print(dbDataList.length);
    calRs();
  }

  Future<void> readCateDB({required category}) async {
    DBhelper dBhelper = DBhelper();
    dbDataList.value = await dBhelper.cateReadDB(category: category);
    print(dbDataList.length);
    calRs();
  }

  RxInt incomeRs = 0.obs;
  RxInt expenseRs = 0.obs;
  void calRs()
  {
    incomeRs.value=0;
    expenseRs.value=0;
    dbDataList.forEach((element)
    {
      if(element['status']==0)
      {
        incomeRs=incomeRs+element['amount'];
      }
      else
        {
          expenseRs=expenseRs+element['amount'];
        }
    }
    );
  }
}
