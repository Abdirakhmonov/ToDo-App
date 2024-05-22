import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../models/todo_model.dart';

class AddDialog extends StatefulWidget {
  TodoModel? model;
  AddDialog({this.model, super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final _formKey = GlobalKey<FormState>();

  String _formattedDate = DateFormat("dd-MMMM").format(DateTime.now());

  String _title = "";
  @override
  void initState() {
    if (widget.model != null) {
      _formattedDate = widget.model!.date;
      _title = widget.model!.title;
    }
    super.initState();
  }

  void _add() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, {"title": _title, "date": _formattedDate});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: widget.model == null
          ? const Text("Yangi vazifa qo'shish", style: TextStyle(color: Colors.white))
          : const Text("Vazifani o'zgartirish", style: TextStyle(color: Colors.white),),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                label: Text(
                  "Vazifa nomi:", style: TextStyle(color: Colors.white)
                ),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Vazifa nomini kiriting";
                }
                return null;
              },
              onSaved: (newValue) {
                _title = newValue!;
              },
            ),
            const Gap(20),
            Text(
              textAlign: TextAlign.center,
              "Vaqti: $_formattedDate",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                DateTime? data = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2024, 5, 22),
                    lastDate: DateTime(2025));

                if (data != null) {
                  _formattedDate = DateFormat("dd-MMMM").format(data);
                }
                setState(() {});
              },
              child: const Text("Vaqtini tanlang"),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor qilish"),
        ),
        ElevatedButton(
          onPressed: _add,
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}
