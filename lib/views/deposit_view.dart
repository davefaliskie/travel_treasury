import 'package:flutter/material.dart';
import 'package:travel_budget/widgets/rounded_button.dart';

class DepositView extends StatefulWidget {
  @override
  _DepositViewState createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Column(
          children: [
            Spacer(),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "\$100",
                style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text("", style: TextStyle(color: Colors.white)),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.4,
                  children: setKeyboard(),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionBtn("spent"),
                  _actionBtn("saved"),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
  
  
  Widget _numberBtn(String number) {
    return FlatButton(
      child: Text("$number", style: TextStyle(fontSize: 40, color: Colors.white),),
      onPressed: () { print("$number"); },
    );
  }

  Widget _deleteBtn() {
    return FlatButton(
      child: Text("<", style: TextStyle(fontSize: 40, color: Colors.white),),
      onPressed: () { print("delete"); },
    );
  }

  Widget _actionBtn(String type) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: RoundedButton(
          color: Colors.indigoAccent,
          child: Text("${type[0].toUpperCase()}${type.substring(1)}", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            print("$type");
          },
        ),
      ),
    );
  }

  
  setKeyboard() {
    List<Widget> keyboard = [];
    
    // numbers 1-9
    List.generate(9, (index) {
      keyboard.add(_numberBtn("${index + 1}"));
    });

    keyboard.add(Text(""));
    keyboard.add(_numberBtn("0"));
    keyboard.add(_deleteBtn());

    return keyboard;
  }
}
