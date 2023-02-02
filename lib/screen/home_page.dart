import 'package:demoprovider/main.dart';
import 'package:demoprovider/model/user_data.dart';
import 'package:demoprovider/provider/userdata_provider.dart';
import 'package:demoprovider/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add, size: 35),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Form(
                      key: _fromKey,
                      child: AlertDialog(
                          title: const Text("Insert Data"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter your Name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  controller: _ageController,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(labelText: "age", border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your Age";
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_fromKey.currentState!.validate()) {
                                  await userDataBox
                                      .add(UserData(name: _nameController.text, age: int.parse(_ageController.text)));
                                  Provider.of<UserDataProvider>(context,listen: false).setUserBox = userDataBox;
                                  _nameController.text = "";
                                  _ageController.text = "";
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text("Save"),
                            )
                          ]),
                    );
                  });
            },
          )
        ],
      ),
      body: Consumer<UserDataProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.getUserBox.length,
            itemBuilder: (context, index) {
              UserData personData = value.getUserBox.getAt(index)!;
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) async {
                  await userDataBox.deleteAt(index);
                  Provider.of<UserDataProvider>(context,listen: false).setUserBox = userDataBox;
                },
                child: ListTile(
                  title: Text(personData.name.toString()),
                  subtitle: Text(personData.age.toString()),
                  onTap: () {
                    _nameController.text = personData.name!;
                    _ageController.text = personData.age.toString();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Form(
                            key: _fromKey,
                            child: AlertDialog(
                                title: const Text("Update Data"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                                      autofocus: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter your Name";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                        controller: _ageController,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(labelText: "age", border: OutlineInputBorder()),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter your Age";
                                          }
                                          return null;
                                        }),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _nameController.text = "";
                                      _ageController.text = "";
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Cancel",
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_fromKey.currentState!.validate()) {
                                        await userDataBox
                                            .putAt(index,UserData(name: _nameController.text, age: int.parse(_ageController.text)));
                                        Provider.of<UserDataProvider>(context,listen: false).setUserBox = userDataBox;
                                        _nameController.text = "";
                                        _ageController.text = "";
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text("Update"),
                                  )
                                ]),
                          );
                        });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
