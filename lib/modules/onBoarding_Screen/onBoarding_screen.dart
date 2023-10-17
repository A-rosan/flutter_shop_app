


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';
import '../login_screen/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController=PageController();
  bool isLast=false;
  List<BoardingModel> boardingList=[
    BoardingModel(
      image: "assets/images/onBorder.jpg",
      title: "Screen title 1",
      body: "body title 1",
      ),
    BoardingModel(
      image: "assets/images/onBorder.jpg",
      title: "Screen title 2",
      body: "body title 2",
      ),
    BoardingModel(
      image: "assets/images/onBorder.jpg",
      title: "Screen title 3",
      body: "body title 3",
      ),
  ];
  void submit(){
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        moveToAndFinish(context, LoginScreen());
      }
    }).catchError((error){
      print(error.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: [
          //skip button
          TextButton(
            onPressed: (){
              submit();
            },
            child: Text(
              "SKIP",
              style: GoogleFonts.abel(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 7, 24, 82),
              ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boardingList.length-1){
                    setState(() {
                      isLast=!isLast;
                      
                    });
                  }
                  else{
                    isLast=false;
                    
                  }
                },
                controller: boardingController,
                itemBuilder: (context,index)=>onBoardingBuilder(boardingList[index]),
                itemCount: boardingList.length,
                ),
            ),
           const SizedBox(height: 30,),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boardingList.length,
                    effect:const ExpandingDotsEffect(
                      activeDotColor: Color.fromARGB(255, 7, 24, 82),
                      dotColor: Colors.grey,
                      expansionFactor: 4,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        submit();
                      }
                      boardingController.nextPage(
                        duration:const Duration(milliseconds: 700),
                        curve: Curves.fastEaseInToSlowEaseOut,
                        );
                    },
                    child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                ],
              ),

          ],
        ),
      )
    );
  }
}
Widget onBoardingBuilder(BoardingModel model)=>Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:  Image(image: AssetImage(model.image))),
         const SizedBox(height: 30,),
          Text(
            model.title,
            style: GoogleFonts.abel(
              fontSize: 24,
              fontWeight: FontWeight.bold
              ),
          ),
         const SizedBox(height: 15,),
          Text(
            model.body,
            style: GoogleFonts.abel(
              fontSize: 20,
              fontWeight: FontWeight.bold
              ),
          )
        ],
      );
class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  }
  );
}