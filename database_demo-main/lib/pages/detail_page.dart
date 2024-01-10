import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';

import '../helperclass/helperclass.dart';
import '../model/modelclass.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

Random r = Random();

class _DetailPageState extends State<DetailPage> {
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
    dynamic arg = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              nameController.text = arg.name;
              ageController.text = arg.age.toString();
              salaryController.text = arg.salary.toString();
              cmpNameController.text = arg.cmpName;
              roleController.text = arg.role;
              cityController.text = arg.city;

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
                              if (globalKey.currentState!.validate()) {
                                globalKey.currentState!.save();
                                Detail detail = Detail(
                                    name: name,
                                    age: age,
                                    city: city,
                                    role: role,
                                    salary: salary,
                                    cmpName: cmpName);

                                await Helper.helper.updateData(data: detail);
                                arg.name = name;
                                arg.age = age;
                                arg.city = city;
                                arg.role = role;
                                arg.salary = salary;
                                arg.cmpName = cmpName;

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Update Successfully")));

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
                            child: const Text("Update")),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("CANCEL")),
                      ],
                    );
                  });
            },
            child: const Icon(
              Icons.edit,
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Center(child: Text("Delete")),
                      content: const Text(
                          "Are you sure want  this record delete?",
                          style: TextStyle(fontSize: 15)),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Helper.helper.deleteData(id: arg.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Record Deleted Successfully...")));
                              Navigator.of(context).pushReplacementNamed("/");
                            },
                            child: const Text("DELETE")),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("CANCEL")),
                      ],
                    );
                  });
            },
            child: const Icon(
              Icons.delete,
              color: Colors.black87,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();

                XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);

                Uint8List bytesImage = await image!.readAsBytes();
                Helper.helper.updateImage(image: bytesImage, id: arg.id);

                setState(() {
                  Navigator.of(context).pushReplacementNamed("/");
                });
              },
              child: CircleAvatar(
                radius: 55,
                backgroundImage:
                    (arg.image != null) ? MemoryImage(arg.image) :  AssetImage("") as ImageProvider,
                child: (arg.image != null)
                    ? const Text("UPDATE")
                    : const Text("ADD"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Name:- ${arg.name}",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Salary:- ${arg.salary}",
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.grey, thickness: 1.5),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    "Id:- ${arg.id}",
                    style: const TextStyle(
                        fontSize: 19,
                        color: Color(0xff4d4646),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Age:- ${arg.age}",
                    style: const TextStyle(
                        fontSize: 19,
                        color: Color(0xff4d4646),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Company Name:- ${arg.cmpName}",
                    style: const TextStyle(
                        fontSize: 19,
                        color: Color(0xff4d4646),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Role:- ${arg.role}",
                    style: const TextStyle(
                        fontSize: 19,
                        color: Color(0xff4d4646),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Experience:- ${r.nextInt(9)} year",
                    style: const TextStyle(
                        fontSize: 19,
                        color: Color(0xff4d4646),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "City:- ${arg.city}",
                    style: const TextStyle(
                        fontSize: 19,
                        color: Color(0xff4d4646),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
