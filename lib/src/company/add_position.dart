import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';
import 'package:tamkeen_flu/src/helpers/globalSnackbar.dart';

import '../components/appbar.dart';
import '../components/globals.dart';
import '../helpers/button.dart';
import '../helpers/spacer.dart';

class AddPositionScreen extends StatefulWidget {
  const AddPositionScreen({super.key});

  @override
  State<AddPositionScreen> createState() => _AddPositionScreenState();
}

class _AddPositionScreenState extends State<AddPositionScreen> {
  String dropdownvalue = 'Select A Job Level';
  var items = [
    'Fresh',
    'Junior Level',
    'Mid Level',
    'Senior Level',
  ];
  add() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await api.AddTraineeposition(
          titleController.text,
          USER_ID.toString(),
          experiance.text,
          dropdownvalue,
          jobRoles.text,
          keyResponsible.text);
      print("res $res");
      if (res['codeStatus'] == true) {
        showInSnackBar('Position Added');
        setState(() {
          isLoading = false;
          titleController.clear();
          experiance.clear();
          jobRoles.clear();
          keyResponsible.clear();
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
  TextEditingController titleController = TextEditingController();
  TextEditingController experiance = TextEditingController();
  TextEditingController jobRoles = TextEditingController();
  TextEditingController keyResponsible = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(USER_ID);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        title: LANGUAGE == 'ENGLISH' ? 'Add Position' : "أضف الوظيفة",
        back: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(
                    LANGUAGE == "ENGLISH"
                        ? 'Title of position'
                        : "عنوان الوظيفة",
                    Icons.edit_document,
                    titleController),
                _buildTextField(LANGUAGE == "ENGLISH" ? 'Experiance' : "خبرة",
                    Icons.note, experiance),
                Container(
                  child: Card(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                      ),
                      dropdownColor: Colors.white,
                      value: dropdownvalue,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      items: <String>[
                        'Select A Job Level',
                        'Fresh',
                        'Junior Level',
                        'Mid Level',
                        'Senior Level',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 18, fontFamily: "caviarbold"),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                _buildTextField2(
                    LANGUAGE == "ENGLISH" ? 'Job Roles' : "أدوار الوظيفة",
                    Icons.note,
                    jobRoles),
                _buildTextField2(
                    LANGUAGE == "ENGLISH"
                        ? 'Key Responsibilities'
                        : "المهام الأساسية",
                    Icons.note,
                    keyResponsible),
                vertical(40),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : buttonmain(() {
                        if (titleController.text.isEmpty ||
                            experiance.text.isEmpty ||
                            jobRoles.text.isEmpty ||
                            keyResponsible.text.isEmpty) {
                          showInSnackBar('Please fill all fields',
                              color: Colors.red);
                        } else {
                          add();
                        }
                      }, 'Submit', 0.5, context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTextField2(
      String label, IconData icon, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        maxLines: 5,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
