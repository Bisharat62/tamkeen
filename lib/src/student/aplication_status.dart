import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/company/search_student_details.dart';
import 'package:tamkeen_flu/src/components/appbar.dart';

import '../components/globals.dart';
import '../helpers/button.dart';
import '../helpers/const_text.dart';
import '../helpers/globalSnackbar.dart';

class ApplicationStatus extends StatefulWidget {
  const ApplicationStatus({super.key});

  @override
  State<ApplicationStatus> createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  List list = [];
  getapplication() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await api.getAppliedPositions(USER_ID.toString());
      print("res $res");
      if (res['codeStatus'] == true) {
        list = res['data'];
        setState(() {
          isLoading = false;
        });
      } else {
        showInSnackBar(res['message'], color: Colors.red);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  bool isLoading = false;
  // String dropdownvalue = 'Pending';
  var items = [
    'Pending',
    'Approved',
    'Rejected',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getapplication();
  }

  @override
  Widget build(BuildContext context) {
    print(USER_ID);
    return Scaffold(
      appBar: Appbar(
        title: 'View Applications Status',
        back: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : list.isEmpty
              ? Center(
                  child: boldtext(Colors.red, 14, "No Applications Available"))
              : ListView.builder(
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            rowCard("Position", "${list[index]['title']}"),
                            rowCard(
                                "Student Name", "${list[index]['stu_name']}"),
                            rowCard(
                                "Student Email", "${list[index]['stu_email']}"),
                            rowCard(
                                "Student Phone", "${list[index]['stu_phone']}"),
                            rowCard(
                              "Status",
                              "",
                              child: DropdownButton(
                                value: "${list[index]['status']}",
                                underline: const Divider(thickness: 2),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: boldtext(Colors.black, 14, items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  // setState(() {
                                  //   dropdownvalue = newValue!;
                                  // });
                                },
                              ),
                            ),
                            rowCard("Action", "",
                                child: buttonmain(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudentDetailsScreen(
                                                student_id:
                                                    "${list[index]['student_id']}",
                                              )));
                                }, 'view', 0.2, context,
                                    fsize: 13, height: 35)),
                          ],
                        ),
                      ),
                    );
                  }),
    );
  }
}

//position studentName Stu email stuPhone status action
Widget rowCard(String text1, String text2, {Widget? child}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        boldtext(Colors.black, 14, text1),
        child ??
            boldtext(
              Colors.black,
              14,
              text2,
            )
      ],
    ),
  );
}
