// import 'package:flutter/foundation.dart';
// import 'package:webappcarsales/services.dart';

// import 'error_handling.dart';

// class ManageCars {
//   final StoreServices _gdb = StoreServices();

//   Future<Map<String, dynamic>> getFutureCars() async {
//     try {
//       final doc = await _gdb.getFutureCars();

//       final res = ErrorHandler.docsDBErrorHandler(doc);

//       // print('$tag getFutureEvents() ::// events docs: ' + doc.docs.);
//       return res;
//     } catch (e) {
//       final err = ErrorHandler.docsDBErrorHandler(null, e: e);

//       if (kDebugMode) {
//         print(' getFutureCars() exception error ::// $err');
//       }

//       return err;
//     }
//   }
// }