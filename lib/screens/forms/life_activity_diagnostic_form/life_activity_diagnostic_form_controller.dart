import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class LifeActivityDiagnosisFormController extends BaseForm
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() async {
    super.onInit();
    formData = await getResults();
    formList = formData.map((e) => e['form_title']).toList();
    tabController = TabController(length: formList.length, vsync: this);
  }

  late final TabController tabController;
  late List<dynamic> formList;
  late List<dynamic> formData;

  Future<List<dynamic>> getResults() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getLifeActivityDiagnosisById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      VPSnackbar.error(response.body);
      return List<dynamic>.empty();
    }
  }

  var sampleData = [
    {
      "form_title": "form-1",
      "data": [
        {
          "questions": [
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": [
                "Normal",
                "Azalma",
                "Görmüyor",
                "Miyop",
                "Hipermetrop",
                "Diğer"
              ],
              "correct_answer": "Normal",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Görme Duyusu",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["İzokorik", "Anzikorik", "Diplopi", "Diğer"],
              "correct_answer": "İzokorik",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Pupillerin Durumu",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": [
                "Normal",
                "Azalma",
                "İşitmiyor",
                "İşitme aracı kullanıyor",
                "Çınlama",
                "Akıntı",
                "Ağrı",
                "Vertigo",
                "Diğer"
              ],
              "correct_answer": "Azalma",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "İşitme",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": [
                "Normal",
                "Sinüzit",
                "Rinit",
                "Akıntı",
                "Tıkanıklık",
                "Epistakis",
                "Diğer"
              ],
              "correct_answer": "Normal",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Koku Alma Durumu",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["Normal", "Azalma", "Hissetmiyor"],
              "correct_answer": "Normal",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Dokunma Duyusu",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
          ]
        }
      ]
    },
    {
      "form_title": "form-2",
      "data": [
        {
          "questions": [
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["Normal", "Azalma", "Hissetmiyor"],
              "correct_answer": "Normal",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Dokunma Duyusu",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["Var", "Yok"],
              "correct_answer": "Yok",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Baş Dönmesi",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["Var", "Yok"],
              "correct_answer": "Var",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Yorgunluk",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["Var", "Yok"],
              "correct_answer": "Yok",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Konvülsiyon",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["Var", "Yok"],
              "correct_answer": "Var",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Uyku Problemi",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["Açık", "Yarı Açık", "Kapalı"],
              "correct_answer": "Açık",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Bilinç Durumu",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": [
                "Normal",
                "Saldırgan(Agresif)",
                "Sinirli",
                "Sıkıntılı",
                "Diğer"
              ],
              "correct_answer": "Sıkıntılı",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Ruhsal Durum",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            },
            {
              "question_id": "60e0a77c10926d0f006834a1",
              "fields": ["Normal", "Hipotansif", "Hipertansif"],
              "correct_answer": "Normal",
              "_id": "60dc6a3dc9fe14577c30d272",
              "title": "Kan Basıncı",
              "description": "",
              "remark": false,
              "type": "dropdown",
              "is_mandatory": true
            }
          ]
        }
      ]
    }
  ];
}
