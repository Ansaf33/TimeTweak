import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';

class AppointmentRequest extends StatelessWidget {
  AppointmentRequest({super.key});

  final ValueNotifier<String?> _suggested = ValueNotifier(null);
  final TextEditingController _suggestedCtrl = TextEditingController();

  final String currDate = "22-03-2026";
  final String currSlot = "A1";
  final String desc = "please cancel";
  final String student = "Saleena Nazeer";
  final String regNo = "B220001CS";

  Future<void> _selectDate(
    BuildContext context,
    ValueNotifier notifier,
    TextEditingController ctrl,
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
                    "Appointment Request",
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: sw * 0.06,
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
                    SizedBox(height: sh * 0.03),
                    Padding(
                      //Description
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                      child: TextFormField(
                        initialValue: desc,
                        enabled: false,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Description",
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: sh * 0.02,
                        left: sw * 0.05,
                        right: sw * 0.05,
                      ),
                      child: TextFormField(
                        initialValue: student,
                        ignorePointers: true,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Requested by",
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: sh * 0.02,
                        left: sw * 0.05,
                        right: sw * 0.05,
                      ),
                      child: TextFormField(
                        initialValue: regNo,
                        ignorePointers: true,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Register Number",
                          disabledBorder: OutlineInputBorder(
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
                            child: TextFormField(
                              initialValue: currDate,
                              enabled: false,
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: sw * 0.05),
                          Expanded(
                            child: TextFormField(
                              initialValue: currSlot,
                              enabled: false,
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sw * 0.03),
                    Divider(
                      thickness: 2,
                      indent: sw * 0.05,
                      endIndent: sw * 0.05,
                      color: Colors.grey[400],
                    ),

                    SizedBox(height: sh * 0.03),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.2),
                      child: SizedBox(
                        height: sw * 0.15,
                        width: sw * 0.6,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              const Color.fromARGB(255, 14, 135, 18),
                            ),
                          ),
                          child: Text(
                            "Approve",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Outfit',
                              fontSize: sw * 0.06,
                              fontVariations: [FontVariation.weight(500)],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sh * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.2),
                      child: SizedBox(
                        height: sw * 0.15,
                        width: sw * 0.6,
                        child: OutlinedButton(
                          onPressed: () => _displayBottomSheet(context, sw),
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              const Color.fromARGB(255, 170, 18, 18),
                            ),
                          ),
                          child: Text(
                            "Decline",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Outfit',
                              fontSize: sw * 0.06,
                              fontVariations: [FontVariation.weight(500)],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SizedBox(
                    //         height: sw * 0.13,
                    //         width: sw * 0.425,
                    //         child: OutlinedButton(
                    //           onPressed: () {},
                    //           style: ButtonStyle(
                    //             shape: WidgetStatePropertyAll(
                    //               RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //             ),
                    //             backgroundColor: WidgetStatePropertyAll(
                    //               Colors.green,
                    //             ),
                    //           ),
                    //           child: Text(
                    //             "Approve",
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontFamily: 'Outfit',
                    //               fontSize: sw * 0.05,
                    //               fontVariations: [FontVariation.weight(500)],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(width: sw * 0.05),
                    //       SizedBox(
                    //         height: sw * 0.13,
                    //         width: sw * 0.425,
                    //         child: OutlinedButton(
                    //           onPressed: () => _displayBottomSheet(context, sw),
                    //           style: ButtonStyle(
                    //             shape: WidgetStatePropertyAll(
                    //               RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //             ),
                    //             backgroundColor: WidgetStatePropertyAll(
                    //               const Color.fromARGB(255, 231, 86, 86),
                    //             ),
                    //           ),
                    //           child: Text(
                    //             "Decline",
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontFamily: 'Outfit',
                    //               fontSize: sw * 0.05,
                    //               fontVariations: [FontVariation.weight(500)],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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

  Future _displayBottomSheet(BuildContext context, double sw) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: sw * 0.05),
              Text(
                "Alternate Slot",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: sw * 0.07,
                ),
              ),
              SizedBox(height: sw * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                child: Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _suggested,
                        builder:
                            (context, value, _) => TextFormField(
                              onTap:
                                  () async => _selectDate(
                                    context,
                                    _suggested,
                                    _suggestedCtrl,
                                  ),
                              controller: _suggestedCtrl,
                              readOnly: true,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              decoration: InputDecoration(
                                hintText: "Select Date",
                                hintStyle: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Theme.of(context).colorScheme.surface,
                                  fontVariations: [FontVariation.weight(400)],
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
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
                          constraints: BoxConstraints(maxHeight: sw * 0.3),
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              labelText: "Search...",
                              labelStyle: TextStyle(
                                fontFamily: 'Outfit',
                                color: Theme.of(context).colorScheme.surface,
                                fontVariations: [FontVariation.weight(400)],
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        items: SlotData.allSlots,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Slot",
                            labelStyle: TextStyle(
                              fontFamily: 'Outfit',
                              color: Theme.of(context).colorScheme.surface,
                              fontVariations: [FontVariation.weight(400)],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.surface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).colorScheme.surface,
                              ),
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
              SizedBox(height: sw * 0.1),
              SizedBox(
                height: sw * 0.12,
                width: sw * 0.6,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Offer Alternate Slot",
                    style: TextStyle(fontSize: sw * 0.05),
                  ),
                ),
              ),
              SizedBox(height: sw * 0.18),
            ],
          ),
    );
  }
}
