import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/profile/slide_show_model.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';

class BannerDetailScreen extends StatefulWidget {
  final Slides slide;
  const BannerDetailScreen(this.slide, {super.key});

  @override
  State<BannerDetailScreen> createState() => _BannerDetailScreenState();
}

class _BannerDetailScreenState extends State<BannerDetailScreen> {

  WebViewController webViewController = WebViewController();

  setLink(){
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.slide.link.toString()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightColor,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.lightColor,
        foregroundColor: AppColor.textColor,
        title: Text(
          widget.slide.title.toString(),
          style:
          fontMedium.copyWith(
              fontSize: 16.sp,
              color: AppColor.textColor),
        ),
      ),
      body: WebViewWidget(controller: webViewController)
    );
  }
}
