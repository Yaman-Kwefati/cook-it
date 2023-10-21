import 'package:cook_it/models/recipe_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AndroidPicker extends StatefulWidget {
  List<DropdownMenuItem<String>> dropDownItems = [];
  String selectedCategoryString = "Breakfast";
  final ValueChanged<String>? onCategorySelected;

  AndroidPicker({this.onCategorySelected});

  @override
  State<AndroidPicker> createState() => _AndroidPickerState();
}

class _AndroidPickerState extends State<AndroidPicker> {
  void addItemsToDropDownItemsList() {
    for (String item in categoriesList) {
      var newItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      widget.dropDownItems.add(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    addItemsToDropDownItemsList();
    return DropdownButton<String>(
        items: widget.dropDownItems,
        value: widget.selectedCategoryString,
        onChanged: (value) {
          setState(() {
            widget.selectedCategoryString = value!;
          });
          if (widget.onCategorySelected != null) {
            widget.onCategorySelected!(value!);
          }
        });
  }
}

class IosPicker extends StatefulWidget {
  List<DropdownMenuItem<String>> dropDownItems = [];
  String selectedCategoryString = "Breakfast";
  final ValueChanged<String>? onCategorySelected;

  IosPicker({this.onCategorySelected});
  @override
  State<IosPicker> createState() => _IosPickerState();
}

class _IosPickerState extends State<IosPicker> {
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CupertinoButton(
            color: Color(0xFF162D6E),
            child: Text(
              widget.selectedCategoryString,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () => _showDialog(
                  CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: 32.0,
                    // This sets the initial item.
                    scrollController: FixedExtentScrollController(
                      initialItem: 0,
                    ),
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        widget.selectedCategoryString =
                            categoriesList[selectedItem];
                      });
                      if (widget.onCategorySelected != null) {
                        widget
                            .onCategorySelected!(categoriesList[selectedItem]);
                      }
                    },
                    children: List<Widget>.generate(categoriesList.length,
                        (int index) {
                      return Center(child: Text(categoriesList[index]));
                    }),
                  ),
                ))
      ],
    );
  }
}
