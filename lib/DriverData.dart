/// Devin Oxman
/// Class to hold driver objects pulled from the database
/// This class builds a driver object which is used in the driver management card to display a driver
/// It is instanciated from the documents pulled from the firestore drivers collection
class DriverData {
  DriverData({required this.id,
    required this.name,
    required this.family,
    required this.email,
    required this.username,
    required this.password,
    required this.imageUrl,
    required this.availability});
  String id;
  String name;
  String family;
  String email;
  String username;
  String password;
  String imageUrl;
  bool availability;
}