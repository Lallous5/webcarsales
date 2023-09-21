import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webappcarsales/car_model.dart';

class CarDetails extends StatefulWidget {
  final CarModel data;
  CarDetails({super.key, required this.data});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // backgroundColor: Color.fromARGB(255, 12, 15, 21),
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text("${widget.data.nameCar}"),
      //     ],
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(160, 12, 15, 21),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              VxSwiper.builder(
                  autoPlay: true,
                  height: 450,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  itemCount: widget.data.images.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      "${widget.data.images[index]}",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    );
                  }),
              Text(
                "${widget.data.nameCar}",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              Text(
                "${"USD" + " " + widget.data.price.toString()}",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              Text(
                "${"Number:" + " " + widget.data.phoneNumber}",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              Divider(),
              Text(
                "${widget.data.desc}",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
