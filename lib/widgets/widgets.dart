import 'package:flutter/material.dart';

AppBar appBar(context) {
  return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.white,
      title: Text(
        'Ввод',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.arrow_back_ios)),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 37,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.more_horiz)),
        ),
      ]);
}
