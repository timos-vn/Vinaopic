import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';

class TextFieldWidgetInput extends StatefulWidget {
  const TextFieldWidgetInput(
      {Key? key, required this.controller,
        this.textInputAction=TextInputAction.next,
        this.isEnable = true,
        this.onChanged,
        this.isPassword = false,
        this.inputFormatter,
        this.errorText,
        this.labelText,
        this.hintText,
        this.keyboardType: TextInputType.text,
        this.focusNode,
        this.onSubmitted,
        this.prefixIcon,
        this.suffix,
        this.readOnly,
        this.color,
        this.isNull,this.enableMaxLine,this.maxLine,required this.onTapSuffix}) : super(key: key);

  final TextEditingController controller;
  final bool isEnable;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction textInputAction;
  final FormFieldSetter<String>? onChanged;
  final bool isPassword;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final FormFieldSetter<String>? onSubmitted;
  final dynamic prefixIcon;
  final dynamic suffix;
  final bool? readOnly;
  final Color? color;
  final bool? isNull;
  final bool? enableMaxLine;
  final int? maxLine;
  final Callback onTapSuffix;

  @override
  _TextFieldWidgetInputState createState() => _TextFieldWidgetInputState();
}

class _TextFieldWidgetInputState extends State<TextFieldWidgetInput> {
  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly == null ? false : widget.readOnly!,
      enabled: widget.isEnable,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      textAlignVertical: TextAlignVertical.center,
      inputFormatters: widget.inputFormatter,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(
              color: Colors.grey,width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(width: 1,color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(
              color: Colors.grey,),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(
              color: Colors.grey, ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 7,horizontal: 7),
          isDense: true,
          focusColor: primaryColor,
          hintText: widget.hintText,
          labelText: widget.labelText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon == null
              ? null
              : (widget.prefixIcon is String
              ? Padding(
            child: Image.asset(
              widget.prefixIcon,
              width: 35,
              height: 35,
              fit: BoxFit.fitHeight,
            ),
            padding: EdgeInsets.all(12),
          )
              : Icon(
            widget.prefixIcon,
            color: accent,
            size: 20,
          )),
          suffixIcon: !widget.isPassword
              ? widget.suffix == null ? null : IconButton(
                  onPressed: widget.onTapSuffix,
                  icon: Icon(widget.suffix,color: Colors.blueGrey,size: 20,))
              : GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? MdiIcons.eye : MdiIcons.eyeOff,
              semanticLabel:
              _obscureText ? 'show password' : 'hide password',
              color: blue,
            ),
          ),
          labelStyle:
          TextStyle(color: widget.isNull == true ? widget.color : red, fontSize: 11),
          hintStyle: TextStyle(
            fontSize: 13,
            color: grey,
          ),
          errorStyle: TextStyle(
            fontSize: 10,
            color: red,
          )),
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 13,
        color: widget.isEnable ? black : Colors.black,
      ),
    );
  }
}