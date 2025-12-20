import 'package:flutter/material.dart';

import '../../widgets/navbar/navbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      drawer: NavBar(pageController),
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: Center(
        child: Text("I am in category"),
      ),
    );
  }
}
