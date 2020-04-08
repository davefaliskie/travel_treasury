import 'dart:io';

class AdMobService {

  String getAdMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2334510780816542~6726672523';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2334510780816542~7385148076';
    }
    return null;
  }

  String getBannerAdId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2334510780816542/6833456062';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2334510780816542/2993163849';
    }
    return null;
  }

}