import 'package:flutter/material.dart';
import 'package:vpatient/models/patient.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    Key? key,
    required this.patient,
  }) : super(key: key);

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                  color: patient.gender == "Erkek"
                      ? Colors.blue[400]!.withOpacity(0.5)
                      : Colors.purple[400]!.withOpacity(0.5))
            ],
            borderRadius: BorderRadius.circular(10),
            color: patient.gender == "Erkek"
                ? Colors.blue[400]
                : Colors.purple[400]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/${patient.gender}-1.png",
              width: 150,
            ),
            Text(patient.name,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Yaş",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text("${patient.age}",
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Divider(color: Colors.white, thickness: .75),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Cinsiyet",
                          style: TextStyle(color: Colors.white)),
                      Text(patient.gender,
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
