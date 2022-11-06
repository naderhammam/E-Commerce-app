import 'package:flutter/material.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'package:shop_app/screens/login/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

var controllerBoard = PageController();
bool isLastPage = false;

class ModelingPage {
  late String title;
  late String description;
  late String image;
  ModelingPage(
      {required this.title, required this.description, required this.image});
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    List<ModelingPage> listPages = [
      ModelingPage(
        title: 'Discounts on More Than 50,000 Product',
        description: 'It is easy to find any product on our website',
        image: 'assets/images/onBoarding_5.jpg',
      ),
      ModelingPage(
        title: 'Online Shopping Grocery 50% Discount',
        description: 'We Have Many Discounts on All Products',
        image: 'assets/images/onBoarding_2.jpg',
      ),
      ModelingPage(
        title: 'Online Shopping Fast Delivery',
        description:
            'We Have Many Branches, so The Quality of Delivery is Very High',
        image: 'assets/images/OnBoarding_6.jpg',
      ),
    ];
    void submit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) {
          print(value);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backOn_2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    submit();
                  },
                  child: const Text(
                    'SKIP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.teal),
                  )),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return buildItemPage(listPages[index]);
                  },
                  itemCount: listPages.length,
                  physics: const BouncingScrollPhysics(),
                  controller: controllerBoard,
                  onPageChanged: (index) {
                    if (index == listPages.length - 1) {
                      setState(() {
                        isLastPage = true;
                      });
                    } else {
                      setState(() {
                        isLastPage = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controllerBoard,
                    count: listPages.length,
                    effect: const ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 12,
                      expansionFactor: 4,
                      spacing: 5,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.teal,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        if (isLastPage) {
                          submit();
                        } else {
                          controllerBoard.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: const Icon(Icons.arrow_forward)),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemPage(ModelingPage page) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage(page.image),
        )),
        Text(
          page.title,
          style: const TextStyle(
            fontSize: 28,
            height: 1.3,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          page.description,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
