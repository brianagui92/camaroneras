import 'package:flutter/material.dart';

const List<int> pools = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 , 0];
const List<String> balanceados = <String>['Classic', 'Masterline', 'NW# 1', 'NW# 2', 'NW# 4'];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Camaronera Nueva Data';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          //Camaronera Dropdownfield
          const DropdownButtonFormExample(list: <String>['CAMAGUI', 'SEMACU'], label: 'Camaronera'),

          //a list of widgets to be added to the children of the column
          // concantenate to children list
          ...pools.map<ColumnPiscina>((int value) {
            return ColumnPiscina(
              pool: value,
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

//Group of 2 fields
//A textfield for the ammount of feed given
//A dropdown for the name of the feed
class ColumnPiscina extends StatelessWidget {
  final int pool;
  ColumnPiscina({Key?key, required this.pool}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'Balanceado (Kg) Piscina #$pool',
          ),
          keyboardType: TextInputType.number,
        ),
        DropdownButtonFormExample(list: balanceados, label: 'Nombre de Balanceado Piscina#$pool'),
      ],
    );
  }
}

class DropdownButtonFormExample extends StatefulWidget {
  final List<String> list;
  final String label;

  const DropdownButtonFormExample({Key?key, required this.list, required this.label}) : super(key: key);

  @override
  State<DropdownButtonFormExample> createState() => _DropdownButtonFormExampleState();
}

class _DropdownButtonFormExampleState extends State<DropdownButtonFormExample>{

  late String dropdownValue = widget.list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.label
      ),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      /* From code guide
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      */
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

}

