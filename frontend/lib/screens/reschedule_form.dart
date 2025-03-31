import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';

class RescheduleForm extends StatelessWidget {
  RescheduleForm({super.key});

  final ValueNotifier<DateTime> _currentSelectedDate = ValueNotifier(
    DateTime.now(),
  );
  final ValueNotifier<DateTime> _newSelectedDate = ValueNotifier(
    DateTime.now(),
  );
  final TextEditingController _currDateCtrl = TextEditingController();
  final TextEditingController _newDateCtrl = TextEditingController();

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
      ctrl.text = "${picked.day}-${picked.month}-${picked.year}";
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
                        items: CourseData.allcourses,
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
                        onChanged:
                            (value) {}, //TODO Implement reschedule form data handle also verification
                      ),
                    ),
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
                        items: FacultyData.allFaculties,
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
                        onChanged: (value) {},
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
                              items: FacultyData.allFaculties,
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
                              onChanged: (value) {},
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
                                        () async => _selectDate(
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
                              items: FacultyData.allFaculties,
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
                              onChanged: (value) {},
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
                          onPressed: () {},
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
}
