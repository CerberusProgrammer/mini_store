import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mini_store/data/currency.dart';
import 'package:mini_store/object/category.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/object/product.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'data/select_icons.dart';

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
  IconData icon = Icons.shopping_bag;
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
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 260,
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
                ),
                IconButton(
                  onPressed: () async {
                    String? codeSanner = await scanner.scan();
                    print(codeSanner);
                  },
                  icon: const Icon(Icons.barcode_reader),
                )
              ],
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
                              child: Text(categories[index].name),
                            );
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
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(type: FileType.image, allowMultiple: true);
                  if (result != null) {
                    final List<PlatformFile> file = result.files;
                    final List<ImageProvider> providers = [];

                    for (PlatformFile f in file) {
                      final File imageFile = File(f.path!);
                      final ImageProvider image = FileImage(imageFile);
                      providers.add(image);
                    }

                    setState(() {
                      images.addAll(providers);
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
              ),
              IconButton(
                icon: const Icon(Icons.insert_emoticon_sharp, size: 50),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return Dialog(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount:
                                      ((constraints.maxWidth ~/ 100) * 1.5)
                                          .toInt(),
                                  children: List.generate(selectIcons.length,
                                      (index) {
                                    return OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          icon = selectIcons[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  60, 35, 35, 35),
                                              width: 4)),
                                      child: Icon(
                                        selectIcons[index],
                                        color: Colors.black,
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        );
                      });
                },
              )
            ]),
          ],
        ),
        footer: images.isEmpty
            ? null
            : images.length == 1
                ? SizedBox(
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image(
                                                image:
                                                    images[images.length - 1],
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
                              image: images[images.length - 1],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      children: List.generate(images.length, (index) {
                        return Card(
                          elevation: 5,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Image(
                                                  image: images[index],
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
                                                    shape:
                                                        const CircleBorder()),
                                                child: const Icon(Icons.delete),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Image(
                                image: images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
      ),
    ];

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
          Product product = Product(
            id: categories[category].products.length,
            description: description.text,
            name: name.text,
            price: price.text.isEmpty
                ? 0
                : double.parse(price.text.replaceAll(',', '')),
            disponibility:
                disponibility.text.isEmpty ? 0 : int.parse(disponibility.text),
            icon: icon,
          );

          product.images = images;

          categories[category].products.add(product);
        } else {
          Product product = Product(
            id: widget.category!.products.length,
            description: description.text,
            name: name.text,
            price: price.text.isEmpty
                ? 0
                : double.parse(price.text.replaceAll(',', '')),
            disponibility:
                disponibility.text.isEmpty ? 0 : int.parse(disponibility.text),
            icon: icon,
          );
          product.images = images;
          widget.category?.products.add(product);
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
