// To parse this JSON data, do
//
//     final mItem = mItemFromJson(jsonString);

import 'dart:convert';

MItem mItemFromJson(String str) => MItem.fromJson(json.decode(str));

String mItemToJson(MItem data) => json.encode(data.toJson());

class MItem {
    MItem({
        required this.id,
        required this.title,
        required this.text,
        required this.date,
        required this.time,
    });

    String id;
    String title;
    String text;
    String date;
    String time;

    factory MItem.fromJson(Map<String, dynamic> json) => MItem(
        id: json["id"],
        title: json["title"],
        text: json["text"],
        date: json["date"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "text": text,
        "date": date,
        "time": time,
    };
}
