import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/chat_simulation/forms/util/FormConstants.dart';
import 'package:vpatient/screens/chat_simulation/forms/util/FormWidgets.dart';
import 'package:vpatient/widgets/vp_textfield.dart';



class SocialDemographicForm extends StatelessWidget {
 const  SocialDemographicForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FormContent();
  }
}


class FormContent extends StatelessWidget {
  const FormContent({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2.0,top: 50.0,right: 2.0,bottom: 2.0),
      child: SingleChildScrollView(
        child: Column(
          children: const [
             SizedBox(height: 5),
            FormHeader(text: socialDemographicFormHeader),
             VpTextField(
                hint: "Ad Soyad",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Cinsiyet",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Yaş",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Medeni Durum",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Eğitim Düzeyi",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Meslek",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Çocuk Sayısı",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Sosyal Güvence",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Irk/Din",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Refakatçisi",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Kan Grubu",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Bulaşıcı Hastalık",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Primer Tıbbi Tanı",
                keyboardType: TextInputType.text
            ),
             VpTextField(
                hint: "Boy",
                keyboardType: TextInputType.number
            ),
             VpTextField(
                hint: "Kilo",
                keyboardType: TextInputType.number
            ),
             VpTextField(
                hint: "BKI",
                keyboardType: TextInputType.number
            )
          ],
        ),
      ),
    );
  }
}


