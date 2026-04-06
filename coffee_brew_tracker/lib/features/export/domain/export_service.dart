import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:coffee_brew_tracker/core/database/app_database.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';

class ExportService {
  final AppDatabase _db;

  ExportService(this._db);

  Future<void> exportDataAsCsv() async {
    final brews = await _db.getAllBrews();

    // Headers
    List<List<dynamic>> rows = [
      [
        'id',
        'brew_type',
        'coffee_name',
        'origin',
        'process',
        'roast_level',
        'grind_size',
        'temperature',
        'coffee_weight',
        'water_weight',
        'brew_time',
        'ratio',
        'rating',
        'notes',
        'flavor_notes',
        'created_at'
      ]
    ];

    // Data rows
    for (var b in brews) {
      rows.add([
        b.id,
        b.brewType,
        b.coffeeName,
        b.origin ?? '',
        b.process ?? '',
        b.roastLevel ?? '',
        b.grindSize,
        b.temperature,
        b.coffeeWeight,
        b.waterWeight ?? '',
        b.brewTime,
        b.ratio,
        b.rating,
        b.notes ?? '',
        b.flavorNotes ?? '',
        b.createdAt.toIso8601String() ?? '',
      ]);
    }

    String csvStr = const ListToCsvConverter().convert(rows);

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/brewlog_export.csv';
    final file = File(path);
    await file.writeAsString(csvStr);

    await Share.shareXFiles([XFile(path)], text: 'BrewLog CSV Export');
  }

  Future<void> exportDataAsJson() async {
    final brewsDb = await _db.getAllBrews();

    final List<Map<String, dynamic>> jsonList = brewsDb
        .map((b) => {
              'id': b.id,
              'brew_type': b.brewType,
              'coffee_name': b.coffeeName,
              'origin': b.origin,
              'process': b.process,
              'roast_level': b.roastLevel,
              'grind_size': b.grindSize,
              'temperature': b.temperature,
              'coffee_weight': b.coffeeWeight,
              'water_weight': b.waterWeight,
              'brew_time': b.brewTime,
              'ratio': b.ratio,
              'rating': b.rating,
              'notes': b.notes,
              'flavor_notes': b.flavorNotes,
              'created_at': b.createdAt.toIso8601String(),
            })
        .toList();

    String jsonStr = jsonEncode(jsonList);

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/brewlog_export.json';
    final file = File(path);
    await file.writeAsString(jsonStr);

    await Share.shareXFiles([XFile(path)], text: 'BrewLog JSON Export');
  }
}
