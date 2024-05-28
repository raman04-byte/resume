import 'package:appwrite/appwrite.dart';
import '../../env.dart';
import '../models/user.dart';

// import '../models/user.dart';

class AuthenticationRepository {
  final database = Databases(client);
  AppwritePoints points = AppwritePoints();
  Future authenticate(String name, String companyName) async {
    await database.createDocument(
        databaseId: points.information,
        collectionId: points.companyInfo,
        documentId: ID.unique(),
        data: {
          'name': name,
          'companyName': companyName,
        });
    return User(name: name, companyName: companyName);
  }
}
