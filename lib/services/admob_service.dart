import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class AdMobService {

  String getAdMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2334510780816542~6726672523';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2334510780816542~7385148076';
    }
    return null;
  }

  static String _getBannerAdId() {
    if (Platform.isIOS) {
//      return 'ca-app-pub-2334510780816542/6833456062';
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
//      return 'ca-app-pub-2334510780816542/2993163849';
      return "ca-app-pub-3940256099942544/6300978111";
    }
    return null;
  }

  String getInterstitialAdId() {
      if (Platform.isIOS) {
//      return '';
        return 'ca-app-pub-3940256099942544/4411468910';
      } else if (Platform.isAndroid) {
//      return '';
        return "ca-app-pub-3940256099942544/1033173712";
      }
      return null;
  }


  InterstitialAd getNewTripInterstitial() {
    return InterstitialAd(
      adUnitId: getInterstitialAdId(),
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }

  static BannerAd _homeBannerAd;

  static BannerAd _getHomePageBannerAd() {
    return BannerAd(
      adUnitId: _getBannerAdId(),
      size: AdSize.smartBanner
    );
  }

  static void showHomeBannerAd() {
    if ( _homeBannerAd == null ) _homeBannerAd = _getHomePageBannerAd();
    _homeBannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom, anchorOffset: kBottomNavigationBarHeight);
  }

  static void hideHomeBannerAd() async {
    await _homeBannerAd.dispose();
    _homeBannerAd = null;
  }


}