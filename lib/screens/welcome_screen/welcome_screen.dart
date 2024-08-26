import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/route_name.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List images = [
    "assets/images/welcome-one.png",
    "assets/images/welcome-two.png",
    "assets/images/welcome-three.png",
  ];
  List title = [
    "Learn New Langauges!",
    "Verify your meter",
    "Buy Mobile & Cable Recharge",
  ];
  List subTitle = [
    "In few simple steps learn at your convenience.",
    "We help you verify your meter address for utility bills.",
    "Pay for call credit, data and cable subscription in three steps.",
  ];
  List slideColor = [
    AppColors.slide1,
    AppColors.slide2,
    AppColors.slide3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.maxFinite,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          bottom: 50,
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            width: double.maxFinite,
                            height: 300,
                            decoration: BoxDecoration(
                                color: slideColor[index],
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(150.0),
                                  bottomLeft: Radius.circular(150.0),
                                )),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 50,
                          width: 300,
                          height: 300,
                          child: Container(
                            decoration: BoxDecoration(
                                // color: index % 2 == 0 ? Colors.green : Colors.blue[600],
                                image: DecorationImage(
                              image: AssetImage(
                                images[index],
                              ),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 100, left: 24, right: 24, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLargeText(
                              text: title[index],
                              size: 17,
                            ),
                            addVerticalSpace(20),
                            SizedBox(
                                width: 260,
                                child: AppText(
                                  text: subTitle[index],
                                  color: AppColors.textColorSecondary,
                                  size: 13,
                                  textAlign: TextAlign.center,
                                )),
                            addVerticalSpace(40),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (sliderIndex) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 2, right: 2),
                                    height: 3,
                                    width: index == sliderIndex ? 20 : 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: index == sliderIndex
                                            ? AppColors.primaryColor
                                            : AppColors.primaryTextColor
                                                .withOpacity(0.3)),
                                  );
                                })),
                          ],
                        ),
                        addVerticalSpace(100),
                        SizedBox(
                          height: 180,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IzsFlatButton(
                                width: double.infinity,
                                height: 52,
                                isResponsive: false,
                                color: AppColors.primaryColor,
                                text: 'Get Started',
                                textSize: 14,
                                textColor: Colors.white,
                                borderRadius: 12,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RouteName.welcomePage);
                                },
                                borderColor: AppColors.dividerColor,
                                borderWidth: 0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
