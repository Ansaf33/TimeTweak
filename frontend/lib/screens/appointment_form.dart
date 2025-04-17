import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/main.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/services_and_models/services.dart';
import 'package:time_tweak/services_and_models/utils.dart';
import 'package:time_tweak/widgets/error_display.dart';
import 'package:time_tweak/widgets/loading.dart';

class AppointmentForm extends StatelessWidget {
  AppointmentForm({super.key});

  final ValueNotifier<DateTime> _currentSelectedDate = ValueNotifier(
    DateTime.now(),
  );
  static final TextEditingController _currDateCtrl = TextEditingController();
  static final TextEditingController _reasonCtrl = TextEditingController();
  static Faculty? _selFaculty;
  static int? _selSlot;
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
                    "New Appointment",
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
                        items:
                            Utilities.getFacultiesbyCourse(
                              null,
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
                        onChanged: (value) {
                          if (value == null) return;
                          _selFaculty = FacultyData.getFacultybyName(value);
                        },
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
                          hintText: "Description",
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
                    SizedBox(height: sh * 0.02),
                    Divider(
                      thickness: 2,
                      indent: sw * 0.05,
                      endIndent: sw * 0.05,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: sh * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                      child: Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: _currentSelectedDate,
                              builder:
                                  (context, value, _) => TextFormField(
                                    onTap:
                                        () async => _selectDate(
                                          context,
                                          _currDateCtrl,
                                          _currentSelectedDate,
                                        ),
                                    controller: _currDateCtrl,
                                    readOnly: true,
                                    enableInteractiveSelection: false,
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
                                _selSlot = SlotData.getIndexFromSlot(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sh * 0.06),
                    Center(
                      child: SizedBox(
                        height: sw * 0.13,
                        width: sw * 0.45,
                        child: OutlinedButton(
                          onPressed: () => _submit(context),
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

  void _submit(BuildContext context) async {
    Loading.show();
    try {
      if (_selFaculty == null || _selSlot == null) {
        return ErrorDisplay.showSnackBar(
          "Please fill all the fields before proceeding",
        );
      }
      final (response, message) = await AppointmentService.add(
        Appointment(
          appId: "appid",
          date: _currDateCtrl.text,
          clientName: CurrentUserData.name,
          clientId: CurrentUserData.rollNum,
          recipientId: _selFaculty!.facId,
          status: Status.pending,
          reason: _reasonCtrl.text,
          slot: _selSlot!,
        ).toJson(),
      );
      if (response) {
        if (CurrentUserData.role == Role.student) {
          final (res, msg) = await StudentService.fetch(
            regNo: CurrentUserData.rollNum,
          );
          if (res) {
            Student data = Student.fromJson(msg);
            data.setAsCurrentUserData();
            Rebuild.appointments();
            Loading.close();
            final context = navigatorKey.currentContext;
            if (context == null) {
              throw Exception("context not available to pop");
            }
            Navigator.pop(context);
            return;
          } else {
            return ErrorDisplay.showSnackBar(msg);
          }
        } else {
          final (res, msg) = await ClassRepService.fetch(
            regNo: CurrentUserData.rollNum,
          );
          if (res) {
            ClassRep data = ClassRep.fromJson(msg);
            data.setAsCurrentUserData();
            Rebuild.appointments();
            Loading.close();
            final context = navigatorKey.currentContext;
            if (context == null) {
              throw Exception("context not available to pop");
            }
            Navigator.pop(context);
            return;
          } else {
            return ErrorDisplay.showSnackBar(msg);
          }
        }
      } else {
        return ErrorDisplay.showSnackBar(message);
      }
    } finally {
      Loading.close();
    }
  }
}
