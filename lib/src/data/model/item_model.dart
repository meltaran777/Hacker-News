import 'dart:convert';

class ItemModel {
  final String by;
  final int descendants;
  final int id;
  final List<int> kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  ItemModel.fromJsonMap(Map<String, dynamic> map)
      : by = map["by"],
        descendants = map["descendants"],
        id = map["id"],
        kids = map["kids"] != null ? List<int>.from(map["kids"]) : null,
        score = map["score"],
        time = map["time"],
        title = map["title"],
        type = map["type"],
        url = map["url"];

  ItemModel.fromDb(Map<String, dynamic> map)
      : by = map["by"],
        descendants = map["descendants"],
        id = map["id"],
        kids = jsonDecode(map["kids"]) != null
            ? List<int>.from(jsonDecode(map["kids"]))
            : null,
        score = map["score"],
        time = map["time"],
        title = map["title"],
        type = map["type"],
        url = map["url"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = by;
    data['descendants'] = descendants;
    data['id'] = id;
    data['kids'] = jsonEncode(kids);
    data['score'] = score;
    data['time'] = time;
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
