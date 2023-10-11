import 'package:flutter/material.dart';

class BuySellSwitch extends StatefulWidget {
  final Function(bool) onToggle;
  final bool isBuying;

  BuySellSwitch({required this.onToggle, required this.isBuying});

  @override
  _BuySellSwitchState createState() => _BuySellSwitchState();
}

class _BuySellSwitchState extends State<BuySellSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              widget.onToggle(true); // Set to Buy
            },
            child: Container(
              width: 100,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: widget.isBuying
                      ? Radius.circular(20)
                      : Radius.circular(0),
                  bottomRight: widget.isBuying
                      ? Radius.circular(20)
                      : Radius.circular(0),
                ),
                color: widget.isBuying ? Colors.deepOrange : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  'Buy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.isBuying ? Colors.black : Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.onToggle(false); // Set to Sell
            },
            child: Container(
              width: 100,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: widget.isBuying
                      ? Radius.circular(20)
                      : Radius.circular(0),
                  bottomLeft: widget.isBuying
                      ? Radius.circular(20)
                      : Radius.circular(0),
                ),
                color:
                    !widget.isBuying ? Colors.deepOrange : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  'Sell',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: !widget.isBuying ? Colors.black : Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
