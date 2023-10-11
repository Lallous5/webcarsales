import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webappcarsales/components/switch.dart';

import '../components/car_card.dart';
import '../components/dropdown.dart';
import '../components/filter_sort.dart';
import '../controller/car_controller.dart';
import '../model/car_model.dart';
import '../model/cars_make_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isBuying = true;
  bool isFiltering = false;
  final Uri _url = Uri.parse('https://www.instagram.com/elie_kattour/');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Stream<List<CarModel>> searchCars() {
    var stream1 = FirebaseFirestore.instance
        .collection('cars')
        .where('isDeleted', isEqualTo: false)
        .where("searchArray",
            arrayContains: carController.carsSearchString.value)
        .snapshots();

    var result = stream1.map((event) {
      return event.docs.map((e) => CarModel.fromJson(e.data())).toList();
    });

    return result;
  }

  CarController carController = Get.put(CarController());

  static const colorizeTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.blueGrey,
    fontFamily: 'SF',
  );
  Widget _typeWriter() {
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 25.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText('contact us',
                    textStyle: colorizeTextStyle,
                    curve: Curves.easeInCirc,
                    speed: const Duration(milliseconds: 80)),
                TypewriterAnimatedText('Elie Farah / 71 622 616',
                    textStyle: colorizeTextStyle,
                    curve: Curves.fastOutSlowIn,
                    speed: const Duration(milliseconds: 150)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: Colors.grey[400],
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: const Color(0xFF161A25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "FarahMotors",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Fair Selling",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    700
                                                ? 66
                                                : 44,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Fair Buying",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    700
                                                ? 66
                                                : 44,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "I want to  ",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                      BuySellSwitch(
                                        isBuying: isBuying,
                                        onToggle: (value) {
                                          setState(() {
                                            isBuying = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  isBuying
                                      ? Container(
                                          width: 280,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "SCROLL DOWN TO SEE ALL CARS",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.deepOrange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: const Icon(
                                                      Icons.arrow_downward),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 280,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [_typeWriter()],
                                            ),
                                          ),
                                        )
                                ],
                              ),
                              MediaQuery.of(context).size.width > 700
                                  ? Image.network(
                                      "https://www.transparentpng.com/thumb/bmw/dNgjKK-bmw-left-front-photo-download-transparent.png",
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 13, 16, 22),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              // width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 22, 26, 37),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                controller:
                                    carController.searchFeautedController,
                                onChanged: (value) {
                                  carController.carsSearchString.value =
                                      value.toLowerCase();

                                  if (kDebugMode) {
                                    print(carController.carsSearchString);
                                  }
                                },
                                obscureText: false,
                                decoration: const InputDecoration(
                                  hintText: 'Search for car',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(138, 255, 255, 255),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          0, 15, 0, 0),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white70,
                                    size: 18,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 22, 26, 37),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isFiltering = !isFiltering;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.filter_alt,
                                          color: Colors.white,
                                          size: 22,
                                        ))
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                MediaQuery.of(context).size.width > 500
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isFiltering
                              ? FilterWidget(
                                  resetOnTap: () {
                                    carController.carsFilterData.value =
                                        FilterData(
                                            brand: "",
                                            model: "",
                                            sortBy:
                                                carController.sortList.first);

                                    Get.back();
                                  },
                                  applyOnTap: (FilterData filterData) async {
                                    carController.carsFilterData.value =
                                        filterData;

                                    Get.back();
                                  },
                                  sortBy: carController.sortList
                                      .map((e) => {'name': e, 'id': e})
                                      .toList(),
                                  initialData:
                                      carController.carsFilterData.value,
                                  brandAndModel:
                                      CarsBrandsModels.carsBrandsModels,
                                )
                              : Container(),
                          Expanded(
                              child: Center(
                                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              carController.carsSearchString.value.isEmpty
                                  ? Container()
                                  : const Padding(
                                      padding: EdgeInsets.all(18.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: Text(
                                          "Searching...",
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF161A25)),
                                        ),
                                      ),
                                    ),
                              carController.carsSearchString.value.isEmpty
                                  ? Container()
                                  : StreamBuilder<List<CarModel>>(
                                      stream: carController
                                              .carsSearchString.value.isEmpty
                                          ? null
                                          : searchCars(),
                                      builder: (context, snapshot) {
                                        if (snapshot.data == null ||
                                            snapshot.data!.isEmpty) {
                                          return const Center(
                                            child: Text('No Cars Found',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                          );
                                        }
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Row(
                                              children: List.generate(
                                                  snapshot.data!.length,
                                                  (index) {
                                                var model =
                                                    snapshot.data![index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: CarWidget(
                                                    carModel: model,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              carController.carsFeatured.value != null &&
                                      carController.carsFeatured.value!.isEmpty
                                  ? Container()
                                  : const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        "Trending",
                                        style: TextStyle(
                                            fontSize: 44,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF161A25)),
                                      ),
                                    ),
                              _cardsFeaturedList(),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "For Sale",
                                  style: TextStyle(
                                      fontSize: 44,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161A25)),
                                ),
                              ),
                              _cardsRecommendedList(),
                            ],
                          )))
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isFiltering
                              ? FilterWidget(
                                  resetOnTap: () {
                                    carController.carsFilterData.value =
                                        FilterData(
                                            brand: "",
                                            model: "",
                                            sortBy:
                                                carController.sortList.first);

                                    Get.back();
                                  },
                                  applyOnTap: (FilterData filterData) async {
                                    carController.carsFilterData.value =
                                        filterData;

                                    Get.back();
                                  },
                                  sortBy: carController.sortList
                                      .map((e) => {'name': e, 'id': e})
                                      .toList(),
                                  initialData:
                                      carController.carsFilterData.value,
                                  brandAndModel:
                                      CarsBrandsModels.carsBrandsModels,
                                )
                              : Container(),
                          Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              carController.carsSearchString.value.isEmpty
                                  ? Container()
                                  : const Padding(
                                      padding: EdgeInsets.all(18.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: Text(
                                          "Searching...",
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF161A25)),
                                        ),
                                      ),
                                    ),
                              carController.carsSearchString.value.isEmpty
                                  ? Container()
                                  : StreamBuilder<List<CarModel>>(
                                      stream: carController
                                              .carsSearchString.value.isEmpty
                                          ? null
                                          : searchCars(),
                                      builder: (context, snapshot) {
                                        if (snapshot.data == null ||
                                            snapshot.data!.isEmpty) {
                                          return const Center(
                                            child: Text('No Cars Found',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                          );
                                        }
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Row(
                                              children: List.generate(
                                                  snapshot.data!.length,
                                                  (index) {
                                                var model =
                                                    snapshot.data![index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: CarWidget(
                                                    carModel: model,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              carController.carsFeatured.value != null &&
                                      carController.carsFeatured.value!.isEmpty
                                  ? Container()
                                  : const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        "Trending",
                                        style: TextStyle(
                                            fontSize: 44,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF161A25)),
                                      ),
                                    ),
                              _cardsFeaturedList(),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "For Sale",
                                  style: TextStyle(
                                      fontSize: 44,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF161A25)),
                                ),
                              ),
                              _cardsRecommendedList(),
                            ],
                          ))
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width,
                  height: 130,
                  decoration: const BoxDecoration(
                      color: Color(0xFF161A25),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/footer.png",
                          width: 400,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                _launchUrl();
                              },
                              child: const Text(
                                "2023 \u00a9 Elie Kattour",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }

  Widget _cardsFeaturedList() {
    return Obx(() {
      if (carController.carsFeatured.value != null &&
          carController.carsFeatured.value!.isNotEmpty) {
        /* display orgs under current company */
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Wrap(
              spacing: 10,
              runSpacing: 0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.none,
              children: carController.carsFeatured.value!.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: CarWidget(
                    carModel: e,
                  ),
                );
              }).toList()),
        );
      } else if (carController.carsFeatured.value == null) {
        return const Center(
            child: SizedBox(
                width: 100,
                height: 100,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  strokeWidth: 10,
                )));
      } else {
        return Container();
      }
    });
  }

  Widget _cardsRecommendedList() {
    return Obx(() {
      if (carController.carsRec.value != null &&
          carController.carsRec.value!.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Wrap(
              spacing: 10,
              runSpacing: 0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.none,
              children: carController.carsRec.value!
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(6),
                        child: CarWidget(
                          carModel: e,
                        ),
                      ))
                  .toList()),
        );
      } else if (carController.carsRec.value == null) {
        return const Center(
            child: SizedBox(
                width: 100,
                height: 100,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  strokeWidth: 10,
                )));
      } else {
        return const Padding(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'No Recommended Car.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF161A25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
