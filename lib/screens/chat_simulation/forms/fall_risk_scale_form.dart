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

    void udapteTotalScore(int score) {
      setState(() {
        totalScore += score;
      });

    }

    return SingleChildScrollView(
        child: Column(
          children: [
            RiskFactorHeader(),
            RiskFactorItem(title:"65 yaş üstü",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Bilinci kapalı",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Son bir ay içinde düşme öyküsü var",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Kronik hastalık öyküsü var",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Ayakta/Yürürken fiziksel desteğe ihtiyacı var",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Ürimer/Tekal kontinans bozukluğu var",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Görme durumu bozukluğu var",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"4'den fazla ilaç kullanımı var ",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Hastaya bağlı 3'ün altında bakım ekipmanı var",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Yatak korkulukları bulunmuyor/çalışmıyor",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Yürüme alanlarında fiziksel engel(ler) var",score:1,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Bilinç açık koopere değil",score:5,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Ayakta yürürken denge problemi var",score:5,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Baş dönmesi var",score:5,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Ortostatik hipotansiyonu var",score:5,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Görme engeli var",score:5,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Bedensel engeli var",score:5,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Hastaya bağlı 3 ve üstü bakım ekipmanı var",score:5,updateTotalScore:udapteTotalScore),
            RiskFactorItem(title:"Son 1 hafta içinde riskli ilaç kullanımı var",score:5,updateTotalScore:udapteTotalScore),
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
            ),
            Divider(),
            DeterminingRiskLevel()
            


          ],
        ));
  }
}
class DeterminingRiskLevel extends StatefulWidget {
  const DeterminingRiskLevel({Key? key}) : super(key: key);

  @override
  State<DeterminingRiskLevel> createState() => _DeterminingRiskLevelState();
}

class _DeterminingRiskLevelState extends State<DeterminingRiskLevel> {
  bool lowIsChecked = false;
  bool highIsChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      checkColor: Colors.white,
                      value: lowIsChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          lowIsChecked = value!;
                        });
                      }),
                  Text("Düşük Risk")
                ],
              ),
              Text("Toplam puan 5'in altında")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      checkColor: Colors.white,
                      value: lowIsChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          lowIsChecked = value!;
                        });
                      }),
                  Text("Yüksek Risk")
                ],
              ),
              Text("Toplam puan 5 ve 5'in üstünde"),
              Text("(Dört yapraklı yonca figürü kullanılabilir)")
            ],
          )
        ],
      ),
    );
  }
}




class RiskFactorItem extends StatefulWidget {
  const RiskFactorItem({Key? key,required this.title,required this.score,required this.updateTotalScore}) : super(key: key);

  final Function updateTotalScore;
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

                    widget.updateTotalScore(value == true ? widget.score : -widget.score);
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

