import 'package:flutter/material.dart';
import 'package:quizzly/screens/boarding/complete_registration_msg_tab_view.dart';

import 'complete_registration_1_tab_view.dart';
import 'complete_registration_2_tab_view.dart';

class CompleteRegistrationScreen extends StatefulWidget {
  final bool startOnMessage;

  const CompleteRegistrationScreen({super.key, this.startOnMessage=false});

  @override
  State<CompleteRegistrationScreen> createState() => _CompleteRegistrationScreenState();
}

class _CompleteRegistrationScreenState extends State<CompleteRegistrationScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: (widget.startOnMessage) ? 0 : 1);
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
              CompleteRegistrationMsgTabView(tabController: _tabController),
              CompleteRegistration1(tabController: _tabController),
              CompleteRegistration2(tabController: _tabController)
            ],
          ),
        ),
      ),
    );
  }
}
