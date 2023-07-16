import 'dart:io';

import 'package:expense_tracker/controller/InEx_controller.dart';
import 'package:expense_tracker/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../home/model/expense_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Map map = Get.arguments;
  IncomeExpenseController controller = Get.put(IncomeExpenseController());
  TextEditingController txtAomunt = TextEditingController();
  TextEditingController txtNote = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(map['status']==0)
      {
        int index=map['index'];
        txtAomunt = TextEditingController(text: controller.dbDataList[index]['amount'].toString());
        txtNote = TextEditingController(text: controller.dbDataList[index]['note']);
        controller.selectCategory.value=controller.dbDataList[index]['category'];
        controller.selectedDate.value=controller.dbDataList[index]['date'];
        controller.selectedTime.value=controller.dbDataList[index]['time'];
        controller.selectStatus.value=controller.dbDataList[index]['status'];
      }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title:  map['status']==0?const Text(
            "Update Entry",
            style: TextStyle(letterSpacing: 1),
          ):const Text(
        "Add Entry",
        style: TextStyle(letterSpacing: 1),
      ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if(map['status']==0)
              {
                DBhelper dBhelper = DBhelper();
                ExpenseIncomeModel model = ExpenseIncomeModel(
                  time: controller.selectedTime.value,
                  notes: txtNote.text,
                  date: controller.selectedDate.value,
                  cate: controller.selectCategory.value,
                  amount: int.parse(txtAomunt.text),
                  status: controller.selectStatus.value,
                  id: controller.dbDataList[map['index']]['id'],
                );
                dBhelper.updateDate(model, controller.dbDataList[map['index']]['id']);
              }
            else
              {
                DBhelper dBhelper = DBhelper();
                ExpenseIncomeModel model = ExpenseIncomeModel(
                  time: controller.selectedTime.value,
                  notes: txtNote.text,
                  date: controller.selectedDate.value,
                  cate: controller.selectCategory.value,
                  amount: int.parse(txtAomunt.text),
                  status: controller.selectStatus.value,
                );
                dBhelper.insertData(model);
              }
            controller.calRs();
            controller.transactionData();
            Get.back();
          },
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                entryField(
                    hint: "Amount",
                    tpy: TextInputType.number,
                    controller: txtAomunt),
                const SizedBox(height: 10),
                entryField(
                    hint: "Note", tpy: TextInputType.text, controller: txtNote),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(5)),
                  child: Obx(
                    () => DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectCategory.value,
                      onChanged: (newValue) {
                        controller.selectCategory.value = newValue!;
                      },
                      items: <String>[
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
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () async {
                                final DateTime? pick = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100));
                                if (pick != null &&
                                    pick != controller.selectedDate) {
                                  DateFormat date = DateFormat('dd-MM-yyyy');
                                  controller.selectedDate.value =
                                      date.format(pick);
                                }
                              },
                              child: const Icon(
                                Icons.date_range_outlined,
                                color: Colors.black54,
                                size: 30,
                              )),
                          const SizedBox(width: 10),
                          Obx(
                            () => Text(
                              "${controller.selectedDate}",
                              style: const TextStyle(letterSpacing: 1, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (picked != null &&
                                    picked != controller.selectedTime.value) {
                                  controller.selectedTime.value =
                                      picked.format(context);
                                }
                              },
                              child: const Icon(
                                Icons.watch_later_outlined,
                                color: Colors.black54,
                                size: 30,
                              )),
                          const SizedBox(width: 10),
                          Obx(
                            () => Text(
                              "${controller.selectedTime}",
                              style: const TextStyle(letterSpacing: 1, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(5)),
                  child: Obx(
                    () => Column(
                      children: <Widget>[
                        RadioListTile(
                          activeColor: Colors.green,
                          value: 0,
                          groupValue: controller.selectStatus.value,
                          title: Text(
                            'Income',
                            style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 18,
                                color: controller.selectStatus.value == 0
                                    ? Colors.green
                                    : Colors.black),
                          ),
                          onChanged: (val) {
                            controller.selectStatus.value = 0;
                          },
                        ),
                        RadioListTile(
                          activeColor: Colors.red,
                          value: 1,
                          groupValue: controller.selectStatus.value,
                          title: Text('Expense',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 18,
                                  color: controller.selectStatus.value == 1
                                      ? Colors.red
                                      : Colors.black)),
                          onChanged: (val) {
                            controller.selectStatus.value = 1;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField entryField({hint, controller, tpy}) {
    return TextField(
      controller: controller,
      keyboardType: tpy,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo)),
          hintText: hint,
          label: Text("$hint"),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}
