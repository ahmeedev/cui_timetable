import 'package:cached_network_image/cached_network_image.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../../../widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CarouselImageDetails extends StatelessWidget {
  const CarouselImageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${Get.arguments[0]}')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'img',
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: Get.arguments[1],
                fit: BoxFit.cover,
                // height: MediaQuery.of(context).size.height * 0.3,
                placeholder: (context, string) {
                  return const SpinKitFadingCircle(
                    color: primaryColor,
                  );
                },
              ),
            ),
          ),
          kHeight,
          Padding(
            padding: EdgeInsets.all(Constants.defaultPadding),
            child: Text(
              Get.arguments[2],
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: primaryColor, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
