import 'package:flutter/material.dart';
import 'package:vpatient/style/colors.dart';

import '../../../widgets/vp_textfield.dart';

class FallRiskScaleForm extends StatelessWidget {
  const FallRiskScaleForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:5,horizontal: 10),
        child: const RiskFactor());
  }
}


class RiskFactor extends StatefulWidget {
  const RiskFactor({Key? key}) : super(key: key);

  @override
  State<RiskFactor> createState() => _RiskFactorState();
}

class _RiskFactorState extends State<RiskFactor> {
  int totalScore = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            RiskFactorHeader(),
            RiskFactorItem(title:"65 yaş üstü",score:1),
            RiskFactorItem(title:"Bilinci kapalı",score:1),
            RiskFactorItem(title:"Son bir ay içinde düşme öyküsü var",score:1),
            RiskFactorItem(title:"Kronik hastalık öyküsü var",score:1),
            RiskFactorItem(title:"Ayakta/Yürürken fiziksel desteğe ihtiyacı var",score:1),
            RiskFactorItem(title:"Ürimer/Tekal kontinans bozukluğu var",score:1),
            RiskFactorItem(title:"Görme durumu bozukluğu var",score:1),
            RiskFactorItem(title:"4'den fazla ilaç kullanımı var ",score:1),
            RiskFactorItem(title:"Hastaya bağlı 3'ün altında bakım ekipmanı var",score:1),
            RiskFactorItem(title:"Yatak korkulukları bulunmuyor/çalışmıyor",score:1),
            RiskFactorItem(title:"Yürüme alanlarında fiziksel engel(ler) var",score:1),
            RiskFactorItem(title:"Bilinç açık koopere değil",score:5),
            RiskFactorItem(title:"Ayakta yürürken denge problemi var",score:5),
            RiskFactorItem(title:"Baş dönmesi var",score:5),
            RiskFactorItem(title:"Ortostatik hipotansiyonu var",score:5),
            RiskFactorItem(title:"Görme engeli var",score:5),
            RiskFactorItem(title:"Bedensel engeli var",score:5),
            RiskFactorItem(title:"Hastaya bağlı 3 ve üstü bakım ekipmanı var",score:5),
            RiskFactorItem(title:"Son 1 hafta içinde riskli ilaç kullanımı var",score:5),
            SizedBox(
              width: 250,
              child: TextField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Toplam Puan',
                ),
                onChanged: (text) {
                  setState(() {
                    totalScore = text as int;
                  });
                },
              ),
            )


          ],
        ));
  }
}



class RiskFactorItem extends StatefulWidget {
  const RiskFactorItem({Key? key,required this.title,required this.score}) : super(key: key);

  final String title;
  final int score;
  @override
  State<RiskFactorItem> createState() => _RiskFactorItemState();
}

class _RiskFactorItemState extends State<RiskFactorItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(widget.title)
          ],
        ),
        Row(
          children: [
            Text(widget.score.toString()),
            Checkbox(
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                })
          ],
        )
      ],
    );
  }
}
class RiskFactorHeader extends StatelessWidget {
  const RiskFactorHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text("Açıklama",style: TextStyle(color:VPColors.primaryColor))
          ],
        ),
        Row(
          children: [
            Text("Puan" ,style: TextStyle(color:VPColors.primaryColor)),
            SizedBox(width: 10,)
          ],
        )
      ],
    );
  }
}

