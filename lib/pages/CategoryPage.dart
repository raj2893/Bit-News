import 'package:flutter/material.dart';

class SelectionOptionsPage extends StatefulWidget {
  @override
  _SelectionOptionsPageState createState() => _SelectionOptionsPageState();
}

class _SelectionOptionsPageState extends State<SelectionOptionsPage> {
  List<Option> options = [
    Option(title: 'Option 1'),
    Option(title: 'Option 2'),
    Option(title: 'Option 3'),
    // Will be adding the categories from API
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
            child: Text(
              "Select your Hot Topics!",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing:
                      16.0, // Horizontal spacing between grid items
                  mainAxisSpacing: 16.0, // Vertical spacing between grid items
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return OptionCard(option: options[index]);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implementing the logic to handle the selected options here
                List<Option> selectedOptions =
                    options.where((option) => option.isSelected).toList();
                print('Selected Options: $selectedOptions');
              },
              child: Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}

class Option {
  final String title;
  bool isSelected;

  Option({required this.title, this.isSelected = false});
}

class OptionCard extends StatefulWidget {
  final Option option;

  OptionCard({required this.option});

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.option.isSelected
          ? Color.fromARGB(255, 0, 15, 62)
          : Colors.white,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.option.isSelected = !widget.option.isSelected;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: widget.option.isSelected,
                onChanged: (value) {
                  setState(() {
                    widget.option.isSelected = value!;
                  });
                },
              ),
              SizedBox(height: 8.0),
              Text(
                widget.option.title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: widget.option.isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
