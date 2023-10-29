part of '../club_controller.dart';

Stream<String?> _getNameImpl(String id) async* {
  Map? res =
      await LocalDatabase.get(LocalCollections.club, LocalDocuments.clubs);
  if (res != null) {
    res = Formatter.convertMapToMapStringDynamic(res)!;
    if (res.containsKey(id)) {
      yield res[id][ClubFields.name.name] as String?;
    }
  }
  DbCollection collection =
      Database.instance.collection(ClubController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq("_id", ObjectId.parse(id));
  selectorBuilder.fields([
    ClubFields.name.name,
    ClubFields.instituteName.name,
  ]);

  res = await collection.findOne(selectorBuilder);
  if (res != null) {
    ClubModel minified = await ClubController._save(ClubModel.minifiedFromJson(
      Formatter.convertMapToMapStringDynamic(res)!,
    ));
    yield minified.name;
  }
  yield null;
}
