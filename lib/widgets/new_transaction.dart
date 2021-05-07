import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTrasactions extends StatefulWidget {
  final Function addTx;

  NewTrasactions(this.addTx);

  @override
  _NewTrasactionsState createState() => _NewTrasactionsState();
}

class _NewTrasactionsState extends State<NewTrasactions> {
  DateTime _selectedDate;

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    } else {
      widget.addTx(enteredTitle, enteredAmount, _selectedDate);

      Navigator.of(context).pop();
    }
  }

  void _presendDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {}
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
                /* onChanged: (val) {
                  titleInput = val;
                }, */
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                /* onChanged: (val) => amountInput = val */
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    TextButton(
                        onPressed: _presendDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: _submitData,
                /* () {
                  submi
                  /* print(titleInput);
                  print(amountInput); */
                }, */
                child: Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
