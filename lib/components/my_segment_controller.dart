import 'package:flutter/material.dart';
import 'package:medical_app/services/consts.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';

class MySegmentedController extends StatefulWidget {
  final Function(int) onChange;
  final int selectedSegment;
  final List<String> text;
  const MySegmentedController(
      {super.key,
      required this.onChange,
      required this.text,
      required this.selectedSegment});

  @override
  State<MySegmentedController> createState() => _MySegmentedControllerState();
}

class _MySegmentedControllerState extends State<MySegmentedController> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButtonSlide(
      margin: const EdgeInsets.all(5),
      entries: [
        SegmentedButtonSlideEntry(label: widget.text[0]),
        SegmentedButtonSlideEntry(label: widget.text[1]),
      ],
      selectedEntry: widget.selectedSegment,
      onChange: (segment) => widget.onChange(segment),
      colors: const SegmentedButtonSlideColors(
          barColor: inputBorder,
          backgroundSelectedColor: Colors.white,
          foregroundSelectedColor: accentColor,
          foregroundUnselectedColor: bodyTextColor,
          hoverColor: Colors.white),
      barShadow: const [
        BoxShadow(
          color: inputBorder,
          blurRadius: 0,
          spreadRadius: 5,
        )
      ],
    );
  }
}
