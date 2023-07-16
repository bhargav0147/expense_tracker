import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../controller/InEx_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  IncomeExpenseController controller = Get.put(IncomeExpenseController());

  @override
  void initState() {
    super.initState();
    controller.transactionData();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Income Expense Tracker",
          style: TextStyle(letterSpacing: 1),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tooltip(

              message: "Filter",
              child: IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.green.shade900,
                    size: 25,
                  )),
            ),
            FloatingActionButton(
              onPressed: () {
                Get.toNamed("add", arguments: {"status": 1, "index": null});
              },
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            Tooltip(

              message: "All Transaction",
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('all');
                  },
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: Colors.green.shade900,
                    size: 25,
                  )),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () =>  PieChart(
                        chartLegendSpacing: 20,
                          chartType: ChartType.ring,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.bottom,
                            showLegendsInRow: true,
                            legendShape: BoxShape.circle
                          ),
                          animationDuration: const Duration(seconds: 2),
                          colorList: const [
                            Colors.green,
                            Colors.red
                          ],
                          dataMap: {
                        'Income': controller.incomeRs.value.toDouble(),
                        'Expense': controller.expenseRs.value.toDouble()
                      }),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Income',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Obx(
                            () =>  Text(
                              '${controller.incomeRs}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Expense',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Obx(
                            () =>  Text(
                              '${controller.expenseRs}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 2,
                            indent: 50,
                            color: Colors.black54
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Saving',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Obx(
                            () => Text(
                              '${controller.incomeRs.value-controller.expenseRs.value}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Divider(color: Colors.black,thickness: 0.8),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Categorys',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 23,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {

                  }, icon: const Icon(Icons.list,size: 30,color: Colors.black54,))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[1]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                  controller.readCateDB(category: '${controller.cateList[1]}');
                  Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
              const Divider(color: Colors.black,thickness: 0.5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[2]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    controller.readCateDB(category: '${controller.cateList[2]}');
                    Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
              const Divider(color: Colors.black,thickness: 0.5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[3]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    controller.readCateDB(category: '${controller.cateList[3]}');
                    Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
              const Divider(color: Colors.black,thickness: 0.5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[4]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    controller.readCateDB(category: '${controller.cateList[4]}');
                    Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
              const Divider(color: Colors.black,thickness: 0.5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[5]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    controller.readCateDB(category: '${controller.cateList[5]}');
                    Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
              const Divider(color: Colors.black,thickness: 0.5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[6]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    controller.readCateDB(category: '${controller.cateList[6]}');
                    Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
              const Divider(color: Colors.black,thickness: 0.5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[7]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    controller.readCateDB(category: '${controller.cateList[7]}');
                    Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
              const Divider(color: Colors.black,thickness: 0.5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[8]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    controller.readCateDB(category: '${controller.cateList[8]}');
                    Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
              const Divider(color: Colors.black,thickness: 0.5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${controller.cateList[9]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    controller.readCateDB(category: '${controller.cateList[9]}');
                    Get.toNamed('all');
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 25,color: Colors.black,))
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
