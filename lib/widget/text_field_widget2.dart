import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../core/values/colors.dart';

class TextFieldWidget2 extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TextFieldWidget2(
      {required this.controller,
        this.textInputAction = TextInputAction.next,
        this.isEnable = true,
        this.onChanged,
        this.isPassword = false,
        this.inputFormatters,
        this.errorText,
        this.labelText,
        this.hintText,
        this.keyboardType = TextInputType.text,
        this.focusNode,
        this.onSubmitted,
        this.prefixIcon,
        this.suffix,
        this.readOnly,
        this.color});

  final TextEditingController controller;
  final bool isEnable;
  final List<TextInputFormatter>? inputFormatters;
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

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget2> {
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
        readOnly: widget.readOnly??false,
        enabled: widget.isEnable,
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: _obscureText,
        textInputAction: widget.textInputAction,
        // textAlignVertical: TextAlignVertical.,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(borderSide: BorderSide(color: grey, width: 1),),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: grey, width: 1),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: grey, width: 1),
          ),
          contentPadding: const EdgeInsets.only(top: 16,bottom: 10,),
          isDense: true,
          focusColor: Colors.white,
          hintText: widget.hintText,
          labelText: widget.labelText,

          // suffix: widget.suffix == null
          //     ? null
          //     : Icon(widget.suffix,color: grey,size: 20,)
          // ,
          errorText: widget.errorText == '' ? null : widget.errorText,
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
            padding: const EdgeInsets.all(12),
          )
              : Icon(
            widget.prefixIcon,
            color: Colors.black,
            size: 20,
          )),
          suffixIcon: !widget.isPassword
              ? widget.suffix == null ?
          widget.controller.text.isNotEmpty ?
          GestureDetector(
            onTap: () {
              setState(() {
                widget.controller.text ='';
              });
            },
            child:const Icon(
              Icons.cancel,
              semanticLabel: 'delete',
              color: Colors.black,
            ),
          ): null
              : Icon(widget.suffix,color: Colors.black,size: 20,)
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
              color: Colors.black,
            ),
          ) ,
          labelStyle:
          TextStyle(color: widget.isEnable ? grey : widget.color==null ? widget.color : grey, fontSize: 13),
          hintStyle: const TextStyle(
            fontSize: 13,
            color: grey,
          ),
          errorStyle:
          const TextStyle(
              fontSize: 10,
              color: red),
        ),
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,)
    );
  }
}
