import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webappcarsales/manage_cars.dart';
import 'package:webappcarsales/services.dart';

import 'car_model.dart';

class CarController extends GetxController {
  Rx<List<CarModel>?> carsFeatured = Rxn<List<CarModel>>();
  Rx<List<CarModel>?> carsRec = Rxn<List<CarModel>>();

  final StoreServices eventManager = StoreServices();

  TextEditingController searchFeautedController = TextEditingController();

  RxString carsSearchString = RxString("");
  StreamSubscription? _subscriptionEventLists;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFeaturedCars();
    getRecommendedCars();
  }

  Future<void> getFeaturedCars() async {
    try {
      carsFeatured.value = null;

      var stream = eventManager.getFutureCars(true);

      _subscriptionEventLists = stream.listen((event) async {
        carsFeatured.value = event;

        carsFeatured.refresh();
      });

      update();
    } catch (e) {
      print("setEventLists catch");
      print(e);
    }
  }

  Future<void> getRecommendedCars() async {
    try {
      carsRec.value = null;

      var stream = eventManager.getFutureCars(false);

      _subscriptionEventLists = stream.listen((event) async {
        carsRec.value = event;

        carsRec.refresh();
      });

      update();
    } catch (e) {
      print("setEventLists catch");
      print(e);
    }
  }

  void disposeEventListsStream() {
    carsFeatured.value = null;
    carsRec.value = null;
    _subscriptionEventLists?.cancel();
  }
}
