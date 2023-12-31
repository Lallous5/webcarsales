import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/car_model.dart';
import '../views/car_details.dart';

class CarWidget extends StatelessWidget {
  CarModel carModel;
  CarWidget({
    super.key,
    required this.carModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          elevation: 19,
          enableDrag: true,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          backgroundColor: const Color(0xFF161A25),
          context: context,
          builder: (context) => SizedBox(
            height: Get.height / 1.1,
            child: CarDetails(data: carModel),
          ),
        );

        // showBottomSheet(
        //     elevation: 19,
        //     enableDrag: true,
        //     shape: CircleBorder(eccentricity: 1),
        //     backgroundColor: const Color(0xFF161A25),
        //     context: context,
        //     builder: (context) => CarDetails(data: carModel));
      },
      child: Container(
        height: 250,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(
                        image: CachedNetworkImageProvider(carModel.images[0]),
                        fit: BoxFit.cover,
                      )
                      // Image.network(
                      //   carModel.images[0],
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                ),
                carModel.isCancelled
                    ? Positioned(
                        top: 20,
                        left: 20,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(-20 / 360),
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange,
                                    width: 5,
                                    strokeAlign: BorderSide.strokeAlignInside)),
                            child: const Center(
                                child: Text(
                              "Sold Out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                          ),
                        ))
                    : Container(),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 0, 8),
              child: Container(
                height: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          carModel.nameCar.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "\$${carModel.price}",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.cyclone_outlined,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                carModel.cylinderSize ?? "",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.generating_tokens,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                carModel.gearBox ?? "",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                carModel.year.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
  
    );
  }
}
