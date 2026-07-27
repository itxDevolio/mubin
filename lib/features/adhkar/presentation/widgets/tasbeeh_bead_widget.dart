import 'package:flutter/material.dart';

Widget buildTasbeehCounter(int count, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.brown[300]!, Colors.brown[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(5, 5)),
        ],
      ),
      child: Center(
        child: Text(
          "$count",
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}