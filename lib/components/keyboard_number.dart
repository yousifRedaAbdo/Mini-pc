import 'package:flutter/material.dart';

class NumericKeyboardScreen extends StatefulWidget {
  @override
  _NumericKeyboardScreenState createState() => _NumericKeyboardScreenState();

  TextEditingController controller = TextEditingController();


  NumericKeyboardScreen({required this.controller});
}


class _NumericKeyboardScreenState extends State<NumericKeyboardScreen> {

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                buildRow(['7', '8', '9']),
                buildRow(['4', '5', '6']),
                buildRow(['1', '2', '3']),
                buildRow(['X', '0', '<']),
              ],
            ),
          ),
        ],
      );
  }

  Widget buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        return SizedBox(
          width: 70,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff437EEB)),
                borderRadius: BorderRadius.circular(35)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: MaterialButton(
                  color: Colors.white,
                  textColor:Color(0xff437EEB),
                  onPressed: () {
                    if (key == '<') {
                      if (widget.controller.text.isNotEmpty) {
                        setState(() {
                          widget.controller.text = widget.controller.text.substring(
                              0, widget.controller.text.length - 1);
                        });
                      }
                    } else if(key == 'X')
                    {
                      setState(() {
                        widget.controller.clear();
                      });
                    }
                    else {
                      setState(() {
                        widget.controller.text += key;
                      });
                    }
                  },
                  child: key == '<' ? Icon(Icons.backspace) :
                  key == 'X' ? Text(key,style: TextStyle(fontSize: 24,color: Color(0xffF28021))):
                  Text(key,style: TextStyle(fontSize: 24)),
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors.white,
                  //   textStyle: TextStyle(fontSize: 24,color: Color(0xff437EEB)),
                  //   disabledBackgroundColor: Color(0xffFFFFFF),
                  //   shadowColor: Color(0xffEFF1FE),
                  ),
              ),
            ),
            ),
        );
      }).toList(),
    );
  }
}