/* import 'package:apho/services/auth_provider_widget.dart';
import 'package:apho/services/communications.dart';
import 'package:apho/services/navigation.dart';
import 'package:apho/widgets/custom_dialog_box.dart';
import 'package:apho/widgets/top_back_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:apho/widgets/proceed_button.dart';

class OrderMedicine extends StatefulWidget {
  OrderMedicine({Key key}) : super(key: key);

  @override
  _OrderMedicineState createState() => _OrderMedicineState();
}

class _OrderMedicineState extends State<OrderMedicine> {
  int count = 0;
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              BackBar(
                icon: null,
                onPressed: null,
                text: "Order for some Medicine",
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            color: Colors.black.withOpacity(0.5),
                            colorBlendMode: BlendMode.darken,
                            image: AssetImage(
                              "assets/images/medications.jpg",
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Covid 19 Vaccine",
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "250,000 UGX",
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (count != 0) count--;
                                });
                              },
                              child: Icon(
                                Icons.remove_circle_outline,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  count.toString(),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  count++;
                                });
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProceedButton(
        enablable: true,
        onTap: () {
          dynamic user = AuthProvider.of(context).auth.getCurrentUser();

          if (user == null) {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogBox(
                    bodyText: null,
                    onButtonTap: null,
                    showOtherButton: false,
                    showSignInButton: true,
                    buttonText: "Sign In",
                  );
                });
          } else {
            setState(() {
              processing = true;
            });
            
            FirebaseFirestore.instance.collection("orders").add({
              "name": "Covid 19 Vaccine",
              "price": 250000,
              "quantity": count,
              "date": DateTime.now().millisecondsSinceEpoch,
            }).then((value) {
              FirebaseDatabase.instance
                  .ref()
                  .child("orders")
                  .child(user.uid)
                  .update({
                value.id: DateTime.now().millisecondsSinceEpoch,
              });

              NavigationService().pop(context);
              CommunicationServices().showToast(
                "Your order has been placed",
                Colors.blue,
              );
            });
          }
        },
        enabled: count != 0,
        text: "Place Order",
        processable: true,
        processing: processing,
      ),
    );
  }
}
 */