import 'package:flutter/material.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

class SocialDemographicForm extends StatelessWidget {
  const SocialDemographicForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: [
            VPTextField(
              text: "Ad Soyad",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
                text: "Cinsiyet",
                keyboardType: TextInputType.text,
                controller: TextEditingController()),
            VPTextField(
              text: "Yaş",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Medeni Durum",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Eğitim Düzeyi",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Meslek",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Çocuk Sayısı",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Sosyal Güvence",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Irk/Din",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Refakatçisi",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Kan Grubu",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Bulaşıcı Hastalık",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Primer Tıbbi Tanı",
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Boy",
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "Kilo",
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
            ),
            VPTextField(
              text: "BKI",
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
            )
          ],
        ),
      ),
    );
  }
}

/*class FormContent extends StatelessWidget {
  const FormContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  }
}
*/