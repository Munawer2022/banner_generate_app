import 'dart:async';

import 'package:banner_generate/banner/banner_model.dart';
import 'package:banner_generate/banner/db_helper.dart';
import 'package:banner_generate/invoice/pdf.dart';

import 'package:banner_generate/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:screenshot/screenshot.dart';

class BannerDownloard extends StatefulWidget {
  const BannerDownloard({super.key});

  @override
  State<BannerDownloard> createState() => _BannerDownloardState();
}

class _BannerDownloardState extends State<BannerDownloard> {
  DBHelper? dbHelper;
  Future<List<BannerModel>>? banner;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    banner = dbHelper!.read();
  }

  // final controller = ScreenshotController();
  // GlobalKey ssKey = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        Screenshot(
            controller: screenshotController,
            child: buildStack(
              size,
            )),
        SizedBox(
          height: size.height * 0.04,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: button('Dowmloard...', () async {
              _captureAndSave();
              // final pdfFile =
              //     await Pdf.generateCreated();

              // await Pdf.openFile(pdfFile).then((value) {
              //   print('opendone');
              // }).onError((error, stackTrace) {
              //   print('error ${error}');
              // });
            }))
      ],
    )
            //  FutureBuilder(
            //     future: banner,
            //     builder: (context, AsyncSnapshot<List<BannerModel>> snapshot) {
            //       var size = MediaQuery.of(context).size;
            //       return snapshot.connectionState == ConnectionState.waiting
            //           ? Center(child: Text('loading...'))
            //           : ListView.builder(
            //               // shrinkWrap: true,
            //               // reverse: true,
            //               itemCount: snapshot.data?.length,
            //               itemBuilder: (context, index) {
            //                 return Column(
            //                   children: [
            //                     Screenshot(
            //                         controller: screenshotController,
            //                         child: buildStack(size, snapshot, index)),
            //                     SizedBox(
            //                       height: size.height * 0.04,
            //                     ),
            //                     Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             horizontal: 20),
            //                         child: button('Dowmloard...', () async {
            //                           _captureAndSave();
            //                           // final pdfFile =
            //                           //     await Pdf.generateCreated();

            //                           // await Pdf.openFile(pdfFile).then((value) {
            //                           //   print('opendone');
            //                           // }).onError((error, stackTrace) {
            //                           //   print('error ${error}');
            //                           // });
            //                         }))
            //                   ],
            //                 );
            //               });
            //     })
            ));
  }

  void _captureAndSave() async {
    screenshotController.capture().then((dynamic image) async {
      // Save the image to the gallery
      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(image));
      if (result['isSuccess']) {
        snackbar('Screenshot saved to gallery', context);
        print("Screenshot saved to gallery");
      } else {
        print("Failed to save screenshot: ${result['errorMessage']}");
      }
    }).catchError((onError) {
      print("Error capturing screenshot: $onError");
    });
  }

  Widget buildStack(size) => Stack(children: [
        Image.asset(
          'assets/images/6bannerbac.jpg',
          // 'assets/images/1bannerbac.png',
          height: 500,
          width: 500,
          // width: double.infinity,s
          // fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text(
                    '8',
                    style: TextStyle(
                        color: Color(0xffFFD53D),
                        fontSize: 50,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Days & Nights',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                '5th June THAILAND',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        Positioned(
          top: 210,
          left: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'PKR ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              Text(
                '44,000',
                style: TextStyle(
                    color: Color(0xff03646A),
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900),
              ),
              Text(
                ' Per\n Person',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 250,
          left: 30,
          child: Text(
            'INCLUSIONS',
            style: TextStyle(
                color: Color(0xff03646A),
                fontWeight: FontWeight.w900,
                fontSize: 20),
          ),
        ),
        Positioned(
          top: 200,
          right: 0,
          child: Column(
            children: [
              Transform.rotate(
                alignment: Alignment.bottomCenter,
                angle: 0.3,
                child: Container(
                  height: 100.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/2bannerbac.jpg',
                        ),
                      ),
                      border: Border.all(color: Colors.white, width: 3)),
                ),
              ),
              Transform.rotate(
                alignment: Alignment.bottomCenter,
                angle: -0.3,
                child: Container(
                  height: 100.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/2bannerbac.jpg',
                        ),
                      ),
                      border: Border.all(color: Colors.white, width: 3)),
                ),
              ),
              Transform.rotate(
                alignment: Alignment.bottomCenter,
                angle: 0.3,
                child: Container(
                  height: 100.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/2bannerbac.jpg',
                        ),
                      ),
                      border: Border.all(color: Colors.white, width: 3)),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 450,
          left: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '21491279479',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'helloworld@gmail.com',
                  style: TextStyle(
                      color: Color(0xffFFD53D), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),

        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 40),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           height: size.height * 0.03,
        //         ),
        //         CircleAvatar(
        //           backgroundImage: AssetImage('assets/images/1banneriamge.jpg'),
        //           radius: 120,
        //         ),
        //         Text(
        //           snapshot.data![index].name,
        //           style: TextStyle(
        //               color: Color(0xffB78A07),
        //               fontSize: 40,
        //               fontFamily: 'Maragsâ'),
        //         ),
        //         IntrinsicHeight(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Column(
        //                 children: [
        //                   Text(
        //                     'Package Include',
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                         color: Color(0xff401811),
        //                         fontSize: 18,
        //                         fontFamily: 'Maragsâ'),
        //                   ),
        //                   Text(
        //                     snapshot.data![index].package,

        //                     // 'Hotal & Transport\nBy Bus & Flight\nVisa & Insurance',
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                         fontSize: 12,
        //                         color: Color(0xff401811),
        //                         fontFamily: 'Roboto'),
        //                   ),
        //                 ],
        //               ),
        //               VerticalDivider(
        //                 color: Color(0xff401811),
        //                 thickness: 2,
        //               ),
        //               Column(
        //                 children: [
        //                   Text(
        //                     '${snapshot.data![index].dates}\n${snapshot.data![index].month}',
        //                     // 'Departure 18\nAuguest',
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                         color: Color(0xff401811),
        //                         fontSize: 24,
        //                         fontFamily: 'Maragsâ'),
        //                   ),
        //                   Text(
        //                     snapshot.data![index].price,
        //                     // 'PRE PERSON\n2,20,000',
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                         fontSize: 12,
        //                         color: Color(0xff401811),
        //                         fontFamily: 'Roboto'),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           height: size.height * 0.02,
        //         ),
        //         Text(
        //           'Makkah Hotal : Kiswa Tower',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontSize: 12,
        //               color: Color(0xff401811),
        //               fontFamily: 'Roboto'),
        //         ),
        //         Text(
        //           'Madina Hotal : Bir Al Eiman / Warda Al Safa',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontSize: 12,
        //               color: Color(0xff401811),
        //               fontFamily: 'Roboto'),
        //         ),
        //         SizedBox(
        //           height: size.height * 0.04,
        //         ),
        //         Text(
        //           snapshot.data![index].no,
        //           // '0321/0335-8285400',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontSize: 12,
        //               color: Color(0xff401811),
        //               fontFamily: 'Roboto'),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ]);
}