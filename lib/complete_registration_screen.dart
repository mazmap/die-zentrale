import 'package:flutter/material.dart';

import 'complete_registration_1_tab_view.dart';
import 'complete_registration_2_tab_view.dart';

class CompleteRegistrationScreen extends StatefulWidget {
  const CompleteRegistrationScreen({super.key});

  @override
  State<CompleteRegistrationScreen> createState() => _CompleteRegistrationScreenState();
}

class _CompleteRegistrationScreenState extends State<CompleteRegistrationScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              CompleteRegistration1(tabController: _tabController),
              CompleteRegistration2(tabController: _tabController)
            ],
          ),
        ),
      ),
    );
  }
}
