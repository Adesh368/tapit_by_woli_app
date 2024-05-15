import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapit_by_wolid_app/widgets/font_widget.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    required this.controller,
    required this.title,
    required this.labeled,
    required this.textInputType,
    required this.textobsure,
    this.emptytextbox = '',
    this.maxword,
    Key? key,
    this.image,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;
  final String title;
  String? labeled;
  final Image? image;
  bool textobsure;
  String? emptytextbox;

  final List<TextInputFormatter>? maxword;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFontWidget(
            text: widget.title,
            sizes: 18,
            color: const Color(0xff1A1A1A),
            weights: FontWeight.w700,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              border: Border.all(
                width: 1,
                color: const Color(0xff666666),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: TextField(
                    inputFormatters: widget.maxword,
                    obscureText: widget.textobsure,
                    controller: widget.controller,
                    keyboardType: widget.textInputType,
                    decoration: InputDecoration(
                      hintText: widget.labeled,
                      hintStyle: Theme.of(context).textTheme.labelMedium!,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.image != null)
                  InkWell(
                      onTap: () {
                        setState(() {
                          widget.textobsure = !widget.textobsure;
                        });
                      },
                      child: widget.image!),
              ]),
              if (widget.emptytextbox != null &&
                  widget.emptytextbox!.isNotEmpty)
                Text(
                  widget.emptytextbox!,
                  style: GoogleFonts.mulish(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffF74242),
                  ),
                ),
              SizedBox(
                  height: widget.emptytextbox != null &&
                          widget.emptytextbox!.isNotEmpty
                      ? 8
                      : 0),
            ]),
          ),
        ]);
  }
}
