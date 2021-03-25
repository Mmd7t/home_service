import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    Key key,
    this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.only(
        topLeft: Radius.circular(50), bottomRight: Radius.circular(50));

    return InkWell(
      borderRadius: radius,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: radius,
          color: Theme.of(context).primaryColor,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
