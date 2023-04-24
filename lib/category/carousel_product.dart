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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 50,
            top: 90,
          ),
          child: widget.product.images.isEmpty
              ? SizedBox(
                  height: 200,
                  width: constraints.maxWidth,
                  child: Card(
                    elevation: 10,
                    color: widget.category.color,
                    child: Icon(
                      widget.product.icon,
                      size: 100,
                      color: const Color.fromARGB(180, 255, 255, 255),
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      carouselController: controller,
                      items:
                          List.generate(widget.product.images.length, (index) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: Card(
                            elevation: 3,
                            color: widget.category.color,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image(
                                                      image: widget.product
                                                          .images[index],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8,
                                                  ),
                                                  child: FilledButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        widget.product.images
                                                            .removeAt(index);
                                                        currentPosition = 0;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    style: FilledButton.styleFrom(
                                                        shape:
                                                            const CircleBorder(),
                                                        backgroundColor: widget
                                                            .category.color),
                                                    child: const Icon(
                                                        Icons.delete),
                                                  ),
                                                ),
                                              ]),
                                        );
                                      });
                                },
                                child: Image(
                                  image: widget.product.images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                      dotsCount: widget.product.images.length,
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
