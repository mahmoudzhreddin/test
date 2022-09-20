import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constants/constant.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final bool? general;
  final bool? required;
  final bool? enabled;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final GestureTapCallback? onTap;
  final InputDecoration? inputDecoration;


  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.icon,
      this.validator,
      this.onChanged,
      this.obscureText = false,
      this.textInputAction,
      this.keyboardType,
      this.autofocus = false,
      this.controller,
      this.general = true,
      this.required = false,
      this.enabled = true,
      this.maxLength,
      this.maxLines = 1,
      this.minLines,
      this.onTap, this.inputDecoration})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isSeen = false;
  late InputDecoration _inputDecoration;

  @override
  void initState() {
    super.initState();
    if(widget.inputDecoration==null) {
      _inputDecoration = !widget.general!
        ? AppTheme.inputDecoration.copyWith(
            prefixIcon: Icon(
              widget.icon,
              size: 15,
            ),
          )
        : InputDecoration(
            label: Row(
            children: [
              Text(widget.labelText),
              if (widget.required!)
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                )
            ],
          ));
    }
    else{
      _inputDecoration = widget.inputDecoration!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !widget.general!
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.labelText,
                    style: AppTheme.bodyText2
                        .copyWith(color: AppColors.primaryColor)))
            : Container(),
        TextFormField(
          enabled: widget.enabled!,
          onTap: widget.onTap,
          expands: widget.maxLength == 0 ? true : false,
          controller: widget.controller ?? TextEditingController(),
          decoration: _inputDecoration.copyWith(
              hintText:
                  !widget.required! ? widget.hintText : widget.hintText + ' *',
              hintStyle: AppTheme.subtitle2.copyWith(
                fontWeight: FontWeight.w200,
                color: AppColors.grey,
              ),
              suffixIcon: widget.obscureText!
                  ? PlatformIconButton(
                      onPressed: () {
                        setState(() {
                          isSeen = !isSeen;
                        });
                      },
                      icon: Icon(
                          isSeen
                              ? context.platformIcons.eyeSolid
                              : context.platformIcons.eyeSlashSolid,
                          size: 15),
                    )
                  : null),
          validator: widget.validator,
          obscureText: !isSeen ? widget.obscureText! : false,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          autofocus: widget.autofocus!,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
        ),
      ],
    );
  }
}
