// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import '../components/textFormField.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({super.key});

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  int _currentstep = 0;
  static int rnumber = 0;
  final TextEditingController companynamecontroller = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController activitytypeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController idnumberController = TextEditingController();
  bool val = true;
  DateTime? selectedDate;

  @override
  void dispose() {
    companynamecontroller.dispose();
    addressController.dispose();
    numberController.dispose();
    emailController.dispose();
    activitytypeController.dispose();
    nameController.dispose();
    birthdayController.dispose();
    nationalityController.dispose();
    idnumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Safeer SIM',
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromRGBO(94, 23, 235, 1),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stepper(
                currentStep: _currentstep,
                type: StepperType.vertical,
                physics: const ScrollPhysics(),
                onStepTapped: (int Index) {
                  setState(() {
                    _currentstep = Index;
                  });
                },
                onStepContinue: () async {
                  try {
                    if (_currentstep != 2) {
                      setState(() {
                        _currentstep += 1;
                      });
                    } else {
                      if (val == true &&
                          activitytypeController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          numberController.text.isNotEmpty &&
                          nationalityController.text.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          companynamecontroller.text.isNotEmpty &&
                          idnumberController.text.isNotEmpty) {
                        Navigator.of(context).pop();
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.rightSlide,
                          dialogType: DialogType.success,
                          body: const Center(
                            child: Text(
                              'Request added successfully!',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          title: 'Success!',
                          btnOkOnPress: () {},
                        ).show();
                        rnumber++;
                        CollectionReference collRef =
                            FirebaseFirestore.instance.collection('Request');
                        await collRef.add({
                          'activity': activitytypeController.text,
                          'address': addressController.text,
                          'birthday': selectedDate?.toString(),
                          'company_name': companynamecontroller.text,
                          'email': emailController.text,
                          'idnumber': idnumberController.text,
                          'name': nameController.text,
                          'nationality': nationalityController.text,
                          'phone': numberController.text,
                          'state': "Processing",
                          "request": "Request $rnumber",
                        });
                      } else {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.rightSlide,
                          dialogType: DialogType.warning,
                          body: const Center(
                            child: Text(
                              'Please fill the form and check it!',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          btnOkColor: Colors.orange,
                          title: 'Warning!',
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }
                  } catch (e) {
                    print('Firestore Error: $e');
                    // Handle the error as needed
                  }
                },
                onStepCancel: () {
                  if (_currentstep != 0) {
                    setState(() {
                      _currentstep -= 1;
                    });
                  }
                },
                steps: [
                  Step(
                    title: const Text("Personal information of the applicant"),
                    content: Column(
                      children: [
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          label: "First name",
                          hinttext: 'Enter Your first name',
                          mycontroller: companynamecontroller,
                        ),
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          label: "Last name",
                          hinttext: 'Enter Your last name',
                          mycontroller: companynamecontroller,
                        ),
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          label: "Address",
                          hinttext: 'Enter Your address',
                          mycontroller: addressController,
                        ),
                                                Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Birthday Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Container(
                              height: 10,
                            ),
                            DateTimeFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Your birthday date",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 122, 122, 122),
                                  ),
                                ),
                              ),
                              firstDate:
                                  DateTime.now().add(const Duration(days: 10)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 40)),
                              initialPickerDateTime:
                                  DateTime.now().add(const Duration(days: 20)),
                              onChanged: (DateTime? value) {
                                setState(() {
                                  selectedDate = value;
                                });
                              },
                            ),
                            Container(
                              height: 10,
                            ),
                          ],
                        ),
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          label: "Phone Number",
                          hinttext: 'Enter Your phone number',
                          mycontroller: numberController,
                        ),
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          label: "Email",
                          hinttext: 'Enter Your email',
                          mycontroller: emailController,
                        ),
                      ],
                    ),
                    isActive: _currentstep >= 0,
                    state: _currentstep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    isActive: _currentstep >= 0,
                    state: _currentstep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                    title: const Text("Payement information"),
                    content: Column(
                      children: [
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          label: "ZIP Code",
                          hinttext: 'Enter Your ZIP code',
                          mycontroller: nameController,
                        ),
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          label: "Area Code",
                          hinttext: 'Enter Your area code',
                          mycontroller: nationalityController,
                        ),
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          label: "Credit Card Number",
                          hinttext: 'Enter Your id credit card number',
                          mycontroller: idnumberController,
                        ),
                        CustomTextForm(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          label: "CVC",
                          hinttext: 'Enter Your CVC',
                          mycontroller: idnumberController,
                        ),
                      ],
                    ),
                  ),
                  Step(
                    isActive: _currentstep >= 0,
                    state: _currentstep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                    title: const Text("Statement"),
                    content: Column(
                      children: [
                        CheckboxListTile(
                          title: const Text("Confirmation"),
                          subtitle: const Text(
                              'I declare that all information provided is accurate and complete.'),
                          value: val,
                          onChanged: (bool? value) {
                            setState(() {
                              val = !val;
                            });
                          },
                          secondary: const Icon(Icons.check),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
