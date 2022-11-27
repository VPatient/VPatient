import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          children:  [
            const SizedBox(height: 5),
            Text("Sosyo Demografik Form",style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize:25)),
            const VpTextField(
                hint: "Ad Soyad",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Cinsiyet",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Yaş",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Medeni Durum",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Eğitim Düzeyi",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Meslek",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Çocuk Sayısı",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Sosyal Güvence",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Irk/Din",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Refakatçisi",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Kan Grubu",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Bulaşıcı Hastalık",
                keyboardType: TextInputType.text
            ),
            const VpTextField(
                hint: "Primer Tıbbi Tanı",
                keyboardType: TextInputType.text
            )
          ],
        ),
      ),
    );
  }
}


