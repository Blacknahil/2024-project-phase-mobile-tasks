import 'package:flutter/material.dart';

class SizeScrollable extends StatelessWidget {
  final List<int> numbers;

  SizeScrollable(this.numbers);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _generateTextButtons(numbers),
      ),
    );
  }

  List<Widget> _generateTextButtons(List<int> nums) {
    return nums.map((number) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              fixedSize: MaterialStateProperty.all(
                const Size(80, 80),
              ),
              backgroundColor: MaterialStateProperty.all(
                number == 40
                    ? const Color(0xFF3F51F3)
                    : const Color(0xFFFFFFFF),
              ),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              foregroundColor: MaterialStateProperty.all(
                number == 40 ? Colors.white : Colors.black,
              )),
          onPressed: () {
            debugPrint("Size $number has been selected");
          },
          child: Text(number.toString()),
        ),
      );
    }).toList();
  }
}
