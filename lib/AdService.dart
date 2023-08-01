//広告表示を管理するクラス

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'dart:math' as math;

class AdService {
  static InterstitialAd? _interstitialAd;
  static TargetPlatform? os;

  //実機用の広告IDを入力する
  static const interstitial_release_id_for_ios = "ca-app-pub-3958141489226219/5879226335";
  static const interstitial_release_id_for_android = "ca-app-pub-3958141489226219/5735756107";
  static const banner_release_id_for_ios = "ca-app-pub-3958141489226219/6122715017";
  static const banner_release_id_for_android = "ca-app-pub-3958141489226219/9027302309";


  //テスト用の広告ID 変更することはほとんどない
  static const interstitial_test_id_for_ios = "ca-app-pub-3940256099942544/4411468910";
  static const interstitial_test_id_for_android  = "ca-app-pub-3940256099942544/1033173712";
  static const banner_test_id_for_ios = "ca-app-pub-3940256099942544/2934735716";
  static const banner_test_id_for_android  = "ca-app-pub-3940256099942544/6300978111";


  static void init(context) async {
    WidgetsFlutterBinding.ensureInitialized();
    await MobileAds.instance.initialize();
    os = Theme.of(context).platform;
  }

  static void loadInterstitial() {
    if(math.Random().nextBool()) return;

    const Map<String, String> UNIT_ID = kReleaseMode
        ? {
      'ios': interstitial_release_id_for_ios,
      'android': interstitial_release_id_for_android,
    }
        : {
      'ios': interstitial_test_id_for_ios,
      'android': interstitial_test_id_for_android,
    };

    InterstitialAd.load(
        adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
        request: const AdRequest(),
        adLoadCallback:
        InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          showInterstitialAd();
        }, onAdFailedToLoad: (LoadAdError error) {
          debugPrint(error.toString());
        }));
  }

  static Widget getAdd(context) {
    const Map<String, String> UNIT_ID = kReleaseMode
        ? {
      'ios': banner_release_id_for_ios,
      'android': banner_release_id_for_android,
    }
        : {
      'ios': banner_test_id_for_ios,
      'android': banner_test_id_for_android,
    };

    return FutureBuilder<Widget>(
      future: _buildBannerWidget(
          UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: Center(child: Text("Loading"))
          );
        }

        return snapshot.data!;
      },
    );
  }

  static Future<Widget> _buildBannerWidget(String adId) async {
    BannerAd banner = BannerAd(
      listener: _buildListener(),
      size: AdSize.banner,
      adUnitId: adId,
      request: AdRequest(),
    );
    banner.load();
    return Container(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),

    );
  }

  static AdManagerBannerAdListener _buildListener() {
    return AdManagerBannerAdListener(
      onAdOpened: (Ad ad) {
        log('BannerAdListener onAdOpened ${ad.toString()}.');
      },
      onAdClosed: (Ad ad) {
        log('BannerAdListener onAdClosed ${ad.toString()}.');
      },
      onAdImpression: (Ad ad) {
        log('BannerAdListener onAdImpression ${ad.toString()}.');
      },
      onAdWillDismissScreen: (Ad ad) {
        log('BannerAdListener onAdWillDismissScreen ${ad.toString()}.');
      },
      onPaidEvent: (
          Ad ad,
          double valueMicros,
          PrecisionType precision,
          String currencyCode,
          ) {
        log('BannerAdListener PaidEvent ${ad.toString()}.');
      },
      onAdLoaded: (Ad ad) {
        log('BannerAdListener onAdLoaded ${ad.toString()}.');
      },
      onAdFailedToLoad: (Ad bannerAd, LoadAdError error) {
        bannerAd.dispose();
        log('BannerAdListener onAdFailedToLoad error is ${error.responseInfo} | ${error.message} | ${error.code} | ${error.domain}');
      },
    );
  }

  static Future<void> showInterstitialAd() async {
    await _interstitialAd!.show();
    _interstitialAd = null;
    debugPrint("show Ad");
  }
}
