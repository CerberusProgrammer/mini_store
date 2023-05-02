import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/themes.dart';

class Profile extends StatelessWidget {
  final bool mode;
  const Profile({
    super.key,
    required this.mode,
  });

  Widget viewMode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 120,
          child: Card(
            elevation: 5,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Padding(
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Omar',
                    style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(210)),
                  ),
                ),
              ),
            ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Username'),
                subtitle: const Text('Change your username.'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.image),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Profile picture'),
                subtitle: const Text('Let\'ts get stylish.'),
                onTap: () {},
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            'Style',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Theme'),
                subtitle: const Text('Set up a new theme for the app.'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return AlertDialog(
                          title: const Text('Change theme'),
                          content: SizedBox(
                            width: 300,
                            height: 300,
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 4,
                              children:
                                  List.generate(Themes.colors.length, (index) {
                                return OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Themes.colors[index],
                                    side: const BorderSide(
                                        color: Color.fromARGB(70, 35, 35, 35),
                                        width: 8),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    AdaptiveTheme.of(context).setTheme(
                                      light: Themes.changeTheme(index),
                                    );
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setInt('defaultIndex', index);
                                  },
                                  child: null,
                                );
                              }),
                            ),
                          ),
                        );
                      });
                },
              ),
              ListTile(
                leading: const Icon(Icons.restore),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Default'),
                subtitle: const Text('Restore to the main theme.'),
                onTap: () async {
                  AdaptiveTheme.of(context).setTheme(
                    light: Themes.changeTheme(0),
                    dark: Themes.changeTheme(0),
                  );
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setInt('defaultIndex', 0);
                },
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            'Data',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.data_object),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Products'),
                subtitle: const Text('Set up a new theme for the app.'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.category),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Categories'),
                subtitle: const Text('Restore to the main theme.'),
                onTap: () {},
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget editMode(BuildContext context) {
    return const Center();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: mode ? editMode(context) : viewMode(context),
        ),
      ),
    );
  }
}
