import 'package:expense_tracker/add/add_screen.dart';
import 'package:expense_tracker/home/view/all_entry_screen.dart';
import 'package:expense_tracker/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main()
{
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(p0) => const HomeScreen(),
      'add':(p0) => const AddScreen(),
      'all':(p0) => const AllEntryScreen(),

    },
  ));
}