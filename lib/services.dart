import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webappcarsales/car_model.dart';

class StoreServices {
  CollectionReference<Map<String, dynamic>> carsPath =
      FirebaseFirestore.instance.collection('cars');

  Stream<List<CarModel>> getFutureCars(bool isFeatured) {
    Query<Map<String, dynamic>> ref;
    ref = carsPath;
    ref = ref
        .where('isHidden', isEqualTo: false)
        .where('isDeleted', isEqualTo: false);
    return ref.where('isFeatured', isEqualTo: isFeatured).snapshots().map(
        (event) => event.docs.map((e) => CarModel.fromJson(e.data())).toList());
  }
}
