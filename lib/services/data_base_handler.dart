// import 'dart:convert';
//
// import 'package:izesan/model/assets.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import '../model/transaction.dart';
//
// class DatabaseHandler {
//   Future<Database> initializeDataBase() async {
//     String path = await getDatabasesPath();
//     return openDatabase(
//       join(path, 'izesan.db'),
//       //callback called after the database is created
//       onCreate: (db, version) async {
//         await db.execute(
//           """
//             CREATE TABLE transactions(
//               id INTEGER PRIMARY KEY,
//               name TEXT NOT NULL,
//               amount TEXT NOT NULL,
//               address TEXT NOT NULL,
//               vertical_type TEXT NOT NULL,
//               vend_status Text NOT NULL,
//               query_reference TEXT NOT NULL,
//               meter_no TEXT NOT NULL,
//               created_at TEXT NOT NULL
//             )
//           """,
//         );
//         await db.execute(
//           """
//             CREATE TABLE facility(
//               assets_id INTEGER PRIMARY KEY NOT NULL,
//               user_id INTEGER NOT NULL,
//               facility_id INTEGER NOT NULL,
//               status TEXT,
//               created_at TEXT NOT NULL,
//               update_at TEXT NOT NULL,
//               facility TEXT NOT NULL
//             )
//           """,
//         );
//       },
//       version: 1,
//     );
//   }
//
//   Future<void> insertTransaction(OrderHistory orderHistory) async {
//     await deleteAllAssets();
//     // Get a reference to the database.
//     final Database db = await initializeDataBase();
//     // In this case, replace any previous data.
//     await db.insert('transactions', orderHistory.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<void> insertCustomerAsset(Assets assets) async {
//     final Database db = await initializeDataBase();
//     await db.insert('facility', assets.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<List<dynamic>> retrieveOrders() async {
//     final Database db = await initializeDataBase();
//     final List queryResult = await db.query('transactions');
//     return List<dynamic>.generate(queryResult.length, (i) {
//       return OrderHistory(
//         id: queryResult[i]['id'],
//         name: queryResult[i]['name'],
//         amount: queryResult[i]['amount'],
//         address: queryResult[i]['address'],
//         vertical_type: queryResult[i]['vertical_type'],
//         vend_status:queryResult[i]['vend_status'],
//         query_reference:queryResult[i]['query_reference'],
//         meter_no: queryResult[i]['meter_no'],
//         created_at: queryResult[i]['created_at']
//       );
//     }).toList();
//   }
//
//   Future retrieveAsset() async {
//     try{
//       final Database db = await initializeDataBase();
//       final List queryResponse = await db.query('facility');
//       return List<dynamic>.generate(queryResponse.length, (index) {
//         return Assets(
//           assetsId: queryResponse[index]['assets_id'],
//           userId: queryResponse[index]['user_id'],
//           facilityId: queryResponse[index]['facility_id'],
//           status: queryResponse[index]['status'],
//           createdAt: queryResponse[index]['created_at'],
//           updatedAt: queryResponse[index]['update_at'],
//           facility: jsonDecode(jsonEncode(queryResponse[index]['facility'])),
//         );
//       });
//     }catch(e){
//     }
//   }
//
//   Future<void> deleteTransaction(int id) async {
//     final db = await initializeDataBase();
//     await db.delete(
//       'transactions',
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }
//   //delete all persons
//   deleteAllTransactions() async {
//     final db = await initializeDataBase();
//     db.delete("Person");
//   }
//
//   deleteAllAssets() async {
//     final db = await initializeDataBase();
//     db.delete("facility");
//   }
// }
