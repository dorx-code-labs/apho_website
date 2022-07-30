import 'package:apho/constants/images.dart';
import 'package:apho/models/feedback.dart';
import 'package:apho/services/communications.dart';
import 'package:apho/services/ui_services.dart';
import 'package:apho/views/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/core.dart';
import '../widgets/nimbus_button.dart';

class ContactUsView extends StatefulWidget {
  final Function(dynamic) onTapItem;
  ContactUsView({
    Key key,
    @required this.onTapItem,
  }) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView>
    with AutomaticKeepAliveClientMixin {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return body();
  }

  body() {
    return Scrollbar(
      controller : controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: UIServices().decorationImage(
                  familyNurse,
                  true,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 60),
              child: Column(
                children: [
                  Text(
                    "CONTACT US",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '''Have any questions? We’d love to hear from you. Feel free to use the form on the right to have a team member contact you.
‍
Or come visit us in person!''',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "First Name",
                    ),
                    controller: firstNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Last Name",
                    ),
                    controller: secondNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                    ),
                    controller: phoneNumberController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Description",
                    ),
                    controller: descriptionController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NimbusButton(
                    buttonTitle: "Submit",
                    onPressed: () {
                      if (firstNameController.text.trim().isEmpty) {
                        CommunicationServices().showToast(
                          "Please provide your first name.",
                          Colors.red,
                        );
                      } else {
                        if (secondNameController.text.trim().isEmpty) {
                          CommunicationServices().showToast(
                            "Please provide your second name.",
                            Colors.red,
                          );
                        } else {
                          if (phoneNumberController.text.trim().isEmpty) {
                            CommunicationServices().showToast(
                              "Please provide your phone number.",
                              Colors.red,
                            );
                          } else {
                            if (emailController.text.trim().isEmpty) {
                              CommunicationServices().showToast(
                                "Please provide your email.",
                                Colors.red,
                              );
                            } else {
                              if (descriptionController.text.trim().isEmpty) {
                                CommunicationServices().showToast(
                                  "Please provide your message.",
                                  Colors.red,
                                );
                              } else {
                                FirebaseFirestore.instance
                                    .collection(UserFeedback.DIRECTORY)
                                    .add(
                                  {
                                    UserFeedback.DATE:
                                        DateTime.now().millisecondsSinceEpoch,
                                    UserFeedback.SENDER: null,
                                    UserFeedback.REASON:
                                        descriptionController.text.trim(),
                                    UserFeedback.MORE:
                                        "Website user: ${firstNameController.text.trim()} ${secondNameController.text.trim()} ${emailController.text.trim()} ${phoneNumberController.text.trim()}"
                                  },
                                ).then((value) {
                                  CommunicationServices().showToast(
                                    "Successfully submitted your feedback",
                                    Colors.green,
                                  );
                                });
                              }
                            }
                          }
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.purple.withOpacity(0.2),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Visit Us",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Plot 13 Old Kira Road, Kamwokya",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                    icon: Icon(Icons.phone),
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                          "tel:$aphoPhoneNumber",
                        ),
                      );
                    },
                    label: Text(
                      "Call Us",
                    ),
                  )
                ],
              ),
            ),
            Footer(
              onTapItem: widget.onTapItem,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
