import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'car_model.dart';
import 'dropdown.dart';

class FilterWidget extends StatefulWidget {
  final Map<String, List<String>> brandAndModel;
  final List<Map<String, String>> sortBy;
  final Function applyOnTap;
  final Function resetOnTap;
  final FilterData? initialData;
  FilterWidget({
    Key? key,
    required this.applyOnTap,
    required this.resetOnTap,
    required this.sortBy,
    required this.brandAndModel,
    this.initialData,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => FilterWidgetState();
}

String selectedSort = "";
String selectedBrand = "";
String selectedModel = "";

FilterData filterResult() {
  var data = {
    'sortBy': selectedSort,
    'brand': selectedBrand,
    'model': selectedModel
  };
  print(data);
  return FilterData.fromJson(data);
}

class FilterWidgetState extends State<FilterWidget> {
  @override
  void initState() {
    if (widget.initialData != null) {
      selectedSort = widget.initialData!.sortBy;
      selectedBrand = widget.initialData!.brand;
      selectedModel = widget.initialData!.model;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, StateSetter setStates) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0x7CE7885F), Color(0xA0E51F5C)],
                          stops: [0, 1],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShaderMask(
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
                              Icons.close,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),
            Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Brand:',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FlutterFlowDropDown(
                    initialOption: selectedSort,
                    options: widget.brandAndModel.keys.map((e) => e).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedBrand = val;
                        selectedModel = "";
                      });
                    },
                    names: widget.brandAndModel.keys.map((e) => e).toList(),
                    textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
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
                          colors: <Color>[Color(0xB1E51F5C), Color(0xFFCB7149)],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_circle_rounded,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    borderRadius: 10,
                    margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    hidesUnderline: true,
                  ),
                ]),
            Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Model:',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FlutterFlowDropDown(
                    initialOption: selectedSort,
                    options: selectedBrand.isNotEmpty
                        ? widget.brandAndModel[selectedBrand]!
                            .map((e) => e)
                            .toList()
                        : [],
                    onChanged: (val) {
                      setState(() {
                        selectedModel = val;
                      });
                    },
                    names: selectedBrand.isNotEmpty
                        ? widget.brandAndModel[selectedBrand]!
                            .map((e) => e)
                            .toList()
                        : [],
                    textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
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
                          colors: <Color>[Color(0xB1E51F5C), Color(0xFFCB7149)],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_circle_rounded,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    borderRadius: 10,
                    margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    hidesUnderline: true,
                  ),
                ]),
            Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Sort:',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  FlutterFlowDropDown(
                    initialOption: selectedSort,
                    options: widget.sortBy.map((e) => e['id']!).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedSort = val;
                      });
                    },
                    names: widget.sortBy.map((e) => e['name']!).toList(),
                    textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
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
                          colors: <Color>[Color(0xB1E51F5C), Color(0xFFCB7149)],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_circle_rounded,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    borderRadius: 10,
                    margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    hidesUnderline: true,
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 10.0, left: 15, right: 15, top: 35),
              child: InkWell(
                onTap: () {
                  widget.applyOnTap(filterResult());
                },
                child: Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0x7CE7885F), Color(0xA0E51F5C)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(1, 0),
                      end: AlignmentDirectional(-1, 0),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Apply',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              fontSize: 22,
                            )),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 10.0, left: 15, right: 15, top: 5),
              child: InkWell(
                onTap: () {
                  widget.resetOnTap();
                },
                child: Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0x7CE7885F), Color(0xA0E51F5C)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(1, 0),
                      end: AlignmentDirectional(-1, 0),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Reset',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              fontSize: 22,
                            )),
                      ]),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
