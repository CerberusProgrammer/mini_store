import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_store/category/carousel_product.dart';
import 'package:mini_store/object/category.dart';
import 'package:mini_store/object/product.dart';

import '../data/select_icons.dart';

class ShowProduct extends StatefulWidget {
  final Category category;
  final Product product;

  const ShowProduct({
    super.key,
    required this.product,
    required this.category,
  });

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  bool mode = false;
  bool error = false;

  Widget viewMode() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                        fontSize: 32,
                        color: widget.category.color,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.category.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 15, bottom: 20),
            child: Text(
              widget.product.description.isEmpty
                  ? 'No description.'
                  : widget.product.description,
            ),
          ),
          Text(
            '\$${widget.product.price}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: widget.category.color,
            ),
          ),
          Row(
            children: [
              Text(
                '${widget.product.disponibility}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(' avaible.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget editMode(
    TextEditingController name,
    TextEditingController description,
    TextEditingController price,
    TextEditingController avaible,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      cursorColor: widget.category.color,
                      decoration: InputDecoration(
                        fillColor: widget.category.color,
                        focusColor: widget.category.color,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.category.color,
                          ),
                        ),
                      ),
                      controller: name,
                      style: TextStyle(
                        fontSize: 32,
                        color: widget.category.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.category.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 20),
            child: SizedBox(
              child: TextField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                controller: description,
                decoration: InputDecoration(
                  hintText: widget.product.description.isEmpty
                      ? 'No description'
                      : null,
                  labelStyle: TextStyle(
                    color: widget.category.color,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.category.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    try {
                      double x = double.parse(price.text);
                      if (x > 0) {
                        price.text = (x - .01).toStringAsFixed(2);
                      }
                    } finally {}
                  },
                  onLongPress: () {
                    try {
                      double x = double.parse(price.text);

                      if (x >= 0.1) {
                        price.text = (x - .1).toStringAsFixed(2);
                      }
                    } finally {}
                  },
                  child: Icon(
                    Icons.remove,
                    size: 30,
                    color: Colors.black.withAlpha(128),
                  ),
                ),
              ),
              IntrinsicWidth(
                child: TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  maxLines: 1,
                  controller: price,
                  decoration: InputDecoration(
                    prefix: const Text('\$'),
                    filled: true,
                    fillColor: widget.category.color.withAlpha(50),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    try {
                      double x = double.parse(price.text);
                      price.text = (x + .01).toStringAsFixed(2);
                    } finally {}
                  },
                  onLongPress: () {
                    try {
                      double x = double.parse(price.text);
                      price.text = (x + .10).toStringAsFixed(2);
                    } finally {}
                  },
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.black.withAlpha(128),
                  ),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 1)),
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    try {
                      int x = int.parse(avaible.text);
                      if (x > 0) {
                        avaible.text = '${x - 1}';
                      }
                    } finally {}
                  },
                  onLongPress: () {
                    try {
                      int x = int.parse(avaible.text);

                      if (x >= 10) {
                        avaible.text = '${x - 10}';
                      }
                    } finally {}
                  },
                  child: Icon(
                    Icons.remove,
                    size: 30,
                    color: Colors.black.withAlpha(128),
                  ),
                ),
              ),
              IntrinsicWidth(
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  maxLines: 1,
                  controller: avaible,
                  decoration: InputDecoration(
                    suffix: const Text(' avaible'),
                    filled: true,
                    fillColor: widget.category.color.withAlpha(20),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    try {
                      int x = int.parse(avaible.text);
                      avaible.text = '${x + 1}';
                    } finally {}
                  },
                  onLongPress: () {
                    try {
                      int x = int.parse(avaible.text);
                      avaible.text = '${x + 10}';
                    } finally {}
                  },
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.black.withAlpha(128),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardEditMode() {
    List<Widget> items = [
      Card(
        elevation: 1,
        color: widget.category.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.attach_file,
                size: 50,
                color: Color.fromARGB(180, 255, 255, 255),
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
                    widget.product.images.addAll(providers);
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
                    widget.product.images.add(imageProvider);
                  });
                }
              },
              icon: const Icon(
                Icons.camera_alt,
                size: 50,
                color: Color.fromARGB(180, 255, 255, 255),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.insert_emoticon_sharp,
                size: 50,
                color: Color.fromARGB(180, 255, 255, 255),
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
                                    widget.product.icon = selectIcons[index];
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
            ),
          ],
        ),
      ),
    ];

    if (widget.product.images.isNotEmpty) {
      for (ImageProvider image in widget.product.images) {
        items.add(
          SizedBox(
            width: 300,
            child: Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child:
                                Stack(alignment: Alignment.topRight, children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image(
                                    image: image,
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
                                      widget.product.images.remove(image);
                                    });
                                    Navigator.pop(context);
                                  },
                                  style: FilledButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor: widget.category.color),
                                  child: const Icon(Icons.delete),
                                ),
                              ),
                            ]),
                          );
                        });
                  },
                  child: Image(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50,
        top: 90,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            items: items,
            options: CarouselOptions(
              height: 300,
              initialPage: 0,
              enlargeCenterPage: true,
              reverse: false,
              enableInfiniteScroll: true,
              pauseAutoPlayOnTouch: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController avaible = TextEditingController();
    name.text = widget.product.name;
    description.text = widget.product.description;
    price.text = '${widget.product.price}';
    avaible.text = '${widget.product.disponibility}';

    return DraggableHome(
      headerExpandedHeight: .58,
      stretchMaxHeight: .8,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      appBarColor: widget.category.color,
      alwaysShowLeadingAndAction: true,
      alwaysShowTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              widget.category.products.remove(widget.product);

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ],
      title: const Center(),
      backgroundColor: Colors.white,
      headerWidget: Container(
        color: widget.category.color,
        child: mode
            ? cardEditMode()
            : CarouselProduct(
                category: widget.category,
                product: widget.product,
              ),
      ),
      body: [mode ? editMode(name, description, price, avaible) : viewMode()],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          double priceD = 0;
          try {
            priceD = double.parse(price.text);
            error = false;
          } catch (e) {
            setState(() {
              error = true;
            });
          }

          if (!error) {
            setState(() {
              widget.product.name = name.text;
              widget.product.description = description.text;
              widget.product.price = priceD;
              widget.product.disponibility = int.parse(avaible.text);
              mode = !mode;
            });
          }
        },
        backgroundColor: widget.category.color,
        foregroundColor: Colors.white,
        child: Icon(mode ? Icons.done : Icons.edit),
      ),
    );
  }
}
