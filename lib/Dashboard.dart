import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyrack/Firebase_Model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'Login.dart';
import 'firebase_options.dart';

class Dashboard extends StatelessWidget {

  Dashboard() {
    init();
  }

  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home:  Dashboard1(),
    );
  }
}

class Dashboard1 extends StatefulWidget {
  const Dashboard1({super.key});

  @override
  State<Dashboard1> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard1> {
  late List<String> list;
  late Map<String,String> finalMap,finalMap2;
  TextEditingController site= TextEditingController();
  TextEditingController pass= TextEditingController();
  TextEditingController pass1= TextEditingController();
  TextEditingController searchTxt= TextEditingController();
  int flag=0,cnt=0;
  String searchPattern="";
  bool isObscure=true;


  _DashboardState() {
    list=[];
    finalMap={};
    finalMap2={};
  }
  GlobalKey<ScaffoldState> ListKey = GlobalKey<ScaffoldState>();
  FirebaseModel f1 = FirebaseModel();



  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
    useMaterial3: true,
    ),
      home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              backgroundColor: Colors.greenAccent,
              flexibleSpace: Container(
                  margin: EdgeInsets.only(top: 50,left: 50,right: 20),
                  width: 200,
                  height: 50,
                  child: searchBar()

              ),
            ),
          ),
        drawer: Drawer(
          child: ListView(

            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Column(
                  children: [
                     Container(
                      width: 70,height: 70,
                      child: Image.asset("assets/images/key.png"),
                    ),
                    Text('Key Rack',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Dashboard()));
                },
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: const Text('Contact us'),
                onTap: () async {
                  Uri uri = Uri.parse(
                    'mailto:shreeyashjanawade@gmail.com?subject=Flutter Url Launcher&body=Hi, Flutter developer',
                  );
                  if (!await launcher.launchUrl(uri)) {
                    debugPrint(
                        "Could not launch the uri");
                  }
                },
              ),
              SizedBox(height: 350),
              Divider(thickness: 2),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async{
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove('userKey');
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Login()));
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder<Map<String,String>>(
          key: ListKey,
          future: f1.getDataMap(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Map<String,String> data_ = snapshot.data ?? {};
              finalMap2.addAll(data_);
              if(flag==1) {
                Map<String,String> temp={};
                data_.forEach((key, value) {
                  if(key.toLowerCase().startsWith(searchPattern.toLowerCase())) {
                    temp[key]=value;
                  }
                });
                data_.clear();
                data_=temp;
              }
              if (data_.isEmpty) {
                return Center(child: Text("No data available"));
              }
              else {
                finalMap.clear();
                list.clear();
                return ListView.builder(

                  itemBuilder: (context, item) {

                    String key = data_.keys.elementAt(item) ;
                    String value = data_.values.elementAt(item);
                    finalMap[key] = value;
                    list.add(key);
                    return Container(
                      height: 120,
                      margin: EdgeInsets.all(10),
                      child: Card(
                        elevation: 6,
                        color: Colors.white70,
                        child: ListTile(
                          title: Text(key, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                          subtitle: const Text("Click to open", style: TextStyle(fontSize: 10, color: Colors.grey)),
                          trailing: IconButton(
                            onPressed: () {
                              showDeleteDialog(list[item]);
                            },
                            icon: const Icon(Icons.delete_forever),
                          ),
                          onTap: () {
                              pass1.text = finalMap[list[item]]!;
                              displayDialog(list[item], finalMap[list[item]]!);
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: data_.length,
                );
              }
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openDialog();
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  showDeleteDialog(String key) {
    Fluttertoast.showToast(msg: key);

    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
        content: SingleChildScrollView(
        child: Container(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Are you sure to delete $key data ?"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () { Navigator.pop(context); }, child: Text("Cancel")),
              ElevatedButton(onPressed: () {
                if(searchTxt.text.length>0)
                {
                   finalMap.addAll(finalMap2 );
                   finalMap.remove(key);
                   f1.addDataMap(finalMap);
                }
                else {
                  finalMap.remove(key);
                  f1.addDataMap(finalMap);
                }
                Navigator.pop(context);
                setState(() {});
              }, child: Text("delete"),style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),

            ],
          )
        ]
    )
    )
    )
    )
    );
  }
   openDialog() {
   return showDialog(
       context: context,
       builder: (context)=>AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {Navigator.pop(context); },
                          child: Icon(Icons.cancel),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Text("New Data")
                      ],
                    ),
                    SizedBox( width: 20),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                          controller: site,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.app_registration_outlined,color: Colors.greenAccent),
                            hintText: "Site name",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.greenAccent)
                            ),
                      
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                      
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        SizedBox(
                          width: 175,
                          child: TextField(
                              controller: pass,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.key,color: Colors.greenAccent),
                                hintText: "Password",
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.greenAccent)
                                ),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),

                              )),
                        ),
                        IconButton(
                            onPressed: (){
                              const chars = 'abcdefghijklmnopqrstuvwxyz...,,,++++==@@@###ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%&*_######)';
                              final random = Random();
                              String code = '';

                              for (int i = 0; i < 8; i++) {
                                code += chars[random.nextInt(chars.length)];
                              }
                              pass.text=code;
                        }, icon:   Icon(Icons.rotate_90_degrees_cw_outlined)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: () {
                          if(site.text.isEmpty || pass.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Enter data");
                            return;
                          }
                          finalMap.addAll(finalMap2);
                          setState(() {
                          });
                          finalMap[site.text.toString().trim()]=pass.text.toString().trim();
                           f1.addDataMap(finalMap);
                           site.text="";
                           pass.text="";
                           Fluttertoast.showToast(msg: "Data Added");
                           Navigator.pop(context);
                          setState(() {
                          });
                        },
                            child: Text("Save")),
                      ],
                    )
                  ],
                ),
              ),
            ),
       )
   );
  }

    displayDialog(String key,String val) {
      return showDialog(
          context: context,
          builder: (context)=>AlertDialog(
          content: SingleChildScrollView(
          child: Container(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  children:
                  [
                    GestureDetector(
                      onTap: () {Navigator.pop(context); },
                      child: Icon(Icons.cancel),
                    ),
                  ]
                  ),
            Text(key,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child:
                    TextField(
                        controller: pass1,
                        style: TextStyle(color: Colors.black),
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key,color: Colors.greenAccent),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.black),

                          ),

                        )),
                    ),
                  IconButton(onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: pass1.text));
                    Fluttertoast.showToast(msg: "Copied");
                  }, icon: Icon(Icons.copy))
                ],
              ),
              ]

          )
        )
      )
      )
      );
    }

    searchBar() {
    return TextField(
        controller: searchTxt,
        onChanged: (value) {
          if (value.isEmpty)
            flag = 0;
          else {
            flag = 1;
            searchPattern = value;
          }
          setState(() {});
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search,color: Colors.greenAccent),
          hintText: "search",
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey)
          ),

          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey)
          ),
        ));
    }

}
