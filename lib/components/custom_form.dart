import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import '../widgets.dart';
import 'constants.dart';

const _supportedCurrency = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};
var selectedCurrency = _supportedCurrency.entries.last.key;

class CustomFormWidget extends StatefulWidget {
  final controller;
  const CustomFormWidget({required this.controller});

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {

  @override
  Widget build(BuildContext context) {
    final maxInput = ThousandsFormatter()
        .formatEditUpdate(
        const TextEditingValue(text: ''),
        TextEditingValue(
            text: _supportedCurrency[selectedCurrency].toString()))
        .text;
    final dropdown = ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        underline: Container(height: 0,),
        items: {"PHP", 'U\$', '€','¥','£','Fr','A\$','C¥'}
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem(
              alignment: Alignment.center   ,
              value: e,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 15,
                child: Text(
                  e,
                  style: const TextStyle(color: Colors.white, fontSize: 14,fontFamily: "Poppins"),
                ),
              )),
        )
            .toList(),
        value: selectedCurrency,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 30,
        ),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedCurrency = value;
            });
          }
        },
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyWidgets.text("Enter Amount", 20.0, FontWeight.bold, Color(0xff04123B), context,false),
        SizedBox(height: 5,),
        FractionallySizedBox(
          widthFactor: 0.7,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
            maxLines: 1,
            controller: widget.controller,
            decoration: InputDecoration(

              prefixIcon: dropdown,
              hintText: "1000",
              contentPadding: const EdgeInsets.only(bottom: 0, right: 48,top: 0),
              focusedBorder: UnderlineInputBorder(

              ),
              enabledBorder: UnderlineInputBorder(

              ),
            ),
            style: TextStyle(fontSize: MF(20, context),fontFamily: "Poppins",fontWeight: FontWeight.bold,color: Color(0xff04123B)),
            textAlign: TextAlign.center,
            inputFormatters: [
              ThousandsFormatter(),
            ],
            validator: (value) {
              final newValue = value?.replaceAll(RegExp(r'^[0-9]'), '');
              final intValue = int.tryParse(newValue ?? '0');
              if (intValue != null &&
                  intValue <= _supportedCurrency[selectedCurrency]!) {
                return null;
              }
              return 'Invalid Input';
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Maximum of $maxInput',
          style: TextStyle(fontSize: MF(16, context)),
        )
      ],
    );
  }
}