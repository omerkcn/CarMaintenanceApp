import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/screens/battery_page.dart';
import 'package:car_services_app/screens/motor_page.dart';
import 'package:car_services_app/screens/oil_change_components/oil_change_page.dart';
import 'package:car_services_app/screens/tire_change_componenets/tire_page.dart';
import 'package:car_services_app/screens/tow_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../profile_page_view_model.dart';
import '../washing_page.dart';
import 'constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Operations extends StatefulWidget {
  const Operations({Key? key}) : super(key: key);

  @override
  State<Operations> createState() => _OperationsState();
}

class _OperationsState extends State<Operations> {
  ProfileInfo? profileInfo;

  final Shader _linearGradient = const LinearGradient(
          colors: [Colors.brown, Colors.pink],
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight)
      .createShader(const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0));
  int activeIndex = 0;
  final discountImages = [
    'assets/oilDiscount.png',
    'assets/tireDiscount.png',
    'assets/engineDiscount.png'
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: ProfilePageViewModel().getProfileInfoFromApi(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            profileInfo = ProfileInfo.fromMap(data);
            return mainPageComponents(context, profileInfo!);
          }

          if (profileInfo != null) {
            return mainPageComponents(context, profileInfo!);
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  SingleChildScrollView mainPageComponents(
      BuildContext context, ProfileInfo profileInfo) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Select Text
          Column(
            children: [
              Text(
                'How can we help you?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = _linearGradient,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Container(
              //   width: double.infinity,
              //   height: MediaQuery.of(context).size.height * 0.057,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(25),
              //     color: Colors.white,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Row(
              //         children: const <Widget>[
              //           SizedBox(
              //             width: 15,
              //           ),
              //           Text(
              //             'Search',
              //             style: TextStyle(color: Colors.black, fontSize: 15),
              //           ),
              //         ],
              //       ),
              //       Container(
              //         height: MediaQuery.of(context).size.height * 0.057,
              //         width: (MediaQuery.of(context).size.width - 120) / 5,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: Colors.black,
              //         ),
              //         child: Center(
              //           child: IconButton(
              //             icon: const Icon(Icons.search),
              //             iconSize: 30.0,
              //             color: Colors.white,
              //             onPressed: () {},
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          /// ???
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.257,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                  viewportFraction: 1),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final discountImage = discountImages[index];
                return buildImage(discountImage, index);
              },
              itemCount: discountImages.length,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildIndicator(),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            height: 3,
            thickness: 2,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.207,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(side: buttonBorder),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TireChange(profileInfo: profileInfo)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/tireChange.JPG',
                            height: MediaQuery.of(context).size.height * 0.107,
                          ),
                          Center(
                            child: Text(
                              'TIRE CHANGE',
                              style: kHomeHeader,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(side: buttonBorder),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OilChanging(
                                      profileInfo: profileInfo,
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/oilChange.JPG',
                            height: MediaQuery.of(context).size.height * 0.107,
                          ),
                          Text(
                            'OIL CHANGE',
                            style: kHomeHeader,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.207,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(side: buttonBorder),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BatteryPage(
                                      profileInfo: profileInfo,
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/batteryChange.JPG',
                            height: MediaQuery.of(context).size.height * 0.107,
                          ),
                          Text(
                            'BATTERY CHANGE',
                            textAlign: TextAlign.center,
                            style: kHomeHeader,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(side: buttonBorder),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Washing(
                                      profileInfo: profileInfo,
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/carWashing.JPG',
                            height: MediaQuery.of(context).size.height * 0.107,
                          ),
                          Text(
                            'CAR WASHING',
                            style: kHomeHeader,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.207,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(side: buttonBorder),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Towpage(
                                      profileInfo: profileInfo,
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/tow.JPG',
                            height: MediaQuery.of(context).size.height * 0.107,
                          ),
                          Text(
                            'TOW AWAY A CAR',
                            textAlign: TextAlign.center,
                            style: kHomeHeader,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(side: buttonBorder),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MotorPage(
                                      profileInfo: profileInfo,
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/engine.JPG',
                            height: MediaQuery.of(context).size.height * 0.107,
                          ),
                          Text(
                            'ENGINE PROBLEMS',
                            textAlign: TextAlign.center,
                            style: kHomeHeader,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage(String urlImages, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        width: double.infinity,
        child: Image.asset(
          urlImages,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: discountImages.length,
        effect: const WormEffect(
          dotColor: Colors.white,
          activeDotColor: Colors.black,
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}
