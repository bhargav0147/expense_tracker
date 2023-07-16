import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/InEx_controller.dart';
import '../../utils/db_helper.dart';

class AllEntryScreen extends StatefulWidget {
  const AllEntryScreen({super.key});

  @override
  State<AllEntryScreen> createState() => _AllEntryScreenState();
}

class _AllEntryScreenState extends State<AllEntryScreen> {
  IncomeExpenseController controller = Get.put(IncomeExpenseController());
  int forData=0;
  @override
  void initState() {
    super.initState();
    forData = controller.dbDataList.length;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "All Transaction",
          style: TextStyle(letterSpacing: 1),
        ),
        leading: InkWell(
            onTap: () {
              controller.calRs();
              controller.transactionData();
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new,size: 25,color: Colors.white,)),
      ),
      body: forData==0?const Center(
          child: Text(
            'No Data Available',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
        ),
      ):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
              () =>  ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 110,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 3,
                          color: Color(0x4D090F13),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${controller.dbDataList[index]['note']}',
                                      style: const TextStyle(
                                        letterSpacing: 2,
                                        color: Color(0xFF090F13),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Center(
                                        child: PopupMenuButton(
                                          offset: const Offset(0, 0),

                                          splashRadius: 50,
                                          shadowColor: Colors.black,
                                          elevation: 5,
                                          itemBuilder: (context) =>[
                                            PopupMenuItem(child: InkWell(
                                                onTap: () {
                                                  Get.toNamed("add",arguments: {"status":0,"index":index});
                                                },
                                                child: Container(
                                                    height: 40,
                                                    width: 80,
                                                    child: const Center(child: Text("Update",style: TextStyle(letterSpacing: 1,fontSize: 15),))))),
                                            PopupMenuItem(child: InkWell(
                                                onTap: () {
                                                  DBhelper helper = DBhelper();
                                                  helper.deleteData(controller.dbDataList[index]['id']);
                                                  controller.transactionData();
                                                  Get.back();
                                                },child: Container(
                                                height: 40,
                                                width: 80,
                                                child: const Center(child: Text("Delete",style: TextStyle(letterSpacing: 1,fontSize: 15),)))))
                                          ],),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${controller.dbDataList[index]['category']}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: const Color(0x2C4B39EF),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${controller.dbDataList[index]['date']}',
                                          style: const TextStyle(
                                            letterSpacing: 1,
                                            color: Color(0xFF4B39EF),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${controller.dbDataList[index]['amount']}',
                                      style: TextStyle(
                                        color: controller.dbDataList[index]
                                        ['status'] ==
                                            0
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            itemCount: controller.dbDataList.length,
          ),
        ),
      ),),
    );
  }
}
