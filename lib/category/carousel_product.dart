import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../object/category.dart';
import '../object/product.dart';

class CarouselProduct extends StatefulWidget {
  final Category category;
  final Product product;

  const CarouselProduct({
    super.key,
    required this.category,
    required this.product,
  });

  @override
  State<CarouselProduct> createState() => _CarouselProductState();
}

class _CarouselProductState extends State<CarouselProduct> {
  int currentPosition = 0;
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    List<Widget> images = List.generate(5, (index) {
      return SizedBox(
        width: 300,
        child: Card(
          color: widget.category.color,
          child: Icon(
            widget.category.icon,
            size: 100,
            color: const Color.fromARGB(180, 255, 255, 255),
          ),
        ),
      );
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                carouselController: controller,
                items: List.generate(5, (index) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: Card(
                      color: widget.category.color,
                      child: Icon(
                        widget.category.icon,
                        size: 100,
                        color: const Color.fromARGB(180, 255, 255, 255),
                      ),
                    ),
                  );
                }),
                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  reverse: false,
                  enableInfiniteScroll: true,
                  pauseAutoPlayOnTouch: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPosition = index;
                    });
                  },
                ),
              ),
              DotsIndicator(
                dotsCount: images.length,
                position: currentPosition.toDouble(),
                decorator: const DotsDecorator(
                  activeColor: Colors.white,
                  color: Color.fromARGB(100, 255, 255, 255),
                ),
                onTap: (index) {
                  setState(() {
                    controller.animateToPage(index.toInt());
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
