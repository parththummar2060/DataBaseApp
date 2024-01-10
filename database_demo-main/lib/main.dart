
import 'dart:typed_data';

import 'package:database/helperclass/helperclass.dart';
import 'package:database/model/modelclass.dart';
import 'package:database/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    routes:{
     "/":(context) => const DataBaseApp(),
     "detail_page":(context) => const DetailPage(),
    }
  ));
}

class DataBaseApp extends StatefulWidget {
  const DataBaseApp({Key? key}) : super(key: key);

  @override
  State<DataBaseApp> createState() => _DataBaseAppState();
}

class _DataBaseAppState extends State<DataBaseApp> {
  late Future<List<Detail>> showData;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController cmpNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  String name = "";
  int age = 0;
  int salary = 0;
  String role = "";
  String cmpName = "";
  String city = "";

  @override
  void initState() {
    super.initState();
    showData = Helper.helper.showData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("DataBase"),
        actions: [
          IconButton(onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return  AlertDialog(
                    title: const Text("Delete"),
                  content: const Text("Are you sure you want to delete all data"),
                    actions: [
                    ElevatedButton(onPressed: (){
                       Helper.helper.deleteAllData();
                       setState(() {
                         showData = Helper.helper.showData();
                       });
                      Navigator.of(context).pop();
                    }, child: const Text("DELETE")),
                    OutlinedButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: const Text("CANCEL")),
                    ],
                  );
                }
            );
          }, icon: const Icon(Icons.delete_forever))
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Form(
                    key: globalKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter Name First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              name = val!;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Name"),
                              hintText: "Enter Name Here...",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter age First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              age = int.parse(val!);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Age"),
                              hintText: "Enter Age Here...",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: salaryController,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter Salary First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              salary = int.parse(val!);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Salary"),
                              hintText: "Enter Salary Here...",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: roleController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter Role First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              role = val!;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Role"),
                              hintText: "Enter Role Here...",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: cmpNameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter Company Name First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              cmpName = val!;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Company Name"),
                              hintText: "Enter Company Name Here...",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: cityController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter City First...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              city = val!;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("City"),
                              hintText: "Enter City Here...",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {

                          if(globalKey.currentState!.validate())
                            {
                              globalKey.currentState!.save();
                          Detail detail = Detail(
                              name: name,
                              age: age,
                              city: city,
                              role: role,
                              salary:salary,
                              cmpName: cmpName);

                          int j = await Helper.helper.insertRaw(data: detail);


                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Record Added successfully")));

                          setState(() {
                            showData = Helper.helper.showData();
                          });
                            }
                          nameController.clear();
                          ageController.clear();
                          salaryController.clear();
                          roleController.clear();
                          cmpNameController.clear();
                          cityController.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text("CREATE")),
                    OutlinedButton(
                        onPressed: () {
                          nameController.clear();
                          ageController.clear();
                          salaryController.clear();
                          roleController.clear();
                          cmpNameController.clear();
                          cityController.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text("CANCEL")),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                      hintText: "Search", border: OutlineInputBorder()),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder(
                  future: showData,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      List<Detail> myData = snapshot.data;
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                          itemCount: myData.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed("detail_page",arguments: myData[i]);
                              },
                              child: Card(
                                elevation: 3,
                                margin: const EdgeInsets.all(5),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:(myData[i].image != null)?MemoryImage(myData[i].image as Uint8List):null,
                                  ),
                                  title: Text(myData[i].name!),
                                  subtitle: Text(myData[i].cmpName!),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
