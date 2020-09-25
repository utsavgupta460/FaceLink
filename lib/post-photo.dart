import 'package:flutter/material.dart';
class PostContainerBody extends StatelessWidget {
  final String picAddress;

  PostContainerBody(this.picAddress);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        child: Image.asset(picAddress),
      ),
    );
  }
}