import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todobucketapp/handlers/db_firestore.dart';
import 'package:todobucketapp/models/requestModels/requestmodel.dart';
import '../constants/colors.dart';

class MainHomepage extends StatefulWidget {
  static const String mainHomepage = "mainHomepage";
  const MainHomepage({Key? key}) : super(key: key);

  @override
  State<MainHomepage> createState() => _MainHomepageState();
}

class _MainHomepageState extends State<MainHomepage> {
  String task = "";
  late int _selectedIndex = 0;
  List<IconData> icons = [Icons.menu, Icons.more_vert];

  ToDoFirestore _toDoFirestore = ToDoFirestore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> dynamicTabs = ["My Tasks"];

  /// sublist content inside tab
  List<String> contentTabs = [];

  /// Adding dynamic tabs
  addDynamicTabs(String task, int getIndex) {
    setState(() {
      contentTabs.add(task);
      print("All Tasks are ${dynamicTabs.toString()} ");
    });
  }

  //--------------------//
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CollectionReference collection =
      FirebaseFirestore.instance.collection('/MyTasks');

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return DefaultTabController(
      length: dynamicTabs.length,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0.3,
            centerTitle: true,
            title: const Text(
              "Bucket App ",
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: const CircleAvatar(
                  minRadius: 20,
                  maxRadius: 25.0,
                  backgroundColor: AppColors.blue,
                  child: Text(
                    "D",
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              )
            ],
            bottom: TabBar(
                indicatorWeight: 3.0,
                indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 3.0, color: AppColors.lightblue),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                onTap: (int selectedIndex) {
                  setState(() {
                    selectedIndex = _selectedIndex;
                  });
                },
                tabs: List.generate(
                  dynamicTabs.length,
                  (index) => Tab(
                    child: Text(dynamicTabs[index],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: AppColors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0)),
                  ),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Tab(
                  //         child: Text(dynamicTabs[index],
                  //             style: const TextStyle(
                  //                 color: AppColors.black,
                  //                 fontStyle: FontStyle.normal,
                  //                 fontSize: 20.0)),
                  //       ),
                  //       // Container(
                  //       //   margin: EdgeInsets.only(left: 10.0),
                  //       //   child: Row(
                  //       //     mainAxisAlignment: MainAxisAlignment.start,
                  //       //     mainAxisSize: MainAxisSize.min,
                  //       //     children: [
                  //       //       Icon(
                  //       //         Icons.add,
                  //       //         color: AppColors.black,
                  //       //         size: 20.0,
                  //       //       ),
                  //       //       Container(
                  //       //         margin: EdgeInsets.only(left: 10.0),
                  //       //         child: Text("New List",
                  //       //             style: const TextStyle(
                  //       //                 color: AppColors.black,
                  //       //                 fontWeight: FontWeight.w400,
                  //       //                 fontStyle: FontStyle.normal,
                  //       //                 fontSize: 20.0)),
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       // ),
                  //     ])
                ))),

        /// TABBARVIEW
        body: TabBarView(
            children: List.generate(
                dynamicTabs.length,
                (index) => SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: collection.snapshots(),
                            builder: ((context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(
                                  color: AppColors.blue,
                                );
                              } else if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                var getSnapshot = snapshot.data?.docs.length;
                                print(
                                    "Inside connection ${snapshot.data!.docs.map((e) => e['task']).toList().toString()}");
                                return getSnapshot! > 1
                                    ? ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        reverse: true,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.docs[i]['task'],
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0),
                                              ),
                                            ],
                                          );
                                        })
                                    : SingleChildScrollView(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "No Task yet",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0),
                                              ),
                                              Text(
                                                "Add your to-do s and keep track of them across app !",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              }
                              return SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "No Task yet",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        "Add your to-do s and keep track of them across app !",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })),
                      ),
                    ))),
        bottomNavigationBar: BottomAppBar(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                icons.length,
                (index) => IconButton(
                  icon: Icon(icons[index]),
                  iconSize: 34.0,
                  color: AppColors.black,
                  onPressed: () {
                    setState(() {
                      print(
                          "Getting dynamic list is ${dynamicTabs.toList().toString()}");
                      print(
                          "Getting dynamic list from homepage is ${dynamicTabs.toList().toString()}");
                      index == 0
                          ? showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(23.0),
                                      right: Radius.circular(23.0))),
                              context: context,
                              builder: (context) => Wrap(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListView.separated(
                                              separatorBuilder:
                                                  (context, index) =>
                                                      Container(),
                                              itemCount: dynamicTabs.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15.0,
                                                            right: 10.0),
                                                    child: ListTile(
                                                      onTap: () {
                                                        setState(() {
                                                          index =
                                                              _selectedIndex;
                                                        });
                                                      },
                                                      tileColor:
                                                          _selectedIndex ==
                                                                  index
                                                              ? AppColors
                                                                  .lightblue
                                                              : AppColors.white,
                                                      textColor:
                                                          AppColors.black,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color: AppColors
                                                                      .lightblue),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        25),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            25),
                                                              )),
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            dynamicTabs[index],
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize:
                                                                    14.0)),
                                                      ),
                                                    ),
                                                  )),
                                          Divider(color: Colors.grey[400]),
                                          ListTile(
                                            tileColor: AppColors.white,
                                            onTap: () {
                                              // final result = Navigator.pushNamed(
                                              //     context,
                                              //     CreateList.createList,
                                              //     arguments:
                                              //         CreateNewListArguments(
                                              //             dynamicTabs));
                                              // print(
                                              //     "Getting new list from create list is ${result.toString()}");
                                              // setState(() {
                                              //   dynamicTabs =
                                              //       result as List<String>;
                                              // });
                                              // _toDoFirestore.createTask(
                                              //     dynamicTabs.first, task);
                                            },
                                            leading: Container(
                                                child: const Icon(Icons.add,
                                                    size: 25.0,
                                                    color: AppColors.black)),
                                            textColor: AppColors.black,
                                            title: const Text("Create New List",
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0)),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    });
                  },
                ),
              )),
        )),

        /// Floating action button -> ....
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          elevation: 10.0,
          isExtended: true,
          child: const Icon(
            Icons.add,
            color: AppColors.white,
            size: 23,
          ),
          onPressed: () {
            //// Add Task to new List
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  // <-- SEE HERE
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                isScrollControlled: true,
                builder: (context) {
                  /// Add Task
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Wrap(children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: mediaQuery.width * 0.03),
                              child: TextField(
                                onChanged: (value) =>
                                    {setState(() => task = value)},
                                maxLines: null,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0,
                                ),
                                // autofocus: false,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'New Task'),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /// save button
                                TextButton(
                                  onPressed: () async {
                                    await collection.doc().set({
                                      'task': task,
                                      'dateTime': DateTime.now()
                                    }).whenComplete(
                                        () => Navigator.pop(context));
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0,
                                      color: Colors.blue[600],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
                  );
                });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
