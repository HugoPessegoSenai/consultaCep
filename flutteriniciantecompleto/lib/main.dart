import 'package:flutter/material.dart';
import 'package:flutteriniciantecompleto/views/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    )
  );
}