import 'package:flutter/material.dart';

class CRSelectColor extends StatefulWidget {
  const CRSelectColor({super.key});

  @override
  State<CRSelectColor> createState() => CRSelectColorState();
}

class CRSelectColorState extends State<CRSelectColor> {
  int _selected = -1;

  bool validate(){
    return _selected != -1;
  }

  String getSelectedColor(){
    if(_selected == 0){
      return "FFFFFF";
    } else if(_selected == 1){
      return "E30613";
    } else if(_selected == 2){
      return "009FE4";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: (){
                  if(_selected == 0){
                    setState(() {
                      _selected = -1;
                    });
                  } else {
                    setState(() {
                      _selected = 0;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                  child: (_selected == 0) ? Icon(Icons.check) : null
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Material(
              color: Colors.red,
              child: InkWell(
                onTap: (){
                  if(_selected == 1){
                    setState(() {
                      _selected = -1;
                    });
                  } else {
                    setState(() {
                      _selected = 1;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: (_selected == 1) ? Icon(Icons.check, color: Colors.white,) : null
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: (){
                  if(_selected == 2){
                    setState(() {
                      _selected = -1;
                    });
                  } else {
                    setState(() {
                      _selected = 2;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: (_selected == 2) ? Icon(Icons.check, color: Colors.white) : null
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}
