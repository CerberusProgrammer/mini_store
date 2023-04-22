import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mini_store/data/currency.dart';
import 'package:mini_store/object/category.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/object/product.dart';

class AddProduct extends StatefulWidget {
  final Category? category;

  const AddProduct({
    super.key,
    this.category,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController description = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController disponibility = TextEditingController();

  bool isCompleted = false;
  bool isOk = false;
  int category = -1;
  String currency = "USD";
  List<ImageProvider> images = [];

  @override
  Widget build(BuildContext context) {
    final List<PageViewModel> pages = [
      PageViewModel(
        decoration: const PageDecoration(
          bodyAlignment: Alignment.center,
        ),
        title: 'Describe your product',
        bodyWidget: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onSubmitted: (value) {
                  setState(() {
                    name.text = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                  ),
                ),
              ),
            ),
            widget.category == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          hint: const Text('Select a category'),
                          value: category >= 0 ? category : null,
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          onChanged: (value) {
                            setState(() {
                              category = value ?? 0;
                            });
                          },
                          items: List.generate(categories.length, (index) {
                            return DropdownMenuItem<int>(
                                value: index,
                                child: Text(categories[index].name));
                          }),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        title: Text(widget.category!.name),
                      ),
                    ),
                  ),
            SizedBox(
              width: 300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: price,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        prefix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(currency)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 40,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          value: currency,
                          onChanged: (value) {
                            setState(() {
                              currency = value ?? 'USD';
                            });
                          },
                          items: List.generate(currencies.length, (index) {
                            return DropdownMenuItem<String>(
                                value: currencies[index],
                                child: Text(currencies[index]));
                          }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: disponibility,
                  decoration: const InputDecoration(
                    labelText: 'Disponibility',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      PageViewModel(
        decoration: const PageDecoration(
          bodyAlignment: Alignment.center,
        ),
        title: 'Add a beautiful photo',
        bodyWidget: Column(
          children: [
            const Text('(Optional)'),
            const SizedBox(
              height: 50,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                icon: const Icon(
                  Icons.attach_file,
                  size: 50,
                ),
                onPressed: () async {
                  final FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );

                  if (result != null) {
                    final PlatformFile file = result.files.first;
                    final File imageFile = File(file.path!);
                    final ImageProvider image = FileImage(imageFile);
                    setState(() {
                      images.add(image);
                    });
                  }
                },
              ),
              IconButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.camera);

                  if (image != null) {
                    final File imageFile = File(image.path);
                    final ImageProvider imageProvider = FileImage(imageFile);

                    setState(() {
                      images.add(imageProvider);
                    });
                  }
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 50,
                ),
              )
            ]),
          ],
        ),
        footer: images.isEmpty
            ? null
            : CarouselSlider(
                items: List.generate(5, (index) {
                  return const SizedBox(
                    width: 300,
                    child: Card(
                      color: Colors.blue,
                      child: Icon(
                        Icons.abc,
                        size: 100,
                        color: Color.fromARGB(180, 255, 255, 255),
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
                ),
              ),
      ),
    ];

    /*
    SizedBox(
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Card(
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return Dialog(
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Image(
                                            image: images[0],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: FilledButton(
                                          onPressed: () {
                                            setState(() {
                                              images.removeLast();
                                            });
                                            Navigator.pop(context);
                                          },
                                          style: FilledButton.styleFrom(
                                              shape: const CircleBorder()),
                                          child: const Icon(Icons.delete),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Image(
                          image: images[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
     */

    return IntroductionScreen(
      pages: pages,
      showNextButton:
          (name.text.isNotEmpty && (category >= 0 || widget.category != null)),
      showDoneButton:
          (name.text.isNotEmpty && (category >= 0 || widget.category != null)),
      showSkipButton: true,
      skip: const Text('Cancel'),
      back: const Icon(Icons.arrow_back),
      done: (name.text.isNotEmpty && (category >= 0 || widget.category != null))
          ? const Text('Done')
          : null,
      next: (name.text.isNotEmpty && (category >= 0 || widget.category != null))
          ? const Icon(
              Icons.arrow_forward,
            )
          : null,
      onDone: () {
        if (widget.category == null) {
          categories[category].products.add(
                Product(
                  id: widget.category!.products.length,
                  name: name.text,
                ),
              );
        } else {
          widget.category?.products.add(
            Product(
              id: widget.category!.products.length,
              name: name.text,
            ),
          );
        }

        Navigator.pop(context);
      },
      onSkip: () {
        name.clear();
        description.clear();
        price.clear();
        disponibility.clear();
        Navigator.pop(context);
      },
    );
  }
}
