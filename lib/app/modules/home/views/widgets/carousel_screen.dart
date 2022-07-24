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
            tag: "hero",
            child: InteractiveViewer(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: FittedBox(
                  fit: BoxFit.fill,
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
            ),
          ),
          Get.arguments[2] == ""
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight,
                      Text(
                        Get.arguments[2],
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: primaryColor, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
            child: Column(
              children: [
                kHeight,
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Constants.defaultRadius),
                      ),
                      gradient: const LinearGradient(
                        end: Alignment.bottomRight,
                        colors: [
                          // secondaryColor,
                          primaryColor,
                          forGradient,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: Text(
                        'No more details availble',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
