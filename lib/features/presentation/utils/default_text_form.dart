import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultInput extends StatelessWidget {
  const DefaultInput({
    required this.controller,
    required this.label,
    required this.icon,
    this.inputFormatters,
  });

  final String label;

  final TextEditingController controller;

  final IconData icon;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            height: 48,
            width: 50,
            padding: EdgeInsets.only(top: 12, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: Colors.grey,
            ),
            child: Center(child: Icon(icon, color: Colors.grey.shade200)),
          ),
          Expanded(
            flex: 8,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text(
                  label,
                  style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
              ),
              inputFormatters: inputFormatters,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
