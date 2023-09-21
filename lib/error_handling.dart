// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorHandler {
  static const int error_bad_request = 1;
  static const int error_network_connection = 2;
  static const int error_json_parse = 3;
  static const int error_firebase_unauthenticated = 4;
  static const int error_server_internal = 5;
  static const int error_firebase_exception = 6;
  static const int error_fb_storage_upload = 7;
  static const int error_other = 9;

  static Map<String, dynamic> docsDBErrorHandler(doc,
      {e, bool userDoc = false, bool forceLogout = true}) {
    /* firebase exception errors */
    if (e != null && e is FirebaseException) {
      if (userDoc) {
        if (e.message ==
            'Failed to get document because the client is offline.') {
          return {
            'status': 1,
            'code': error_network_connection,
            'error': e.code,
            'message': e.message,
            'force_logout': forceLogout,
            'error_ui': 'Network error. Please check your internet connection',
          };
        } else {
          return {
            'status': 1,
            'code': error_firebase_unauthenticated,
            'error': e.code,
            'message': e.message,
            'force_logout': forceLogout,
            'error_ui': 'Please log-in again',
          };
        }
      }

      return {
        'status': 1,
        'code': error_firebase_exception,
        'error': e.code,
        'message': e.message,
        /* for now just write same error message on ui dialogs*/
        'error_ui': e.message
      };
    }
    /* other exception errors */
    else if (e != null) {
      if (userDoc) {
        return {
          'status': 1,
          'code': error_firebase_unauthenticated,
          'error': e.toString(),
          'message': e.message,
          'force_logout': true,
          'error_ui': 'Please log-in again',
        };
      }
      return {
        'status': 1,
        'code': error_other,
        'error': e.toString(),
        'message': e.message,
        'error_ui': 'Unexpected error occurred. Please try again later',
      };
    } else if (doc != null) {
      /* user doc not existing is authentication error */
      if (doc is DocumentSnapshot && userDoc && !doc.exists) {
        return {
          'status': 1,
          'code': error_firebase_unauthenticated,
          'error': 'user doc not found',
          'force_logout': forceLogout,
          'error_ui': 'Please log-in again',
          'response': doc
        };
      } else {
        return {'status': 0, 'data': doc};
      }
    } else {
      return {
        'status': 1,
        'code': error_other,
        'error_ui': 'Unexpected error occurred. Please try again later',
        'error': 'unexpected error'
      };
    }
  }

  static Map<String, dynamic> storageErrorsHandle(FirebaseException e) {
    return {
      'status': 1,
      'code': error_fb_storage_upload,
      'error': 'storage upload failed',
      'message': e.message,
      'error_ui': 'Upload failed',
    };
  }
}
