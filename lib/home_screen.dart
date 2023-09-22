import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:webappcarsales/car_card.dart';
import 'package:webappcarsales/car_model.dart';

import 'car_controller.dart';
import 'dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    fontSize: 23.0,
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
                TypewriterAnimatedText('This Company for car Sales',
                    textStyle: colorizeTextStyle,
                    curve: Curves.decelerate,
                    speed: const Duration(milliseconds: 80)),
                TypewriterAnimatedText(
                    'contact us If you want to sell your car,',
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
    return Scaffold(
      backgroundColor: const Color(0xFF161A25),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _typeWriter(),
              Image.asset(
                "assets/header.jpg",
                fit: BoxFit.cover,
                height: 390,
                width: MediaQuery.of(context).size.width,
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
                              controller: carController.searchFeautedController,
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
                                    EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
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
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 22, 26, 37),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FlutterFlowDropDown(
                              initialOption: carController.selectedSort.value,
                              options: carController.sortList,
                              onChanged: (val) {
                                setState(() {
                                  print(val);
                                  carController.selectedSort.value = val;
                                });
                              },
                              names: carController.sortList,
                              textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white70),
                              elevation: 0,
                              fillColor: const Color.fromARGB(255, 19, 23, 32),
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                              icon: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return const RadialGradient(
                                    center: Alignment.topLeft,
                                    radius: 0.5,
                                    colors: <Color>[
                                      Color(0xB1E51F5C),
                                      Color(0xFFCB7149)
                                    ],
                                    tileMode: TileMode.mirror,
                                  ).createShader(bounds);
                                },
                                child: const Icon(
                                  Icons.arrow_drop_down_circle_rounded,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              borderRadius: 10,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 12, 0),
                              hidesUnderline: true,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              carController.carsSearchString.value.isEmpty
                  ? Container()
                  : const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Text(
                          "Searching...",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
              carController.carsSearchString.value.isEmpty
                  ? Container()
                  : StreamBuilder<List<CarModel>>(
                      stream: carController.carsSearchString.value.isEmpty
                          ? null
                          : searchCars(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
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
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children:
                                  List.generate(snapshot.data!.length, (index) {
                                var model = snapshot.data![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
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
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Text(
                        "Trending",
                        style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
              _cardsFeaturedList(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                child: InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Text(
                    "For Sale",
                    style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              _cardsRecommendedList(),
              const SizedBox(
                height: 200,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "2023 \u00a9 Elie Kattour",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
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
                          color: Color(0xFFCECDCD),
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
