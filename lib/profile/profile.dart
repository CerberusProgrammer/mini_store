import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final bool mode;
  const Profile({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                width: constraints.maxWidth,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Row(children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
