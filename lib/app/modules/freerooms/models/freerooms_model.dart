class FreeroomsModel {
  final totalClasses;
  final totalLabs;
  final List<FreeroomsSubClass> classes;
  final List labs;

  FreeroomsModel(
      {required this.totalClasses,
      required this.classes,
      required this.totalLabs,
      required this.labs});
}

class FreeroomsSubClass {
  final totalClasses;
  final classes;

  FreeroomsSubClass({required this.totalClasses, required this.classes});
}
