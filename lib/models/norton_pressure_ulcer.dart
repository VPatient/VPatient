import 'dart:convert';

List<NortonPressureUlcer> nortonPressureUlcerFromJson(String str) => List<NortonPressureUlcer>.from(json.decode(str).map((x) => NortonPressureUlcer.fromJson(x)));

String nortonPressureUlcerToJson(List<NortonPressureUlcer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class NortonPressureUlcer {
    String? sId;
    int? physicalCondition;
    int? mentalCondition;
    int? activityCondition;
    int? movementCondition;
    int? incontinenceCondition;
    List<String>? factors;
    String? owner;
    String? date;
    String? createdAt;
    String? updatedAt;
    int? iV;

    NortonPressureUlcer(
        {this.sId,
            this.physicalCondition,
            this.mentalCondition,
            this.activityCondition,
            this.movementCondition,
            this.incontinenceCondition,
            this.factors,
            this.owner,
            this.date,
            this.createdAt,
            this.updatedAt,
            this.iV});

    NortonPressureUlcer.fromJson(Map<String, dynamic> json) {
        sId = json['_id'];
        physicalCondition = json['physicalCondition'];
        mentalCondition = json['mentalCondition'];
        activityCondition = json['activityCondition'];
        movementCondition = json['movementCondition'];
        incontinenceCondition = json['incontinenceCondition'];
        factors = json['factors'].cast<String>();
        owner = json['owner'];
        date = json['date'];
        createdAt = json['createdAt'];
        updatedAt = json['updatedAt'];
        iV = json['__v'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.sId;
        data['physicalCondition'] = this.physicalCondition;
        data['mentalCondition'] = this.mentalCondition;
        data['activityCondition'] = this.activityCondition;
        data['movementCondition'] = this.movementCondition;
        data['incontinenceCondition'] = this.incontinenceCondition;
        data['factors'] = this.factors;
        data['owner'] = this.owner;
        data['date'] = this.date;
        data['createdAt'] = this.createdAt;
        data['updatedAt'] = this.updatedAt;
        data['__v'] = this.iV;
        return data;
    }
}
