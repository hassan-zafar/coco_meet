import 'package:coco_meet/Utils/constants.dart';
import 'package:coco_meet/screens/Admin%20Screens/upload_event.dart';
import 'package:coco_meet/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MyProfilePageScreen extends StatefulWidget {
  const MyProfilePageScreen({super.key});

  @override
  State<MyProfilePageScreen> createState() => _MyProfilePageScreenState();
}

class _MyProfilePageScreenState extends State<MyProfilePageScreen> {
  String value = 'male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill Your Profile',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(profilePerson),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.edit,
                            size: 26,
                          ),
                        ))
                  ],
                ),
              ),
              CustomTextField(hintText: 'Full Name'),
              CustomTextField(hintText: 'Nickname'),
              CustomTextField(
                hintText: 'Date of Birth',
                suffixIcon: Icons.date_range_outlined,
              ),
              CustomTextField(hintText: 'Email', suffixIcon: Icons.email),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              DropdownButton(
                hint: const Text(
                    'Choose the Gender'), // Not necessary for Option 1
                value: value,

                items: const [
                  DropdownMenuItem(
                    value: 'male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'female',
                    child: Text('Female'),
                  ),
                ],
                onChanged: (newValue) {
                  setState(() {
                    value = newValue!;
                  });
                },
              ),
              BlueElevatedButton(
                  text: 'Continue',
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UploadEventForm(isEditable: true),
                    ));
                  })),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
  }) : super(key: key);
  String hintText;
  IconData? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12.0),
            ),
            // border: InputBorder.none,
            filled: true,
            suffixIcon: Icon(suffixIcon),
            fillColor: Colors.grey.shade100),
      ),
    );
  }
}
