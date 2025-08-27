import 'package:flutter/material.dart';


class Qna extends StatefulWidget {
  const Qna({super.key});

  @override
  State<Qna> createState() => _QnaState();
}

class _QnaState extends State<Qna> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(child: Text("QnA", style: TextStyle(fontSize: 30))),
      ),
    );
  }
}
