import 'dart:io';

import 'package:currency_picker/currency_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mini_store/object/category.dart';
import 'package:mini_store/data/categories.dart';
import 'package:mini_store/object/product.dart';
import 'package:permission_handler/permission_handler.dart';
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

  int category = -1;
  String currency = "\$";
  IconData icon = Icons.shopping_bag;
  List<ImageProvider> images = [];
  String barCode = "";
  String currencyCode = "USD";

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
            barCode.isEmpty
                ? const Center()
                : Center(
                    child: Chip(
                      avatar: const FaIcon(FontAwesomeIcons.barcode),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(barCode),
                    ),
                  ),
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
                    if (await Permission.camera.request().isGranted) {
                      String? codeSanner = await scanner.scan();

                      setState(() {
                        barCode = codeSanner ?? "";
                      });
                    }
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
                      width: 60,
                      height: 40,
                      child: IconButton(
                        onPressed: () {
                          showCurrencyPicker(
                            context: context,
                            onSelect: (Currency value) {
                              setState(() {
                                currency = value.symbol;
                                currencyCode = value.code;
                              });
                            },
                          );
                        },
                        icon: Text(
                          currencyCode,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
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
                icon: const Icon(
                  Icons.insert_emoticon_sharp,
                  size: 50,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return AlertDialog(
                          title: const Text('Pick an Icon'),
                          content: SizedBox(
                            width: 300,
                            height: 400,
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 5,
                              children:
                                  List.generate(selectIcons.length, (index) {
                                return IconButton(
                                  onPressed: () {
                                    setState(() {
                                      icon = selectIcons[index];
                                    });
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    selectIcons[index],
                                    color: Colors.black,
                                  ),
                                );
                              }),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
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
            color: widget.category!.color,
            category: categories[category],
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
            color: widget.category!.color,
            category: widget.category!,
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
