import 'package:flutter/material.dart';
import 'package:quizzly/login_tab_view.dart';
import 'package:quizzly/navigate_to_custom_button.dart';
import 'package:quizzly/register_tab_view.dart';

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with SingleTickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/images/episodes-grid.png"),
          fit: BoxFit.fill,
          opacity: .75
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        height: 50,
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Die Zentrale", style: TextStyle(color: Colors.white)),
                              Image.asset("assets/icon/ddf_logo.png")
                            ]
                        )
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text("Hallo! Du bist schon Mitglied in der Zentrale? Dann kannst du dich hier einloggen: "),
                              const SizedBox(height: 10),
                              NavigateToCustomButton(
                                text: "Zum Login",
                                isPrimary: true,
                                customNavigator: (){
                                  _tabController.animateTo(1);
                                },
                              ),
                              const SizedBox(height: 20),
                              Text("Wenn du offiziell noch kein Detektiv-Kollege/keine Detektiv-Kollegin bist, dann kannst du dich hier registieren:"),
                              const SizedBox(height: 10),
                              NavigateToCustomButton(
                                text: "Zur Registrierung",
                                customNavigator: (){
                                  _tabController.animateTo(2);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              LoginTabView(tabController: _tabController,),
              RegisterTabView(tabController: _tabController)
            ],
          ),
        ),
      ),
    );
  }
}
