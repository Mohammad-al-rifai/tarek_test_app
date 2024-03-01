import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tarek_test_app/src/core/utils/functions.dart';
import 'package:tarek_test_app/src/data/models/employee_model.dart';
import 'package:tarek_test_app/src/presentations/component/button.dart';
import 'package:tarek_test_app/src/presentations/component/text_form_field.dart';
import 'package:tarek_test_app/src/presentations/cubits/database_cubit/database_cubit.dart';
import 'package:tarek_test_app/src/presentations/widgets/employee_address.dart';

import '../component/image_picker.dart';

class AddEmployeeView extends StatefulWidget {
  const AddEmployeeView({super.key});

  @override
  State<AddEmployeeView> createState() => _AddEmployeeViewState();
}

class _AddEmployeeViewState extends State<AddEmployeeView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  File? image;

  String initialCountry = 'AE';
  PhoneNumber number = PhoneNumber(isoCode: 'AE');

  String myPhone = '';

  bool isPhoneValid = false;

  Employee employee = Employee();

  Future<void> binding() async {
    employee.name = nameController.text;
    employee.position = positionController.text;
    employee.salary = double.parse(salaryController.text);
    employee.email = emailController.text;
    employee.phoneNumber = myPhone;

    employee.address = addressController.text;
    employee.department = departmentController.text;
    employee.photo = await fileToBase64(image!);
    myPrint(text: 'This is My Image: ${employee.photo}');
  }

  @override
  void initState() {
    addressController.text = DatabaseCubit.get(context).city.text;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    salaryController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    departmentController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addressController.text = DatabaseCubit.get(context).city.text;
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return AppBar(
      title: const Text('Add a new employee'),
    );
  }

  getBody() {
    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {
        if (state is AddEmployeeDoneState) {
          myPrint(text: 'Done');
          popScreen(context);
        }
        if (state is SetCityDoneState) {
          setState(() {});
        }
      },
      builder: (context, state) {
        DatabaseCubit cubit = DatabaseCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TFF(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Name must not be Empty';
                      }
                    },
                    label: 'Name',
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 15.0),
                  TFF(
                    controller: positionController,
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Position must not be Empty';
                      }
                    },
                    label: 'Position',
                    prefixIcon: Icons.manage_accounts,
                  ),
                  const SizedBox(height: 15.0),
                  TFF(
                    controller: salaryController,
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Salary must not be Empty';
                      }
                    },
                    label: 'Salary',
                    prefixIcon: Icons.currency_pound,
                  ),
                  const SizedBox(height: 15.0),
                  TFF(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'E-mail must not be Empty';
                      }
                    },
                    label: 'E-mail',
                    prefixIcon: Icons.mail,
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      Expanded(
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {},
                          onInputValidated: (bool value) {
                            if (value) {
                              setState(() {
                                isPhoneValid = true;
                              });
                            } else {
                              setState(() {
                                isPhoneValid = false;
                              });
                            }
                          },
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            useBottomSheetSafeArea: true,
                          ),
                          selectorTextStyle: const TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                          ),
                          initialValue: number,
                          textFieldController: phoneNumberController,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                          inputBorder: const OutlineInputBorder(),
                          inputDecoration: const InputDecoration(
                            label: Text('Phone'),
                            hintText: 'Phone',
                            prefixIcon: Icon(
                              CupertinoIcons.phone,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (PhoneNumber number) {
                            myPrint(text: number.phoneNumber ?? '');
                            myPhone =
                                (number.phoneNumber ?? '');
                            myPrint(text: 'myPhone: $myPhone');
                          },
                          countries: const [
                            "SY",
                            "QA",
                            "SA",
                            "AE",
                            "BH",
                            "KW",
                            "OM",
                            "TR",
                            "JO",
                            "IQ",
                            "LB"
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 4,
                        ),
                        child: Icon(
                          isPhoneValid
                              ? CupertinoIcons.checkmark_seal_fill
                              : CupertinoIcons.checkmark_seal,
                          color: isPhoneValid ? Colors.green : Colors.grey,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  TFF(
                    controller: addressController,
                    keyboardType: TextInputType.none,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Address must not be Empty';
                      }
                    },
                    label: 'Address',
                    prefixIcon: Icons.location_on_rounded,
                    onTap: () {
                      navigateTo(context, const EmployeeAddress());
                    },
                  ),
                  const SizedBox(height: 15.0),
                  TFF(
                    controller: departmentController,
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Department must not be Empty';
                      }
                    },
                    label: 'Department',
                    prefixIcon: Icons.business,
                  ),
                  const SizedBox(height: 18.0),
                  ImagePickerType(
                    getFile: (File? image) {
                      this.image = image;
                    },
                    errorText: 'Please Select Employee Image',
                  ),
                  const SizedBox(height: 18.0),
                  DefaultButton(
                    function: () async {
                      if (formKey.currentState!.validate() && image != null) {
                        formKey.currentState?.save();
                        await binding();
                        cubit.addEmployee(employee: employee);
                      }
                    },
                    text: 'Submit',
                    isLoading: state is AddEmployeeLoadingState,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
