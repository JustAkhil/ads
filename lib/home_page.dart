import 'package:ads/ads_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd? bannerAd;
  @override
  void initState() {
    super.initState();
    initMobileAds();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad){
          bannerAd=ad as BannerAd;
          setState(() {

          });
        },
        onAdFailedToLoad: (ad,error){
          ad.dispose();

        }
      ),
      request: AdRequest(
      ),
      size: AdSize.banner
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            bannerAd!=null?Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: bannerAd!.size.width.toDouble(),
                height: bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: bannerAd!),
              ),
            ):Container()
          ],
        ),
      ),
    );
  }
  Future<void> initMobileAds() async {
    await MobileAds.instance.initialize();
  }
}