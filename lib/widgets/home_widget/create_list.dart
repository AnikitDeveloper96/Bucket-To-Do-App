// import 'package:flutter/material.dart';
// import '../../constants/colors.dart';

// class CreateList extends StatefulWidget {
//   static const String createList = "createList";
//   const CreateList(String newList, {Key? key}) : super(key: key);

//   @override
//   State<CreateList> createState() => _CreateListState();
// }

// class _CreateListState extends State<CreateList> {
//   String newList = "";

//   late FocusNode myFocusNode;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     myFocusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     myFocusNode.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final args =  ModalRoute.of(context)!.settings.arguments as CreateNewListArguments;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0.3,
//         centerTitle: true,
//         title: const Text(
//           "Create New List",
//           style: TextStyle(
//             color: AppColors.black,
//             fontWeight: FontWeight.w500,
//             fontStyle: FontStyle.normal,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.popAndPushNamed(context, MainHomepage.mainHomepage);
//           },
//           icon: const Icon(
//             Icons.clear,
//             color: AppColors.black,
//             size: 24.0,
//           ),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 args.createList!.add(newList);
//               });
//               Navigator.pop(context);
//             },
//             child: Visibility(
//               visible: newList.isNotEmpty ? true : false,
//               child: Container(
//                 margin: EdgeInsets.only(right: 12.0),
//                 child: const Center(
//                   child: Text(
//                     "Done",
//                     style: TextStyle(
//                       color: AppColors.blue,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       fontStyle: FontStyle.normal,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//             child: TextField(
//               focusNode: myFocusNode,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Create New List ',
//               ),
//               onTap: () => myFocusNode.requestFocus(),
//               onChanged: (value) {
//                 setState(() {
//                   newList = value;
//                 });
//               },
//               maxLines: 1,
//             ),
//           ),
//           Text("$newList"),
//         ],
//       ),
//     );
//   }
// }
