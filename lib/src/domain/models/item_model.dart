class ItemModel {
  const ItemModel(
      {this.id,
      this.type,
      this.by,
      this.time,
      this.text,
      this.dead,
      this.deleted,
      this.parent,
      this.kids,
      this.url,
      this.score,
      this.title,
      this.descendants});

  final int id;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final bool deleted;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;
}
