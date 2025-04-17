import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/main.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/services_and_models/services.dart';
import 'package:time_tweak/services_and_models/utils.dart';
import 'package:time_tweak/widgets/error_display.dart';
import 'package:time_tweak/widgets/loading.dart';

class RescheduleForm extends StatelessWidget {
  RescheduleForm({super.key});
  final ValueNotifier<bool> _facultyChoice = ValueNotifier(false);
  final ValueNotifier<DateTime> _currentSelectedDate = ValueNotifier(
    DateTime.now(),
  );
  final ValueNotifier<DateTime> _newSelectedDate = ValueNotifier(
    DateTime.now(),
  );
  static final TextEditingController _courseCtrl = TextEditingController();
  static final TextEditingController _currDateCtrl = TextEditingController();
  static final TextEditingController _newDateCtrl = TextEditingController();
  static final TextEditingController _reasonCtrl = TextEditingController();
  static Course? _selCourse;
  static Faculty? _selFaculty;
  static int? _selCurrentSlot;
  static int? _selNewSlot;

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController ctrl,
    ValueNotifier notifier,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (picked.weekday >= 6) {
        return ErrorDisplay.showSnackBar("Please select a valid date");
      }
      ctrl.text =
          "${picked.year.toString().padLeft(4, '0')}-"
          "${picked.month.toString().padLeft(2, '0')}-"
          "${picked.day.toString().padLeft(2, '0')}";
      notifier.value = ctrl.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: sw * 0.04, top: sw * 0.04),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: sw * 0.02),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_rounded, size: sw * 0.08),
                    ),
                  ),
                  Text(
                    "Reschedule",
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: sw * 0.07,
                      fontVariations: [FontVariation.weight(700)],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: sh * 0.03,
                        left: sw * 0.05,
                        right: sw * 0.05,
                      ),
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              labelText: "Search...",
                              labelStyle: TextStyle(fontFamily: 'Satoshi'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        items: List.generate(
                          CourseData.allcourses.length,
                          (index) => CourseData.allcourses[index].title,
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Course",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          _selCourse = CourseData.getCourseByName(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: sh * 0.03,
                        left: sw * 0.05,
                        right: sw * 0.05,
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: _facultyChoice,
                        builder:
                            (context, value, _) => DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    labelText: "Search...",
                                    labelStyle: TextStyle(
                                      fontFamily: 'Satoshi',
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              items:
                                  Utilities.getFacultiesbyCourse(
                                    _selCourse,
                                  ).map((m) => m.name).toList(),

                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Faculty",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onChanged:
                                  (value) =>
                                      _selFaculty =
                                          FacultyData.getFacultybyName(value),
                            ),
                      ),
                    ),
                    SizedBox(height: sh * 0.03),
                    Divider(
                      thickness: 2,
                      indent: sw * 0.05,
                      endIndent: sw * 0.05,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sw * 0.05),
                      child: Text(
                        "Current",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: sh * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                await _selectDate(
                                  context,
                                  _currDateCtrl,
                                  _currentSelectedDate,
                                );
                                if (_selCourse == null) return;
                                if (_currDateCtrl.text.isEmpty) return;
                              },
                              controller: _currDateCtrl,
                              readOnly: true,
                              enableInteractiveSelection: false,
                              decoration: InputDecoration(
                                hintText: "Select Date",
                                hintStyle: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Colors.black,
                                  fontVariations: [FontVariation.weight(400)],
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: sw * 0.05),
                          Expanded(
                            child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    labelText: "Search...",
                                    labelStyle: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Colors.black,
                                      fontVariations: [
                                        FontVariation.weight(400),
                                      ],
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              items: SlotData.allSlots,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Slot",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.black,
                                    fontVariations: [FontVariation.weight(400)],
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value == null) return;
                                _selCurrentSlot = SlotData.getIndexFromSlot(
                                  value,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sh * 0.03),
                    Divider(
                      thickness: 2,
                      indent: sw * 0.05,
                      endIndent: sw * 0.05,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sw * 0.05),
                      child: Text(
                        "Requested",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: sh * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                      child: Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: _newSelectedDate,
                              builder:
                                  (context, value, _) => TextFormField(
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    controller: _newDateCtrl,
                                    onTap:
                                        () async => await _selectDate(
                                          context,
                                          _newDateCtrl,
                                          _newSelectedDate,
                                        ),
                                    decoration: InputDecoration(
                                      hintText: "Select Date",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Colors.black,
                                        fontVariations: [
                                          FontVariation.weight(400),
                                        ],
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                          SizedBox(width: sw * 0.05),
                          Expanded(
                            child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    labelText: "Search...",
                                    labelStyle: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Colors.black,
                                      fontVariations: [
                                        FontVariation.weight(400),
                                      ],
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              items: SlotData.allSlots,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Slot",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.black,
                                    fontVariations: [FontVariation.weight(400)],
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value == null) return;
                                _selCurrentSlot = SlotData.getIndexFromSlot(
                                  value,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sh * 0.03),
                    Padding(
                      //Description
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                      child: TextFormField(
                        controller: _reasonCtrl,
                        maxLines: 3,
                        maxLength: 40,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          fontVariations: [FontVariation.weight(400)],
                        ),
                        decoration: InputDecoration(
                          hintText: "Remarks",
                          hintStyle: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            fontVariations: [FontVariation.weight(400)],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sh * 0.06),
                    Center(
                      child: SizedBox(
                        height: sw * 0.13,
                        width: sw * 0.45,
                        child: OutlinedButton(
                          onPressed: () => _submit(),
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontFamily: 'Outfit',
                              fontSize: sw * 0.07,
                              fontVariations: [FontVariation.weight(500)],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sh * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    Loading.show();
    try {
      if (_selCourse == null ||
          _selFaculty == null ||
          _selCurrentSlot == null ||
          _selNewSlot == null) {
        return ErrorDisplay.showSnackBar("Please fill all the fields");
      }
      final (res, msg) = await RescheduleService.add(
        Reschedule(
          rescId: "dummyId",
          ogDate: _currDateCtrl.text,
          ogSlotIdentifier: _selCurrentSlot!,
          newDate: _newDateCtrl.text,
          newSlotIdentifier: _selNewSlot!,
          reason: _reasonCtrl.text,
          courseIdentifier: _selCourse!.courseId,
          crIdentifier: CurrentUserData.rollNum,
          facultyIdentifier: _selFaculty!.facId,
          status: Status.pending,
        ).toJson(),
      );
      if (res) {
        final (check, message) = await ClassRepService.fetch(
          regNo: CurrentUserData.rollNum,
        );
        if (check) {
          ClassRep data = ClassRep.fromJson(message);
          data.setAsCurrentUserData();
          Rebuild.reschedules();
          Loading.close();
          final context = navigatorKey.currentContext;
          if (context == null) {
            throw Exception("context not available to pop");
          }
          Navigator.pop(context);
          return;
        } else {
          return ErrorDisplay.showSnackBar("Couldn't update the list");
        }
      } else {
        return ErrorDisplay.showSnackBar(msg);
      }
    } finally {
      _selCourse = null;
      _selFaculty = null;
      _selNewSlot = null;
      _selCurrentSlot = null;
      Loading.close();
    }
  }
}
