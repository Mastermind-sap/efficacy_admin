part of '../user_controller.dart';

Future<UserModel?> loginImpl({
  required String email,
  required String password,
}) async {
  List<UserModel> user = await UserController.get(
    email: email,
    keepPassword: true,
    forceGet: true,
  ).first;
  if (user.isEmpty) {
    throw Exception("User exists with the provided email. Please Log in");
  } else if (user.first.password == null) {
    throw Exception(
      "There has been some issue in the backend related to your data. Please contact the developers",
    );
  } else {
    if (!Encryptor.isValid(user.first.password!, password)) {
      throw Exception("Invalid password");
    }
    UserController.currentUser = user.first;
    UserController.currentUser = await UserController._save();
    return UserController.currentUser;
  }
}
