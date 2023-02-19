import 'package:flutter/material.dart';

class BlackLabelButton extends StatelessWidget {
  const BlackLabelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size.zero),
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.blue;
            } else {
              return Colors.black;
            }
          }),
          tapTargetSize:
          MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0),
                  side: BorderSide(color: Colors.transparent))),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            'master',
            style: TextStyle(
                color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
