import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadingDialogWidget extends StatelessWidget {
  final String? meassage;
  const LoadingDialogWidget({this.meassage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Container(
alignment: Alignment.center,
padding: const EdgeInsets.only(top:14),
child: CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
),

        ),
        Text(meassage.toString()+", Please Wait.....")
        ],
      ),
    );
  }
}

