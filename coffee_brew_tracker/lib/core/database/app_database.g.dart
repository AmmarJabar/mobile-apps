// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BrewsTable extends Brews with TableInfo<$BrewsTable, Brew> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _brewTypeMeta =
      const VerificationMeta('brewType');
  @override
  late final GeneratedColumn<String> brewType = GeneratedColumn<String>(
      'brew_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coffeeNameMeta =
      const VerificationMeta('coffeeName');
  @override
  late final GeneratedColumn<String> coffeeName = GeneratedColumn<String>(
      'coffee_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roasterMeta =
      const VerificationMeta('roaster');
  @override
  late final GeneratedColumn<String> roaster = GeneratedColumn<String>(
      'roaster', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _processMeta =
      const VerificationMeta('process');
  @override
  late final GeneratedColumn<String> process = GeneratedColumn<String>(
      'process', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roastLevelMeta =
      const VerificationMeta('roastLevel');
  @override
  late final GeneratedColumn<String> roastLevel = GeneratedColumn<String>(
      'roast_level', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _grindSizeMeta =
      const VerificationMeta('grindSize');
  @override
  late final GeneratedColumn<double> grindSize = GeneratedColumn<double>(
      'grind_size', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
      'temperature', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _coffeeWeightMeta =
      const VerificationMeta('coffeeWeight');
  @override
  late final GeneratedColumn<double> coffeeWeight = GeneratedColumn<double>(
      'coffee_weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _waterWeightMeta =
      const VerificationMeta('waterWeight');
  @override
  late final GeneratedColumn<double> waterWeight = GeneratedColumn<double>(
      'water_weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _brewTimeMeta =
      const VerificationMeta('brewTime');
  @override
  late final GeneratedColumn<int> brewTime = GeneratedColumn<int>(
      'brew_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ratioMeta = const VerificationMeta('ratio');
  @override
  late final GeneratedColumn<double> ratio = GeneratedColumn<double>(
      'ratio', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
      'rating', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _flavorNotesMeta =
      const VerificationMeta('flavorNotes');
  @override
  late final GeneratedColumn<String> flavorNotes = GeneratedColumn<String>(
      'flavor_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        brewType,
        coffeeName,
        origin,
        roaster,
        process,
        roastLevel,
        grindSize,
        temperature,
        coffeeWeight,
        waterWeight,
        brewTime,
        ratio,
        rating,
        notes,
        flavorNotes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brews';
  @override
  VerificationContext validateIntegrity(Insertable<Brew> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brew_type')) {
      context.handle(_brewTypeMeta,
          brewType.isAcceptableOrUnknown(data['brew_type']!, _brewTypeMeta));
    } else if (isInserting) {
      context.missing(_brewTypeMeta);
    }
    if (data.containsKey('coffee_name')) {
      context.handle(
          _coffeeNameMeta,
          coffeeName.isAcceptableOrUnknown(
              data['coffee_name']!, _coffeeNameMeta));
    } else if (isInserting) {
      context.missing(_coffeeNameMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    }
    if (data.containsKey('roaster')) {
      context.handle(_roasterMeta,
          roaster.isAcceptableOrUnknown(data['roaster']!, _roasterMeta));
    }
    if (data.containsKey('process')) {
      context.handle(_processMeta,
          process.isAcceptableOrUnknown(data['process']!, _processMeta));
    }
    if (data.containsKey('roast_level')) {
      context.handle(
          _roastLevelMeta,
          roastLevel.isAcceptableOrUnknown(
              data['roast_level']!, _roastLevelMeta));
    }
    if (data.containsKey('grind_size')) {
      context.handle(_grindSizeMeta,
          grindSize.isAcceptableOrUnknown(data['grind_size']!, _grindSizeMeta));
    } else if (isInserting) {
      context.missing(_grindSizeMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature']!, _temperatureMeta));
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('coffee_weight')) {
      context.handle(
          _coffeeWeightMeta,
          coffeeWeight.isAcceptableOrUnknown(
              data['coffee_weight']!, _coffeeWeightMeta));
    } else if (isInserting) {
      context.missing(_coffeeWeightMeta);
    }
    if (data.containsKey('water_weight')) {
      context.handle(
          _waterWeightMeta,
          waterWeight.isAcceptableOrUnknown(
              data['water_weight']!, _waterWeightMeta));
    }
    if (data.containsKey('brew_time')) {
      context.handle(_brewTimeMeta,
          brewTime.isAcceptableOrUnknown(data['brew_time']!, _brewTimeMeta));
    } else if (isInserting) {
      context.missing(_brewTimeMeta);
    }
    if (data.containsKey('ratio')) {
      context.handle(
          _ratioMeta, ratio.isAcceptableOrUnknown(data['ratio']!, _ratioMeta));
    } else if (isInserting) {
      context.missing(_ratioMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('flavor_notes')) {
      context.handle(
          _flavorNotesMeta,
          flavorNotes.isAcceptableOrUnknown(
              data['flavor_notes']!, _flavorNotesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Brew map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Brew(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      brewType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brew_type'])!,
      coffeeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coffee_name'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin']),
      roaster: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}roaster']),
      process: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}process']),
      roastLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}roast_level']),
      grindSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}grind_size'])!,
      temperature: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}temperature'])!,
      coffeeWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}coffee_weight'])!,
      waterWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}water_weight']),
      brewTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}brew_time'])!,
      ratio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ratio'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rating'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      flavorNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flavor_notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BrewsTable createAlias(String alias) {
    return $BrewsTable(attachedDatabase, alias);
  }
}

class Brew extends DataClass implements Insertable<Brew> {
  final int id;
  final String brewType;
  final String coffeeName;
  final String? origin;
  final String? roaster;
  final String? process;
  final String? roastLevel;
  final double grindSize;
  final double temperature;
  final double coffeeWeight;
  final double? waterWeight;
  final int brewTime;
  final double ratio;
  final int rating;
  final String? notes;
  final String? flavorNotes;
  final DateTime createdAt;
  const Brew(
      {required this.id,
      required this.brewType,
      required this.coffeeName,
      this.origin,
      this.roaster,
      this.process,
      this.roastLevel,
      required this.grindSize,
      required this.temperature,
      required this.coffeeWeight,
      this.waterWeight,
      required this.brewTime,
      required this.ratio,
      required this.rating,
      this.notes,
      this.flavorNotes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brew_type'] = Variable<String>(brewType);
    map['coffee_name'] = Variable<String>(coffeeName);
    if (!nullToAbsent || origin != null) {
      map['origin'] = Variable<String>(origin);
    }
    if (!nullToAbsent || roaster != null) {
      map['roaster'] = Variable<String>(roaster);
    }
    if (!nullToAbsent || process != null) {
      map['process'] = Variable<String>(process);
    }
    if (!nullToAbsent || roastLevel != null) {
      map['roast_level'] = Variable<String>(roastLevel);
    }
    map['grind_size'] = Variable<double>(grindSize);
    map['temperature'] = Variable<double>(temperature);
    map['coffee_weight'] = Variable<double>(coffeeWeight);
    if (!nullToAbsent || waterWeight != null) {
      map['water_weight'] = Variable<double>(waterWeight);
    }
    map['brew_time'] = Variable<int>(brewTime);
    map['ratio'] = Variable<double>(ratio);
    map['rating'] = Variable<int>(rating);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || flavorNotes != null) {
      map['flavor_notes'] = Variable<String>(flavorNotes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BrewsCompanion toCompanion(bool nullToAbsent) {
    return BrewsCompanion(
      id: Value(id),
      brewType: Value(brewType),
      coffeeName: Value(coffeeName),
      origin:
          origin == null && nullToAbsent ? const Value.absent() : Value(origin),
      roaster: roaster == null && nullToAbsent
          ? const Value.absent()
          : Value(roaster),
      process: process == null && nullToAbsent
          ? const Value.absent()
          : Value(process),
      roastLevel: roastLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(roastLevel),
      grindSize: Value(grindSize),
      temperature: Value(temperature),
      coffeeWeight: Value(coffeeWeight),
      waterWeight: waterWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(waterWeight),
      brewTime: Value(brewTime),
      ratio: Value(ratio),
      rating: Value(rating),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      flavorNotes: flavorNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(flavorNotes),
      createdAt: Value(createdAt),
    );
  }

  factory Brew.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Brew(
      id: serializer.fromJson<int>(json['id']),
      brewType: serializer.fromJson<String>(json['brewType']),
      coffeeName: serializer.fromJson<String>(json['coffeeName']),
      origin: serializer.fromJson<String?>(json['origin']),
      roaster: serializer.fromJson<String?>(json['roaster']),
      process: serializer.fromJson<String?>(json['process']),
      roastLevel: serializer.fromJson<String?>(json['roastLevel']),
      grindSize: serializer.fromJson<double>(json['grindSize']),
      temperature: serializer.fromJson<double>(json['temperature']),
      coffeeWeight: serializer.fromJson<double>(json['coffeeWeight']),
      waterWeight: serializer.fromJson<double?>(json['waterWeight']),
      brewTime: serializer.fromJson<int>(json['brewTime']),
      ratio: serializer.fromJson<double>(json['ratio']),
      rating: serializer.fromJson<int>(json['rating']),
      notes: serializer.fromJson<String?>(json['notes']),
      flavorNotes: serializer.fromJson<String?>(json['flavorNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brewType': serializer.toJson<String>(brewType),
      'coffeeName': serializer.toJson<String>(coffeeName),
      'origin': serializer.toJson<String?>(origin),
      'roaster': serializer.toJson<String?>(roaster),
      'process': serializer.toJson<String?>(process),
      'roastLevel': serializer.toJson<String?>(roastLevel),
      'grindSize': serializer.toJson<double>(grindSize),
      'temperature': serializer.toJson<double>(temperature),
      'coffeeWeight': serializer.toJson<double>(coffeeWeight),
      'waterWeight': serializer.toJson<double?>(waterWeight),
      'brewTime': serializer.toJson<int>(brewTime),
      'ratio': serializer.toJson<double>(ratio),
      'rating': serializer.toJson<int>(rating),
      'notes': serializer.toJson<String?>(notes),
      'flavorNotes': serializer.toJson<String?>(flavorNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Brew copyWith(
          {int? id,
          String? brewType,
          String? coffeeName,
          Value<String?> origin = const Value.absent(),
          Value<String?> roaster = const Value.absent(),
          Value<String?> process = const Value.absent(),
          Value<String?> roastLevel = const Value.absent(),
          double? grindSize,
          double? temperature,
          double? coffeeWeight,
          Value<double?> waterWeight = const Value.absent(),
          int? brewTime,
          double? ratio,
          int? rating,
          Value<String?> notes = const Value.absent(),
          Value<String?> flavorNotes = const Value.absent(),
          DateTime? createdAt}) =>
      Brew(
        id: id ?? this.id,
        brewType: brewType ?? this.brewType,
        coffeeName: coffeeName ?? this.coffeeName,
        origin: origin.present ? origin.value : this.origin,
        roaster: roaster.present ? roaster.value : this.roaster,
        process: process.present ? process.value : this.process,
        roastLevel: roastLevel.present ? roastLevel.value : this.roastLevel,
        grindSize: grindSize ?? this.grindSize,
        temperature: temperature ?? this.temperature,
        coffeeWeight: coffeeWeight ?? this.coffeeWeight,
        waterWeight: waterWeight.present ? waterWeight.value : this.waterWeight,
        brewTime: brewTime ?? this.brewTime,
        ratio: ratio ?? this.ratio,
        rating: rating ?? this.rating,
        notes: notes.present ? notes.value : this.notes,
        flavorNotes: flavorNotes.present ? flavorNotes.value : this.flavorNotes,
        createdAt: createdAt ?? this.createdAt,
      );
  Brew copyWithCompanion(BrewsCompanion data) {
    return Brew(
      id: data.id.present ? data.id.value : this.id,
      brewType: data.brewType.present ? data.brewType.value : this.brewType,
      coffeeName:
          data.coffeeName.present ? data.coffeeName.value : this.coffeeName,
      origin: data.origin.present ? data.origin.value : this.origin,
      roaster: data.roaster.present ? data.roaster.value : this.roaster,
      process: data.process.present ? data.process.value : this.process,
      roastLevel:
          data.roastLevel.present ? data.roastLevel.value : this.roastLevel,
      grindSize: data.grindSize.present ? data.grindSize.value : this.grindSize,
      temperature:
          data.temperature.present ? data.temperature.value : this.temperature,
      coffeeWeight: data.coffeeWeight.present
          ? data.coffeeWeight.value
          : this.coffeeWeight,
      waterWeight:
          data.waterWeight.present ? data.waterWeight.value : this.waterWeight,
      brewTime: data.brewTime.present ? data.brewTime.value : this.brewTime,
      ratio: data.ratio.present ? data.ratio.value : this.ratio,
      rating: data.rating.present ? data.rating.value : this.rating,
      notes: data.notes.present ? data.notes.value : this.notes,
      flavorNotes:
          data.flavorNotes.present ? data.flavorNotes.value : this.flavorNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Brew(')
          ..write('id: $id, ')
          ..write('brewType: $brewType, ')
          ..write('coffeeName: $coffeeName, ')
          ..write('origin: $origin, ')
          ..write('roaster: $roaster, ')
          ..write('process: $process, ')
          ..write('roastLevel: $roastLevel, ')
          ..write('grindSize: $grindSize, ')
          ..write('temperature: $temperature, ')
          ..write('coffeeWeight: $coffeeWeight, ')
          ..write('waterWeight: $waterWeight, ')
          ..write('brewTime: $brewTime, ')
          ..write('ratio: $ratio, ')
          ..write('rating: $rating, ')
          ..write('notes: $notes, ')
          ..write('flavorNotes: $flavorNotes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      brewType,
      coffeeName,
      origin,
      roaster,
      process,
      roastLevel,
      grindSize,
      temperature,
      coffeeWeight,
      waterWeight,
      brewTime,
      ratio,
      rating,
      notes,
      flavorNotes,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Brew &&
          other.id == this.id &&
          other.brewType == this.brewType &&
          other.coffeeName == this.coffeeName &&
          other.origin == this.origin &&
          other.roaster == this.roaster &&
          other.process == this.process &&
          other.roastLevel == this.roastLevel &&
          other.grindSize == this.grindSize &&
          other.temperature == this.temperature &&
          other.coffeeWeight == this.coffeeWeight &&
          other.waterWeight == this.waterWeight &&
          other.brewTime == this.brewTime &&
          other.ratio == this.ratio &&
          other.rating == this.rating &&
          other.notes == this.notes &&
          other.flavorNotes == this.flavorNotes &&
          other.createdAt == this.createdAt);
}

class BrewsCompanion extends UpdateCompanion<Brew> {
  final Value<int> id;
  final Value<String> brewType;
  final Value<String> coffeeName;
  final Value<String?> origin;
  final Value<String?> roaster;
  final Value<String?> process;
  final Value<String?> roastLevel;
  final Value<double> grindSize;
  final Value<double> temperature;
  final Value<double> coffeeWeight;
  final Value<double?> waterWeight;
  final Value<int> brewTime;
  final Value<double> ratio;
  final Value<int> rating;
  final Value<String?> notes;
  final Value<String?> flavorNotes;
  final Value<DateTime> createdAt;
  const BrewsCompanion({
    this.id = const Value.absent(),
    this.brewType = const Value.absent(),
    this.coffeeName = const Value.absent(),
    this.origin = const Value.absent(),
    this.roaster = const Value.absent(),
    this.process = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.grindSize = const Value.absent(),
    this.temperature = const Value.absent(),
    this.coffeeWeight = const Value.absent(),
    this.waterWeight = const Value.absent(),
    this.brewTime = const Value.absent(),
    this.ratio = const Value.absent(),
    this.rating = const Value.absent(),
    this.notes = const Value.absent(),
    this.flavorNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BrewsCompanion.insert({
    this.id = const Value.absent(),
    required String brewType,
    required String coffeeName,
    this.origin = const Value.absent(),
    this.roaster = const Value.absent(),
    this.process = const Value.absent(),
    this.roastLevel = const Value.absent(),
    required double grindSize,
    required double temperature,
    required double coffeeWeight,
    this.waterWeight = const Value.absent(),
    required int brewTime,
    required double ratio,
    required int rating,
    this.notes = const Value.absent(),
    this.flavorNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : brewType = Value(brewType),
        coffeeName = Value(coffeeName),
        grindSize = Value(grindSize),
        temperature = Value(temperature),
        coffeeWeight = Value(coffeeWeight),
        brewTime = Value(brewTime),
        ratio = Value(ratio),
        rating = Value(rating);
  static Insertable<Brew> custom({
    Expression<int>? id,
    Expression<String>? brewType,
    Expression<String>? coffeeName,
    Expression<String>? origin,
    Expression<String>? roaster,
    Expression<String>? process,
    Expression<String>? roastLevel,
    Expression<double>? grindSize,
    Expression<double>? temperature,
    Expression<double>? coffeeWeight,
    Expression<double>? waterWeight,
    Expression<int>? brewTime,
    Expression<double>? ratio,
    Expression<int>? rating,
    Expression<String>? notes,
    Expression<String>? flavorNotes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brewType != null) 'brew_type': brewType,
      if (coffeeName != null) 'coffee_name': coffeeName,
      if (origin != null) 'origin': origin,
      if (roaster != null) 'roaster': roaster,
      if (process != null) 'process': process,
      if (roastLevel != null) 'roast_level': roastLevel,
      if (grindSize != null) 'grind_size': grindSize,
      if (temperature != null) 'temperature': temperature,
      if (coffeeWeight != null) 'coffee_weight': coffeeWeight,
      if (waterWeight != null) 'water_weight': waterWeight,
      if (brewTime != null) 'brew_time': brewTime,
      if (ratio != null) 'ratio': ratio,
      if (rating != null) 'rating': rating,
      if (notes != null) 'notes': notes,
      if (flavorNotes != null) 'flavor_notes': flavorNotes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BrewsCompanion copyWith(
      {Value<int>? id,
      Value<String>? brewType,
      Value<String>? coffeeName,
      Value<String?>? origin,
      Value<String?>? roaster,
      Value<String?>? process,
      Value<String?>? roastLevel,
      Value<double>? grindSize,
      Value<double>? temperature,
      Value<double>? coffeeWeight,
      Value<double?>? waterWeight,
      Value<int>? brewTime,
      Value<double>? ratio,
      Value<int>? rating,
      Value<String?>? notes,
      Value<String?>? flavorNotes,
      Value<DateTime>? createdAt}) {
    return BrewsCompanion(
      id: id ?? this.id,
      brewType: brewType ?? this.brewType,
      coffeeName: coffeeName ?? this.coffeeName,
      origin: origin ?? this.origin,
      roaster: roaster ?? this.roaster,
      process: process ?? this.process,
      roastLevel: roastLevel ?? this.roastLevel,
      grindSize: grindSize ?? this.grindSize,
      temperature: temperature ?? this.temperature,
      coffeeWeight: coffeeWeight ?? this.coffeeWeight,
      waterWeight: waterWeight ?? this.waterWeight,
      brewTime: brewTime ?? this.brewTime,
      ratio: ratio ?? this.ratio,
      rating: rating ?? this.rating,
      notes: notes ?? this.notes,
      flavorNotes: flavorNotes ?? this.flavorNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brewType.present) {
      map['brew_type'] = Variable<String>(brewType.value);
    }
    if (coffeeName.present) {
      map['coffee_name'] = Variable<String>(coffeeName.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (roaster.present) {
      map['roaster'] = Variable<String>(roaster.value);
    }
    if (process.present) {
      map['process'] = Variable<String>(process.value);
    }
    if (roastLevel.present) {
      map['roast_level'] = Variable<String>(roastLevel.value);
    }
    if (grindSize.present) {
      map['grind_size'] = Variable<double>(grindSize.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (coffeeWeight.present) {
      map['coffee_weight'] = Variable<double>(coffeeWeight.value);
    }
    if (waterWeight.present) {
      map['water_weight'] = Variable<double>(waterWeight.value);
    }
    if (brewTime.present) {
      map['brew_time'] = Variable<int>(brewTime.value);
    }
    if (ratio.present) {
      map['ratio'] = Variable<double>(ratio.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (flavorNotes.present) {
      map['flavor_notes'] = Variable<String>(flavorNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrewsCompanion(')
          ..write('id: $id, ')
          ..write('brewType: $brewType, ')
          ..write('coffeeName: $coffeeName, ')
          ..write('origin: $origin, ')
          ..write('roaster: $roaster, ')
          ..write('process: $process, ')
          ..write('roastLevel: $roastLevel, ')
          ..write('grindSize: $grindSize, ')
          ..write('temperature: $temperature, ')
          ..write('coffeeWeight: $coffeeWeight, ')
          ..write('waterWeight: $waterWeight, ')
          ..write('brewTime: $brewTime, ')
          ..write('ratio: $ratio, ')
          ..write('rating: $rating, ')
          ..write('notes: $notes, ')
          ..write('flavorNotes: $flavorNotes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PourOversTable extends PourOvers
    with TableInfo<$PourOversTable, PourOver> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PourOversTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _brewIdMeta = const VerificationMeta('brewId');
  @override
  late final GeneratedColumn<int> brewId = GeneratedColumn<int>(
      'brew_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES brews (id)'));
  static const VerificationMeta _brewMethodMeta =
      const VerificationMeta('brewMethod');
  @override
  late final GeneratedColumn<String> brewMethod = GeneratedColumn<String>(
      'brew_method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recipeMeta = const VerificationMeta('recipe');
  @override
  late final GeneratedColumn<String> recipe = GeneratedColumn<String>(
      'recipe', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, brewId, brewMethod, recipe];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pour_overs';
  @override
  VerificationContext validateIntegrity(Insertable<PourOver> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brew_id')) {
      context.handle(_brewIdMeta,
          brewId.isAcceptableOrUnknown(data['brew_id']!, _brewIdMeta));
    } else if (isInserting) {
      context.missing(_brewIdMeta);
    }
    if (data.containsKey('brew_method')) {
      context.handle(
          _brewMethodMeta,
          brewMethod.isAcceptableOrUnknown(
              data['brew_method']!, _brewMethodMeta));
    } else if (isInserting) {
      context.missing(_brewMethodMeta);
    }
    if (data.containsKey('recipe')) {
      context.handle(_recipeMeta,
          recipe.isAcceptableOrUnknown(data['recipe']!, _recipeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PourOver map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PourOver(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      brewId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}brew_id'])!,
      brewMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brew_method'])!,
      recipe: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recipe']),
    );
  }

  @override
  $PourOversTable createAlias(String alias) {
    return $PourOversTable(attachedDatabase, alias);
  }
}

class PourOver extends DataClass implements Insertable<PourOver> {
  final int id;
  final int brewId;
  final String brewMethod;
  final String? recipe;
  const PourOver(
      {required this.id,
      required this.brewId,
      required this.brewMethod,
      this.recipe});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brew_id'] = Variable<int>(brewId);
    map['brew_method'] = Variable<String>(brewMethod);
    if (!nullToAbsent || recipe != null) {
      map['recipe'] = Variable<String>(recipe);
    }
    return map;
  }

  PourOversCompanion toCompanion(bool nullToAbsent) {
    return PourOversCompanion(
      id: Value(id),
      brewId: Value(brewId),
      brewMethod: Value(brewMethod),
      recipe:
          recipe == null && nullToAbsent ? const Value.absent() : Value(recipe),
    );
  }

  factory PourOver.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PourOver(
      id: serializer.fromJson<int>(json['id']),
      brewId: serializer.fromJson<int>(json['brewId']),
      brewMethod: serializer.fromJson<String>(json['brewMethod']),
      recipe: serializer.fromJson<String?>(json['recipe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brewId': serializer.toJson<int>(brewId),
      'brewMethod': serializer.toJson<String>(brewMethod),
      'recipe': serializer.toJson<String?>(recipe),
    };
  }

  PourOver copyWith(
          {int? id,
          int? brewId,
          String? brewMethod,
          Value<String?> recipe = const Value.absent()}) =>
      PourOver(
        id: id ?? this.id,
        brewId: brewId ?? this.brewId,
        brewMethod: brewMethod ?? this.brewMethod,
        recipe: recipe.present ? recipe.value : this.recipe,
      );
  PourOver copyWithCompanion(PourOversCompanion data) {
    return PourOver(
      id: data.id.present ? data.id.value : this.id,
      brewId: data.brewId.present ? data.brewId.value : this.brewId,
      brewMethod:
          data.brewMethod.present ? data.brewMethod.value : this.brewMethod,
      recipe: data.recipe.present ? data.recipe.value : this.recipe,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PourOver(')
          ..write('id: $id, ')
          ..write('brewId: $brewId, ')
          ..write('brewMethod: $brewMethod, ')
          ..write('recipe: $recipe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, brewId, brewMethod, recipe);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PourOver &&
          other.id == this.id &&
          other.brewId == this.brewId &&
          other.brewMethod == this.brewMethod &&
          other.recipe == this.recipe);
}

class PourOversCompanion extends UpdateCompanion<PourOver> {
  final Value<int> id;
  final Value<int> brewId;
  final Value<String> brewMethod;
  final Value<String?> recipe;
  const PourOversCompanion({
    this.id = const Value.absent(),
    this.brewId = const Value.absent(),
    this.brewMethod = const Value.absent(),
    this.recipe = const Value.absent(),
  });
  PourOversCompanion.insert({
    this.id = const Value.absent(),
    required int brewId,
    required String brewMethod,
    this.recipe = const Value.absent(),
  })  : brewId = Value(brewId),
        brewMethod = Value(brewMethod);
  static Insertable<PourOver> custom({
    Expression<int>? id,
    Expression<int>? brewId,
    Expression<String>? brewMethod,
    Expression<String>? recipe,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brewId != null) 'brew_id': brewId,
      if (brewMethod != null) 'brew_method': brewMethod,
      if (recipe != null) 'recipe': recipe,
    });
  }

  PourOversCompanion copyWith(
      {Value<int>? id,
      Value<int>? brewId,
      Value<String>? brewMethod,
      Value<String?>? recipe}) {
    return PourOversCompanion(
      id: id ?? this.id,
      brewId: brewId ?? this.brewId,
      brewMethod: brewMethod ?? this.brewMethod,
      recipe: recipe ?? this.recipe,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brewId.present) {
      map['brew_id'] = Variable<int>(brewId.value);
    }
    if (brewMethod.present) {
      map['brew_method'] = Variable<String>(brewMethod.value);
    }
    if (recipe.present) {
      map['recipe'] = Variable<String>(recipe.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PourOversCompanion(')
          ..write('id: $id, ')
          ..write('brewId: $brewId, ')
          ..write('brewMethod: $brewMethod, ')
          ..write('recipe: $recipe')
          ..write(')'))
        .toString();
  }
}

class $EspressosTable extends Espressos
    with TableInfo<$EspressosTable, Espresso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EspressosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _brewIdMeta = const VerificationMeta('brewId');
  @override
  late final GeneratedColumn<int> brewId = GeneratedColumn<int>(
      'brew_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES brews (id)'));
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<double> dose = GeneratedColumn<double>(
      'dose', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _brewYieldMeta =
      const VerificationMeta('brewYield');
  @override
  late final GeneratedColumn<double> brewYield = GeneratedColumn<double>(
      'brew_yield', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _extractionTimeMeta =
      const VerificationMeta('extractionTime');
  @override
  late final GeneratedColumn<int> extractionTime = GeneratedColumn<int>(
      'extraction_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _machineUsedMeta =
      const VerificationMeta('machineUsed');
  @override
  late final GeneratedColumn<String> machineUsed = GeneratedColumn<String>(
      'machine_used', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pressureMeta =
      const VerificationMeta('pressure');
  @override
  late final GeneratedColumn<double> pressure = GeneratedColumn<double>(
      'pressure', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _preInfusionTimeMeta =
      const VerificationMeta('preInfusionTime');
  @override
  late final GeneratedColumn<int> preInfusionTime = GeneratedColumn<int>(
      'pre_infusion_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        brewId,
        dose,
        brewYield,
        extractionTime,
        machineUsed,
        pressure,
        preInfusionTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'espressos';
  @override
  VerificationContext validateIntegrity(Insertable<Espresso> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brew_id')) {
      context.handle(_brewIdMeta,
          brewId.isAcceptableOrUnknown(data['brew_id']!, _brewIdMeta));
    } else if (isInserting) {
      context.missing(_brewIdMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
          _doseMeta, dose.isAcceptableOrUnknown(data['dose']!, _doseMeta));
    } else if (isInserting) {
      context.missing(_doseMeta);
    }
    if (data.containsKey('brew_yield')) {
      context.handle(_brewYieldMeta,
          brewYield.isAcceptableOrUnknown(data['brew_yield']!, _brewYieldMeta));
    } else if (isInserting) {
      context.missing(_brewYieldMeta);
    }
    if (data.containsKey('extraction_time')) {
      context.handle(
          _extractionTimeMeta,
          extractionTime.isAcceptableOrUnknown(
              data['extraction_time']!, _extractionTimeMeta));
    } else if (isInserting) {
      context.missing(_extractionTimeMeta);
    }
    if (data.containsKey('machine_used')) {
      context.handle(
          _machineUsedMeta,
          machineUsed.isAcceptableOrUnknown(
              data['machine_used']!, _machineUsedMeta));
    }
    if (data.containsKey('pressure')) {
      context.handle(_pressureMeta,
          pressure.isAcceptableOrUnknown(data['pressure']!, _pressureMeta));
    }
    if (data.containsKey('pre_infusion_time')) {
      context.handle(
          _preInfusionTimeMeta,
          preInfusionTime.isAcceptableOrUnknown(
              data['pre_infusion_time']!, _preInfusionTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Espresso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Espresso(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      brewId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}brew_id'])!,
      dose: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dose'])!,
      brewYield: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}brew_yield'])!,
      extractionTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}extraction_time'])!,
      machineUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}machine_used']),
      pressure: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pressure']),
      preInfusionTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pre_infusion_time']),
    );
  }

  @override
  $EspressosTable createAlias(String alias) {
    return $EspressosTable(attachedDatabase, alias);
  }
}

class Espresso extends DataClass implements Insertable<Espresso> {
  final int id;
  final int brewId;
  final double dose;
  final double brewYield;
  final int extractionTime;
  final String? machineUsed;
  final double? pressure;
  final int? preInfusionTime;
  const Espresso(
      {required this.id,
      required this.brewId,
      required this.dose,
      required this.brewYield,
      required this.extractionTime,
      this.machineUsed,
      this.pressure,
      this.preInfusionTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brew_id'] = Variable<int>(brewId);
    map['dose'] = Variable<double>(dose);
    map['brew_yield'] = Variable<double>(brewYield);
    map['extraction_time'] = Variable<int>(extractionTime);
    if (!nullToAbsent || machineUsed != null) {
      map['machine_used'] = Variable<String>(machineUsed);
    }
    if (!nullToAbsent || pressure != null) {
      map['pressure'] = Variable<double>(pressure);
    }
    if (!nullToAbsent || preInfusionTime != null) {
      map['pre_infusion_time'] = Variable<int>(preInfusionTime);
    }
    return map;
  }

  EspressosCompanion toCompanion(bool nullToAbsent) {
    return EspressosCompanion(
      id: Value(id),
      brewId: Value(brewId),
      dose: Value(dose),
      brewYield: Value(brewYield),
      extractionTime: Value(extractionTime),
      machineUsed: machineUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(machineUsed),
      pressure: pressure == null && nullToAbsent
          ? const Value.absent()
          : Value(pressure),
      preInfusionTime: preInfusionTime == null && nullToAbsent
          ? const Value.absent()
          : Value(preInfusionTime),
    );
  }

  factory Espresso.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Espresso(
      id: serializer.fromJson<int>(json['id']),
      brewId: serializer.fromJson<int>(json['brewId']),
      dose: serializer.fromJson<double>(json['dose']),
      brewYield: serializer.fromJson<double>(json['brewYield']),
      extractionTime: serializer.fromJson<int>(json['extractionTime']),
      machineUsed: serializer.fromJson<String?>(json['machineUsed']),
      pressure: serializer.fromJson<double?>(json['pressure']),
      preInfusionTime: serializer.fromJson<int?>(json['preInfusionTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brewId': serializer.toJson<int>(brewId),
      'dose': serializer.toJson<double>(dose),
      'brewYield': serializer.toJson<double>(brewYield),
      'extractionTime': serializer.toJson<int>(extractionTime),
      'machineUsed': serializer.toJson<String?>(machineUsed),
      'pressure': serializer.toJson<double?>(pressure),
      'preInfusionTime': serializer.toJson<int?>(preInfusionTime),
    };
  }

  Espresso copyWith(
          {int? id,
          int? brewId,
          double? dose,
          double? brewYield,
          int? extractionTime,
          Value<String?> machineUsed = const Value.absent(),
          Value<double?> pressure = const Value.absent(),
          Value<int?> preInfusionTime = const Value.absent()}) =>
      Espresso(
        id: id ?? this.id,
        brewId: brewId ?? this.brewId,
        dose: dose ?? this.dose,
        brewYield: brewYield ?? this.brewYield,
        extractionTime: extractionTime ?? this.extractionTime,
        machineUsed: machineUsed.present ? machineUsed.value : this.machineUsed,
        pressure: pressure.present ? pressure.value : this.pressure,
        preInfusionTime: preInfusionTime.present
            ? preInfusionTime.value
            : this.preInfusionTime,
      );
  Espresso copyWithCompanion(EspressosCompanion data) {
    return Espresso(
      id: data.id.present ? data.id.value : this.id,
      brewId: data.brewId.present ? data.brewId.value : this.brewId,
      dose: data.dose.present ? data.dose.value : this.dose,
      brewYield: data.brewYield.present ? data.brewYield.value : this.brewYield,
      extractionTime: data.extractionTime.present
          ? data.extractionTime.value
          : this.extractionTime,
      machineUsed:
          data.machineUsed.present ? data.machineUsed.value : this.machineUsed,
      pressure: data.pressure.present ? data.pressure.value : this.pressure,
      preInfusionTime: data.preInfusionTime.present
          ? data.preInfusionTime.value
          : this.preInfusionTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Espresso(')
          ..write('id: $id, ')
          ..write('brewId: $brewId, ')
          ..write('dose: $dose, ')
          ..write('brewYield: $brewYield, ')
          ..write('extractionTime: $extractionTime, ')
          ..write('machineUsed: $machineUsed, ')
          ..write('pressure: $pressure, ')
          ..write('preInfusionTime: $preInfusionTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, brewId, dose, brewYield, extractionTime,
      machineUsed, pressure, preInfusionTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Espresso &&
          other.id == this.id &&
          other.brewId == this.brewId &&
          other.dose == this.dose &&
          other.brewYield == this.brewYield &&
          other.extractionTime == this.extractionTime &&
          other.machineUsed == this.machineUsed &&
          other.pressure == this.pressure &&
          other.preInfusionTime == this.preInfusionTime);
}

class EspressosCompanion extends UpdateCompanion<Espresso> {
  final Value<int> id;
  final Value<int> brewId;
  final Value<double> dose;
  final Value<double> brewYield;
  final Value<int> extractionTime;
  final Value<String?> machineUsed;
  final Value<double?> pressure;
  final Value<int?> preInfusionTime;
  const EspressosCompanion({
    this.id = const Value.absent(),
    this.brewId = const Value.absent(),
    this.dose = const Value.absent(),
    this.brewYield = const Value.absent(),
    this.extractionTime = const Value.absent(),
    this.machineUsed = const Value.absent(),
    this.pressure = const Value.absent(),
    this.preInfusionTime = const Value.absent(),
  });
  EspressosCompanion.insert({
    this.id = const Value.absent(),
    required int brewId,
    required double dose,
    required double brewYield,
    required int extractionTime,
    this.machineUsed = const Value.absent(),
    this.pressure = const Value.absent(),
    this.preInfusionTime = const Value.absent(),
  })  : brewId = Value(brewId),
        dose = Value(dose),
        brewYield = Value(brewYield),
        extractionTime = Value(extractionTime);
  static Insertable<Espresso> custom({
    Expression<int>? id,
    Expression<int>? brewId,
    Expression<double>? dose,
    Expression<double>? brewYield,
    Expression<int>? extractionTime,
    Expression<String>? machineUsed,
    Expression<double>? pressure,
    Expression<int>? preInfusionTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brewId != null) 'brew_id': brewId,
      if (dose != null) 'dose': dose,
      if (brewYield != null) 'brew_yield': brewYield,
      if (extractionTime != null) 'extraction_time': extractionTime,
      if (machineUsed != null) 'machine_used': machineUsed,
      if (pressure != null) 'pressure': pressure,
      if (preInfusionTime != null) 'pre_infusion_time': preInfusionTime,
    });
  }

  EspressosCompanion copyWith(
      {Value<int>? id,
      Value<int>? brewId,
      Value<double>? dose,
      Value<double>? brewYield,
      Value<int>? extractionTime,
      Value<String?>? machineUsed,
      Value<double?>? pressure,
      Value<int?>? preInfusionTime}) {
    return EspressosCompanion(
      id: id ?? this.id,
      brewId: brewId ?? this.brewId,
      dose: dose ?? this.dose,
      brewYield: brewYield ?? this.brewYield,
      extractionTime: extractionTime ?? this.extractionTime,
      machineUsed: machineUsed ?? this.machineUsed,
      pressure: pressure ?? this.pressure,
      preInfusionTime: preInfusionTime ?? this.preInfusionTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brewId.present) {
      map['brew_id'] = Variable<int>(brewId.value);
    }
    if (dose.present) {
      map['dose'] = Variable<double>(dose.value);
    }
    if (brewYield.present) {
      map['brew_yield'] = Variable<double>(brewYield.value);
    }
    if (extractionTime.present) {
      map['extraction_time'] = Variable<int>(extractionTime.value);
    }
    if (machineUsed.present) {
      map['machine_used'] = Variable<String>(machineUsed.value);
    }
    if (pressure.present) {
      map['pressure'] = Variable<double>(pressure.value);
    }
    if (preInfusionTime.present) {
      map['pre_infusion_time'] = Variable<int>(preInfusionTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EspressosCompanion(')
          ..write('id: $id, ')
          ..write('brewId: $brewId, ')
          ..write('dose: $dose, ')
          ..write('brewYield: $brewYield, ')
          ..write('extractionTime: $extractionTime, ')
          ..write('machineUsed: $machineUsed, ')
          ..write('pressure: $pressure, ')
          ..write('preInfusionTime: $preInfusionTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BrewsTable brews = $BrewsTable(this);
  late final $PourOversTable pourOvers = $PourOversTable(this);
  late final $EspressosTable espressos = $EspressosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [brews, pourOvers, espressos];
}

typedef $$BrewsTableCreateCompanionBuilder = BrewsCompanion Function({
  Value<int> id,
  required String brewType,
  required String coffeeName,
  Value<String?> origin,
  Value<String?> roaster,
  Value<String?> process,
  Value<String?> roastLevel,
  required double grindSize,
  required double temperature,
  required double coffeeWeight,
  Value<double?> waterWeight,
  required int brewTime,
  required double ratio,
  required int rating,
  Value<String?> notes,
  Value<String?> flavorNotes,
  Value<DateTime> createdAt,
});
typedef $$BrewsTableUpdateCompanionBuilder = BrewsCompanion Function({
  Value<int> id,
  Value<String> brewType,
  Value<String> coffeeName,
  Value<String?> origin,
  Value<String?> roaster,
  Value<String?> process,
  Value<String?> roastLevel,
  Value<double> grindSize,
  Value<double> temperature,
  Value<double> coffeeWeight,
  Value<double?> waterWeight,
  Value<int> brewTime,
  Value<double> ratio,
  Value<int> rating,
  Value<String?> notes,
  Value<String?> flavorNotes,
  Value<DateTime> createdAt,
});

class $$BrewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BrewsTable,
    Brew,
    $$BrewsTableFilterComposer,
    $$BrewsTableOrderingComposer,
    $$BrewsTableCreateCompanionBuilder,
    $$BrewsTableUpdateCompanionBuilder> {
  $$BrewsTableTableManager(_$AppDatabase db, $BrewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BrewsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BrewsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> brewType = const Value.absent(),
            Value<String> coffeeName = const Value.absent(),
            Value<String?> origin = const Value.absent(),
            Value<String?> roaster = const Value.absent(),
            Value<String?> process = const Value.absent(),
            Value<String?> roastLevel = const Value.absent(),
            Value<double> grindSize = const Value.absent(),
            Value<double> temperature = const Value.absent(),
            Value<double> coffeeWeight = const Value.absent(),
            Value<double?> waterWeight = const Value.absent(),
            Value<int> brewTime = const Value.absent(),
            Value<double> ratio = const Value.absent(),
            Value<int> rating = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> flavorNotes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BrewsCompanion(
            id: id,
            brewType: brewType,
            coffeeName: coffeeName,
            origin: origin,
            roaster: roaster,
            process: process,
            roastLevel: roastLevel,
            grindSize: grindSize,
            temperature: temperature,
            coffeeWeight: coffeeWeight,
            waterWeight: waterWeight,
            brewTime: brewTime,
            ratio: ratio,
            rating: rating,
            notes: notes,
            flavorNotes: flavorNotes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String brewType,
            required String coffeeName,
            Value<String?> origin = const Value.absent(),
            Value<String?> roaster = const Value.absent(),
            Value<String?> process = const Value.absent(),
            Value<String?> roastLevel = const Value.absent(),
            required double grindSize,
            required double temperature,
            required double coffeeWeight,
            Value<double?> waterWeight = const Value.absent(),
            required int brewTime,
            required double ratio,
            required int rating,
            Value<String?> notes = const Value.absent(),
            Value<String?> flavorNotes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BrewsCompanion.insert(
            id: id,
            brewType: brewType,
            coffeeName: coffeeName,
            origin: origin,
            roaster: roaster,
            process: process,
            roastLevel: roastLevel,
            grindSize: grindSize,
            temperature: temperature,
            coffeeWeight: coffeeWeight,
            waterWeight: waterWeight,
            brewTime: brewTime,
            ratio: ratio,
            rating: rating,
            notes: notes,
            flavorNotes: flavorNotes,
            createdAt: createdAt,
          ),
        ));
}

class $$BrewsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BrewsTable> {
  $$BrewsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get brewType => $state.composableBuilder(
      column: $state.table.brewType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get coffeeName => $state.composableBuilder(
      column: $state.table.coffeeName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get origin => $state.composableBuilder(
      column: $state.table.origin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get roaster => $state.composableBuilder(
      column: $state.table.roaster,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get process => $state.composableBuilder(
      column: $state.table.process,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get roastLevel => $state.composableBuilder(
      column: $state.table.roastLevel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get grindSize => $state.composableBuilder(
      column: $state.table.grindSize,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get temperature => $state.composableBuilder(
      column: $state.table.temperature,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get coffeeWeight => $state.composableBuilder(
      column: $state.table.coffeeWeight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get waterWeight => $state.composableBuilder(
      column: $state.table.waterWeight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get brewTime => $state.composableBuilder(
      column: $state.table.brewTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get ratio => $state.composableBuilder(
      column: $state.table.ratio,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get rating => $state.composableBuilder(
      column: $state.table.rating,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get flavorNotes => $state.composableBuilder(
      column: $state.table.flavorNotes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter pourOversRefs(
      ComposableFilter Function($$PourOversTableFilterComposer f) f) {
    final $$PourOversTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.pourOvers,
        getReferencedColumn: (t) => t.brewId,
        builder: (joinBuilder, parentComposers) =>
            $$PourOversTableFilterComposer(ComposerState(
                $state.db, $state.db.pourOvers, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter espressosRefs(
      ComposableFilter Function($$EspressosTableFilterComposer f) f) {
    final $$EspressosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.espressos,
        getReferencedColumn: (t) => t.brewId,
        builder: (joinBuilder, parentComposers) =>
            $$EspressosTableFilterComposer(ComposerState(
                $state.db, $state.db.espressos, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$BrewsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BrewsTable> {
  $$BrewsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get brewType => $state.composableBuilder(
      column: $state.table.brewType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get coffeeName => $state.composableBuilder(
      column: $state.table.coffeeName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get origin => $state.composableBuilder(
      column: $state.table.origin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get roaster => $state.composableBuilder(
      column: $state.table.roaster,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get process => $state.composableBuilder(
      column: $state.table.process,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get roastLevel => $state.composableBuilder(
      column: $state.table.roastLevel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get grindSize => $state.composableBuilder(
      column: $state.table.grindSize,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get temperature => $state.composableBuilder(
      column: $state.table.temperature,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get coffeeWeight => $state.composableBuilder(
      column: $state.table.coffeeWeight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get waterWeight => $state.composableBuilder(
      column: $state.table.waterWeight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get brewTime => $state.composableBuilder(
      column: $state.table.brewTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get ratio => $state.composableBuilder(
      column: $state.table.ratio,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get rating => $state.composableBuilder(
      column: $state.table.rating,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get flavorNotes => $state.composableBuilder(
      column: $state.table.flavorNotes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PourOversTableCreateCompanionBuilder = PourOversCompanion Function({
  Value<int> id,
  required int brewId,
  required String brewMethod,
  Value<String?> recipe,
});
typedef $$PourOversTableUpdateCompanionBuilder = PourOversCompanion Function({
  Value<int> id,
  Value<int> brewId,
  Value<String> brewMethod,
  Value<String?> recipe,
});

class $$PourOversTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PourOversTable,
    PourOver,
    $$PourOversTableFilterComposer,
    $$PourOversTableOrderingComposer,
    $$PourOversTableCreateCompanionBuilder,
    $$PourOversTableUpdateCompanionBuilder> {
  $$PourOversTableTableManager(_$AppDatabase db, $PourOversTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PourOversTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PourOversTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> brewId = const Value.absent(),
            Value<String> brewMethod = const Value.absent(),
            Value<String?> recipe = const Value.absent(),
          }) =>
              PourOversCompanion(
            id: id,
            brewId: brewId,
            brewMethod: brewMethod,
            recipe: recipe,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int brewId,
            required String brewMethod,
            Value<String?> recipe = const Value.absent(),
          }) =>
              PourOversCompanion.insert(
            id: id,
            brewId: brewId,
            brewMethod: brewMethod,
            recipe: recipe,
          ),
        ));
}

class $$PourOversTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PourOversTable> {
  $$PourOversTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get brewMethod => $state.composableBuilder(
      column: $state.table.brewMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get recipe => $state.composableBuilder(
      column: $state.table.recipe,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$BrewsTableFilterComposer get brewId {
    final $$BrewsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.brewId,
        referencedTable: $state.db.brews,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$BrewsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.brews, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PourOversTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PourOversTable> {
  $$PourOversTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get brewMethod => $state.composableBuilder(
      column: $state.table.brewMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get recipe => $state.composableBuilder(
      column: $state.table.recipe,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$BrewsTableOrderingComposer get brewId {
    final $$BrewsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.brewId,
        referencedTable: $state.db.brews,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$BrewsTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.brews, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$EspressosTableCreateCompanionBuilder = EspressosCompanion Function({
  Value<int> id,
  required int brewId,
  required double dose,
  required double brewYield,
  required int extractionTime,
  Value<String?> machineUsed,
  Value<double?> pressure,
  Value<int?> preInfusionTime,
});
typedef $$EspressosTableUpdateCompanionBuilder = EspressosCompanion Function({
  Value<int> id,
  Value<int> brewId,
  Value<double> dose,
  Value<double> brewYield,
  Value<int> extractionTime,
  Value<String?> machineUsed,
  Value<double?> pressure,
  Value<int?> preInfusionTime,
});

class $$EspressosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EspressosTable,
    Espresso,
    $$EspressosTableFilterComposer,
    $$EspressosTableOrderingComposer,
    $$EspressosTableCreateCompanionBuilder,
    $$EspressosTableUpdateCompanionBuilder> {
  $$EspressosTableTableManager(_$AppDatabase db, $EspressosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$EspressosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$EspressosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> brewId = const Value.absent(),
            Value<double> dose = const Value.absent(),
            Value<double> brewYield = const Value.absent(),
            Value<int> extractionTime = const Value.absent(),
            Value<String?> machineUsed = const Value.absent(),
            Value<double?> pressure = const Value.absent(),
            Value<int?> preInfusionTime = const Value.absent(),
          }) =>
              EspressosCompanion(
            id: id,
            brewId: brewId,
            dose: dose,
            brewYield: brewYield,
            extractionTime: extractionTime,
            machineUsed: machineUsed,
            pressure: pressure,
            preInfusionTime: preInfusionTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int brewId,
            required double dose,
            required double brewYield,
            required int extractionTime,
            Value<String?> machineUsed = const Value.absent(),
            Value<double?> pressure = const Value.absent(),
            Value<int?> preInfusionTime = const Value.absent(),
          }) =>
              EspressosCompanion.insert(
            id: id,
            brewId: brewId,
            dose: dose,
            brewYield: brewYield,
            extractionTime: extractionTime,
            machineUsed: machineUsed,
            pressure: pressure,
            preInfusionTime: preInfusionTime,
          ),
        ));
}

class $$EspressosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $EspressosTable> {
  $$EspressosTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get dose => $state.composableBuilder(
      column: $state.table.dose,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get brewYield => $state.composableBuilder(
      column: $state.table.brewYield,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get extractionTime => $state.composableBuilder(
      column: $state.table.extractionTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get machineUsed => $state.composableBuilder(
      column: $state.table.machineUsed,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get pressure => $state.composableBuilder(
      column: $state.table.pressure,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get preInfusionTime => $state.composableBuilder(
      column: $state.table.preInfusionTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$BrewsTableFilterComposer get brewId {
    final $$BrewsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.brewId,
        referencedTable: $state.db.brews,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$BrewsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.brews, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$EspressosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $EspressosTable> {
  $$EspressosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get dose => $state.composableBuilder(
      column: $state.table.dose,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get brewYield => $state.composableBuilder(
      column: $state.table.brewYield,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get extractionTime => $state.composableBuilder(
      column: $state.table.extractionTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get machineUsed => $state.composableBuilder(
      column: $state.table.machineUsed,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get pressure => $state.composableBuilder(
      column: $state.table.pressure,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get preInfusionTime => $state.composableBuilder(
      column: $state.table.preInfusionTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$BrewsTableOrderingComposer get brewId {
    final $$BrewsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.brewId,
        referencedTable: $state.db.brews,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$BrewsTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.brews, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BrewsTableTableManager get brews =>
      $$BrewsTableTableManager(_db, _db.brews);
  $$PourOversTableTableManager get pourOvers =>
      $$PourOversTableTableManager(_db, _db.pourOvers);
  $$EspressosTableTableManager get espressos =>
      $$EspressosTableTableManager(_db, _db.espressos);
}
