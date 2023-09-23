import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webappcarsales/services.dart';

import 'car_model.dart';
import 'cars_make_models.dart';

class CarController extends GetxController {
  Rx<List<CarModel>?> carsFeatured = Rxn<List<CarModel>>();
  Rx<List<CarModel>?> carsRec = Rxn<List<CarModel>>();

  final StoreServices eventManager = StoreServices();
  final CarsBrandsModels carsBrandModels = CarsBrandsModels();

  TextEditingController searchFeautedController = TextEditingController();

  RxString carsSearchString = RxString("");

  late Rx<FilterData> carsFilterData =
      FilterData(brand: "", model: "", sortBy: sortList.first).obs;

  List<String> sortList = [
    "A to Z",
    "Z to A",
    "High Price",
    "Low Price",
    "New to Old",
    "Old to New",
  ];

  StreamSubscription? _subscriptionEventLists;

  @override
  void onInit() {
    super.onInit();
    carsFilterData.listen((e) {
      print('listener triggered');
      getFeaturedCars();
      getRecommendedCars();
    });
    getFeaturedCars();
    getRecommendedCars();
  }

  Future<void> getFeaturedCars() async {
    try {
      carsFeatured.value = null;

      var stream = eventManager.getFutureCars(true, carsFilterData.value);

      _subscriptionEventLists = stream.listen((event) async {
        carsFeatured.value = event;

        carsFeatured.refresh();
      });

      update();
    } catch (e) {
      if (kDebugMode) {
        print("setEventLists catch");
      }
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getRecommendedCars() async {
    try {
      carsRec.value = null;

      var stream = eventManager.getFutureCars(false, carsFilterData.value);

      _subscriptionEventLists = stream.listen((event) async {
        carsRec.value = event;

        carsRec.refresh();
      });

      update();
    } catch (e) {
      if (kDebugMode) {
        print("setEventLists catch");
      }
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void disposeEventListsStream() {
    carsFeatured.value = null;
    carsRec.value = null;
    _subscriptionEventLists?.cancel();
  }
}
