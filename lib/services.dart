import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webappcarsales/car_model.dart';

class StoreServices {
  CollectionReference<Map<String, dynamic>> carsPath =
      FirebaseFirestore.instance.collection('cars');

  Stream<List<CarModel>> getFutureCars(
      bool isFeatured, FilterData? filterData) {
    Query<Map<String, dynamic>> ref;
    ref = carsPath;
    ref = ref
        .where('isHidden', isEqualTo: false)
        .where('isDeleted', isEqualTo: false);
    if (filterData != null) {
      if (filterData.brand.isNotEmpty) {
        ref = ref.where('brand', isEqualTo: filterData.brand);
      }
      if (filterData.model.isNotEmpty) {
        ref = ref.where('model', isEqualTo: filterData.model);
      }

      switch (filterData.sortBy) {
        case "A to Z":
          ref = ref.orderBy('nameCar', descending: false);
          print("A to Z");
          break;
        case "Z to A":
          ref = ref.orderBy('nameCar', descending: true);
          print("Z to A");
          break;
        case "High Price":
          ref = ref.orderBy('price', descending: true);
          break;
        case "Low Price":
          ref = ref.orderBy('price', descending: false);
          break;
        case "New to Old":
          ref = ref.orderBy('createdAt', descending: true);
          break;
        case "Old to New":
          ref = ref.orderBy('createdAt', descending: false);
          break;

        default:
      }
    }
    return ref.where('isFeatured', isEqualTo: isFeatured).snapshots().map(
        (event) => event.docs.map((e) => CarModel.fromJson(e.data())).toList());
  }
}
