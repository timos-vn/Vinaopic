import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/core/values/colors.dart';

class QuantityWidget extends StatefulWidget {

  final int initQuantity;
  final ValueChanged<int> valueChanged;

  QuantityWidget({Key? key,required this.initQuantity,required this.valueChanged}) : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {

int _quantity = 0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quantity = widget.initQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap:  _quantity <= 1 ? null : () {
              setState(() {
                _quantity --;
              });
              widget.valueChanged(_quantity);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Icon(
                MdiIcons.minusCircleOutline,
                color: _quantity > 1 ? black : blackBlur,
              ),
            ),
          ),
          Container(
            child: Text(
              _quantity.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12, color: black, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _quantity ++;
              });
              widget.valueChanged(_quantity);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Icon(
                MdiIcons.plusCircleOutline,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}