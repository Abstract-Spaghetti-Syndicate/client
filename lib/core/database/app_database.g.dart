// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VendorTablesTable extends VendorTables
    with TableInfo<$VendorTablesTable, VendorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VendorTablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vendor_tables';
  @override
  VerificationContext validateIntegrity(Insertable<VendorData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VendorData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VendorData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $VendorTablesTable createAlias(String alias) {
    return $VendorTablesTable(attachedDatabase, alias);
  }
}

class VendorData extends DataClass implements Insertable<VendorData> {
  final String id;
  final String name;
  const VendorData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  VendorTablesCompanion toCompanion(bool nullToAbsent) {
    return VendorTablesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory VendorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VendorData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  VendorData copyWith({String? id, String? name}) => VendorData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  VendorData copyWithCompanion(VendorTablesCompanion data) {
    return VendorData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VendorData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VendorData && other.id == this.id && other.name == this.name);
}

class VendorTablesCompanion extends UpdateCompanion<VendorData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const VendorTablesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VendorTablesCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<VendorData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VendorTablesCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return VendorTablesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VendorTablesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FilamentTablesTable extends FilamentTables
    with TableInfo<$FilamentTablesTable, FilamentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilamentTablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vendorIdMeta =
      const VerificationMeta('vendorId');
  @override
  late final GeneratedColumn<String> vendorId = GeneratedColumn<String>(
      'vendor_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES vendor_tables(id) ON DELETE CASCADE');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _materialMeta =
      const VerificationMeta('material');
  @override
  late final GeneratedColumn<String> material = GeneratedColumn<String>(
      'material', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _diameterMeta =
      const VerificationMeta('diameter');
  @override
  late final GeneratedColumn<double> diameter = GeneratedColumn<double>(
      'diameter', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.75));
  static const VerificationMeta _peakExtruderTempMeta =
      const VerificationMeta('peakExtruderTemp');
  @override
  late final GeneratedColumn<int> peakExtruderTemp = GeneratedColumn<int>(
      'peak_extruder_temp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(210));
  static const VerificationMeta _peakBedTempMeta =
      const VerificationMeta('peakBedTemp');
  @override
  late final GeneratedColumn<int> peakBedTemp = GeneratedColumn<int>(
      'peak_bed_temp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(60));
  static const VerificationMeta _densityMeta =
      const VerificationMeta('density');
  @override
  late final GeneratedColumn<double> density = GeneratedColumn<double>(
      'density', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.24));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        vendorId,
        name,
        material,
        colorHex,
        diameter,
        peakExtruderTemp,
        peakBedTemp,
        density
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'filament_tables';
  @override
  VerificationContext validateIntegrity(Insertable<FilamentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vendor_id')) {
      context.handle(_vendorIdMeta,
          vendorId.isAcceptableOrUnknown(data['vendor_id']!, _vendorIdMeta));
    } else if (isInserting) {
      context.missing(_vendorIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('material')) {
      context.handle(_materialMeta,
          material.isAcceptableOrUnknown(data['material']!, _materialMeta));
    } else if (isInserting) {
      context.missing(_materialMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    if (data.containsKey('diameter')) {
      context.handle(_diameterMeta,
          diameter.isAcceptableOrUnknown(data['diameter']!, _diameterMeta));
    }
    if (data.containsKey('peak_extruder_temp')) {
      context.handle(
          _peakExtruderTempMeta,
          peakExtruderTemp.isAcceptableOrUnknown(
              data['peak_extruder_temp']!, _peakExtruderTempMeta));
    }
    if (data.containsKey('peak_bed_temp')) {
      context.handle(
          _peakBedTempMeta,
          peakBedTemp.isAcceptableOrUnknown(
              data['peak_bed_temp']!, _peakBedTempMeta));
    }
    if (data.containsKey('density')) {
      context.handle(_densityMeta,
          density.isAcceptableOrUnknown(data['density']!, _densityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FilamentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilamentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      vendorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vendor_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      material: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}material'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      diameter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}diameter'])!,
      peakExtruderTemp: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}peak_extruder_temp'])!,
      peakBedTemp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}peak_bed_temp'])!,
      density: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}density'])!,
    );
  }

  @override
  $FilamentTablesTable createAlias(String alias) {
    return $FilamentTablesTable(attachedDatabase, alias);
  }
}

class FilamentData extends DataClass implements Insertable<FilamentData> {
  final String id;
  final String vendorId;
  final String name;
  final String material;
  final String colorHex;
  final double diameter;
  final int peakExtruderTemp;
  final int peakBedTemp;
  final double density;
  const FilamentData(
      {required this.id,
      required this.vendorId,
      required this.name,
      required this.material,
      required this.colorHex,
      required this.diameter,
      required this.peakExtruderTemp,
      required this.peakBedTemp,
      required this.density});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vendor_id'] = Variable<String>(vendorId);
    map['name'] = Variable<String>(name);
    map['material'] = Variable<String>(material);
    map['color_hex'] = Variable<String>(colorHex);
    map['diameter'] = Variable<double>(diameter);
    map['peak_extruder_temp'] = Variable<int>(peakExtruderTemp);
    map['peak_bed_temp'] = Variable<int>(peakBedTemp);
    map['density'] = Variable<double>(density);
    return map;
  }

  FilamentTablesCompanion toCompanion(bool nullToAbsent) {
    return FilamentTablesCompanion(
      id: Value(id),
      vendorId: Value(vendorId),
      name: Value(name),
      material: Value(material),
      colorHex: Value(colorHex),
      diameter: Value(diameter),
      peakExtruderTemp: Value(peakExtruderTemp),
      peakBedTemp: Value(peakBedTemp),
      density: Value(density),
    );
  }

  factory FilamentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilamentData(
      id: serializer.fromJson<String>(json['id']),
      vendorId: serializer.fromJson<String>(json['vendorId']),
      name: serializer.fromJson<String>(json['name']),
      material: serializer.fromJson<String>(json['material']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      diameter: serializer.fromJson<double>(json['diameter']),
      peakExtruderTemp: serializer.fromJson<int>(json['peakExtruderTemp']),
      peakBedTemp: serializer.fromJson<int>(json['peakBedTemp']),
      density: serializer.fromJson<double>(json['density']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vendorId': serializer.toJson<String>(vendorId),
      'name': serializer.toJson<String>(name),
      'material': serializer.toJson<String>(material),
      'colorHex': serializer.toJson<String>(colorHex),
      'diameter': serializer.toJson<double>(diameter),
      'peakExtruderTemp': serializer.toJson<int>(peakExtruderTemp),
      'peakBedTemp': serializer.toJson<int>(peakBedTemp),
      'density': serializer.toJson<double>(density),
    };
  }

  FilamentData copyWith(
          {String? id,
          String? vendorId,
          String? name,
          String? material,
          String? colorHex,
          double? diameter,
          int? peakExtruderTemp,
          int? peakBedTemp,
          double? density}) =>
      FilamentData(
        id: id ?? this.id,
        vendorId: vendorId ?? this.vendorId,
        name: name ?? this.name,
        material: material ?? this.material,
        colorHex: colorHex ?? this.colorHex,
        diameter: diameter ?? this.diameter,
        peakExtruderTemp: peakExtruderTemp ?? this.peakExtruderTemp,
        peakBedTemp: peakBedTemp ?? this.peakBedTemp,
        density: density ?? this.density,
      );
  FilamentData copyWithCompanion(FilamentTablesCompanion data) {
    return FilamentData(
      id: data.id.present ? data.id.value : this.id,
      vendorId: data.vendorId.present ? data.vendorId.value : this.vendorId,
      name: data.name.present ? data.name.value : this.name,
      material: data.material.present ? data.material.value : this.material,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      diameter: data.diameter.present ? data.diameter.value : this.diameter,
      peakExtruderTemp: data.peakExtruderTemp.present
          ? data.peakExtruderTemp.value
          : this.peakExtruderTemp,
      peakBedTemp:
          data.peakBedTemp.present ? data.peakBedTemp.value : this.peakBedTemp,
      density: data.density.present ? data.density.value : this.density,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilamentData(')
          ..write('id: $id, ')
          ..write('vendorId: $vendorId, ')
          ..write('name: $name, ')
          ..write('material: $material, ')
          ..write('colorHex: $colorHex, ')
          ..write('diameter: $diameter, ')
          ..write('peakExtruderTemp: $peakExtruderTemp, ')
          ..write('peakBedTemp: $peakBedTemp, ')
          ..write('density: $density')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, vendorId, name, material, colorHex,
      diameter, peakExtruderTemp, peakBedTemp, density);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilamentData &&
          other.id == this.id &&
          other.vendorId == this.vendorId &&
          other.name == this.name &&
          other.material == this.material &&
          other.colorHex == this.colorHex &&
          other.diameter == this.diameter &&
          other.peakExtruderTemp == this.peakExtruderTemp &&
          other.peakBedTemp == this.peakBedTemp &&
          other.density == this.density);
}

class FilamentTablesCompanion extends UpdateCompanion<FilamentData> {
  final Value<String> id;
  final Value<String> vendorId;
  final Value<String> name;
  final Value<String> material;
  final Value<String> colorHex;
  final Value<double> diameter;
  final Value<int> peakExtruderTemp;
  final Value<int> peakBedTemp;
  final Value<double> density;
  final Value<int> rowid;
  const FilamentTablesCompanion({
    this.id = const Value.absent(),
    this.vendorId = const Value.absent(),
    this.name = const Value.absent(),
    this.material = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.diameter = const Value.absent(),
    this.peakExtruderTemp = const Value.absent(),
    this.peakBedTemp = const Value.absent(),
    this.density = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FilamentTablesCompanion.insert({
    required String id,
    required String vendorId,
    required String name,
    required String material,
    required String colorHex,
    this.diameter = const Value.absent(),
    this.peakExtruderTemp = const Value.absent(),
    this.peakBedTemp = const Value.absent(),
    this.density = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        vendorId = Value(vendorId),
        name = Value(name),
        material = Value(material),
        colorHex = Value(colorHex);
  static Insertable<FilamentData> custom({
    Expression<String>? id,
    Expression<String>? vendorId,
    Expression<String>? name,
    Expression<String>? material,
    Expression<String>? colorHex,
    Expression<double>? diameter,
    Expression<int>? peakExtruderTemp,
    Expression<int>? peakBedTemp,
    Expression<double>? density,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vendorId != null) 'vendor_id': vendorId,
      if (name != null) 'name': name,
      if (material != null) 'material': material,
      if (colorHex != null) 'color_hex': colorHex,
      if (diameter != null) 'diameter': diameter,
      if (peakExtruderTemp != null) 'peak_extruder_temp': peakExtruderTemp,
      if (peakBedTemp != null) 'peak_bed_temp': peakBedTemp,
      if (density != null) 'density': density,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FilamentTablesCompanion copyWith(
      {Value<String>? id,
      Value<String>? vendorId,
      Value<String>? name,
      Value<String>? material,
      Value<String>? colorHex,
      Value<double>? diameter,
      Value<int>? peakExtruderTemp,
      Value<int>? peakBedTemp,
      Value<double>? density,
      Value<int>? rowid}) {
    return FilamentTablesCompanion(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      material: material ?? this.material,
      colorHex: colorHex ?? this.colorHex,
      diameter: diameter ?? this.diameter,
      peakExtruderTemp: peakExtruderTemp ?? this.peakExtruderTemp,
      peakBedTemp: peakBedTemp ?? this.peakBedTemp,
      density: density ?? this.density,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vendorId.present) {
      map['vendor_id'] = Variable<String>(vendorId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (diameter.present) {
      map['diameter'] = Variable<double>(diameter.value);
    }
    if (peakExtruderTemp.present) {
      map['peak_extruder_temp'] = Variable<int>(peakExtruderTemp.value);
    }
    if (peakBedTemp.present) {
      map['peak_bed_temp'] = Variable<int>(peakBedTemp.value);
    }
    if (density.present) {
      map['density'] = Variable<double>(density.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilamentTablesCompanion(')
          ..write('id: $id, ')
          ..write('vendorId: $vendorId, ')
          ..write('name: $name, ')
          ..write('material: $material, ')
          ..write('colorHex: $colorHex, ')
          ..write('diameter: $diameter, ')
          ..write('peakExtruderTemp: $peakExtruderTemp, ')
          ..write('peakBedTemp: $peakBedTemp, ')
          ..write('density: $density, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpoolTablesTable extends SpoolTables
    with TableInfo<$SpoolTablesTable, SpoolData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpoolTablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filamentIdMeta =
      const VerificationMeta('filamentId');
  @override
  late final GeneratedColumn<String> filamentId = GeneratedColumn<String>(
      'filament_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES filament_tables(id) ON DELETE CASCADE');
  static const VerificationMeta _weightTotalMeta =
      const VerificationMeta('weightTotal');
  @override
  late final GeneratedColumn<double> weightTotal = GeneratedColumn<double>(
      'weight_total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weightUsedMeta =
      const VerificationMeta('weightUsed');
  @override
  late final GeneratedColumn<double> weightUsed = GeneratedColumn<double>(
      'weight_used', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, filamentId, weightTotal, weightUsed, locationId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spool_tables';
  @override
  VerificationContext validateIntegrity(Insertable<SpoolData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('filament_id')) {
      context.handle(
          _filamentIdMeta,
          filamentId.isAcceptableOrUnknown(
              data['filament_id']!, _filamentIdMeta));
    } else if (isInserting) {
      context.missing(_filamentIdMeta);
    }
    if (data.containsKey('weight_total')) {
      context.handle(
          _weightTotalMeta,
          weightTotal.isAcceptableOrUnknown(
              data['weight_total']!, _weightTotalMeta));
    } else if (isInserting) {
      context.missing(_weightTotalMeta);
    }
    if (data.containsKey('weight_used')) {
      context.handle(
          _weightUsedMeta,
          weightUsed.isAcceptableOrUnknown(
              data['weight_used']!, _weightUsedMeta));
    } else if (isInserting) {
      context.missing(_weightUsedMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpoolData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpoolData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      filamentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filament_id'])!,
      weightTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_total'])!,
      weightUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_used'])!,
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id']),
    );
  }

  @override
  $SpoolTablesTable createAlias(String alias) {
    return $SpoolTablesTable(attachedDatabase, alias);
  }
}

class SpoolData extends DataClass implements Insertable<SpoolData> {
  final String id;
  final String filamentId;
  final double weightTotal;
  final double weightUsed;
  final String? locationId;
  const SpoolData(
      {required this.id,
      required this.filamentId,
      required this.weightTotal,
      required this.weightUsed,
      this.locationId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['filament_id'] = Variable<String>(filamentId);
    map['weight_total'] = Variable<double>(weightTotal);
    map['weight_used'] = Variable<double>(weightUsed);
    if (!nullToAbsent || locationId != null) {
      map['location_id'] = Variable<String>(locationId);
    }
    return map;
  }

  SpoolTablesCompanion toCompanion(bool nullToAbsent) {
    return SpoolTablesCompanion(
      id: Value(id),
      filamentId: Value(filamentId),
      weightTotal: Value(weightTotal),
      weightUsed: Value(weightUsed),
      locationId: locationId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationId),
    );
  }

  factory SpoolData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpoolData(
      id: serializer.fromJson<String>(json['id']),
      filamentId: serializer.fromJson<String>(json['filamentId']),
      weightTotal: serializer.fromJson<double>(json['weightTotal']),
      weightUsed: serializer.fromJson<double>(json['weightUsed']),
      locationId: serializer.fromJson<String?>(json['locationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'filamentId': serializer.toJson<String>(filamentId),
      'weightTotal': serializer.toJson<double>(weightTotal),
      'weightUsed': serializer.toJson<double>(weightUsed),
      'locationId': serializer.toJson<String?>(locationId),
    };
  }

  SpoolData copyWith(
          {String? id,
          String? filamentId,
          double? weightTotal,
          double? weightUsed,
          Value<String?> locationId = const Value.absent()}) =>
      SpoolData(
        id: id ?? this.id,
        filamentId: filamentId ?? this.filamentId,
        weightTotal: weightTotal ?? this.weightTotal,
        weightUsed: weightUsed ?? this.weightUsed,
        locationId: locationId.present ? locationId.value : this.locationId,
      );
  SpoolData copyWithCompanion(SpoolTablesCompanion data) {
    return SpoolData(
      id: data.id.present ? data.id.value : this.id,
      filamentId:
          data.filamentId.present ? data.filamentId.value : this.filamentId,
      weightTotal:
          data.weightTotal.present ? data.weightTotal.value : this.weightTotal,
      weightUsed:
          data.weightUsed.present ? data.weightUsed.value : this.weightUsed,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpoolData(')
          ..write('id: $id, ')
          ..write('filamentId: $filamentId, ')
          ..write('weightTotal: $weightTotal, ')
          ..write('weightUsed: $weightUsed, ')
          ..write('locationId: $locationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, filamentId, weightTotal, weightUsed, locationId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpoolData &&
          other.id == this.id &&
          other.filamentId == this.filamentId &&
          other.weightTotal == this.weightTotal &&
          other.weightUsed == this.weightUsed &&
          other.locationId == this.locationId);
}

class SpoolTablesCompanion extends UpdateCompanion<SpoolData> {
  final Value<String> id;
  final Value<String> filamentId;
  final Value<double> weightTotal;
  final Value<double> weightUsed;
  final Value<String?> locationId;
  final Value<int> rowid;
  const SpoolTablesCompanion({
    this.id = const Value.absent(),
    this.filamentId = const Value.absent(),
    this.weightTotal = const Value.absent(),
    this.weightUsed = const Value.absent(),
    this.locationId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpoolTablesCompanion.insert({
    required String id,
    required String filamentId,
    required double weightTotal,
    required double weightUsed,
    this.locationId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        filamentId = Value(filamentId),
        weightTotal = Value(weightTotal),
        weightUsed = Value(weightUsed);
  static Insertable<SpoolData> custom({
    Expression<String>? id,
    Expression<String>? filamentId,
    Expression<double>? weightTotal,
    Expression<double>? weightUsed,
    Expression<String>? locationId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filamentId != null) 'filament_id': filamentId,
      if (weightTotal != null) 'weight_total': weightTotal,
      if (weightUsed != null) 'weight_used': weightUsed,
      if (locationId != null) 'location_id': locationId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpoolTablesCompanion copyWith(
      {Value<String>? id,
      Value<String>? filamentId,
      Value<double>? weightTotal,
      Value<double>? weightUsed,
      Value<String?>? locationId,
      Value<int>? rowid}) {
    return SpoolTablesCompanion(
      id: id ?? this.id,
      filamentId: filamentId ?? this.filamentId,
      weightTotal: weightTotal ?? this.weightTotal,
      weightUsed: weightUsed ?? this.weightUsed,
      locationId: locationId ?? this.locationId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (filamentId.present) {
      map['filament_id'] = Variable<String>(filamentId.value);
    }
    if (weightTotal.present) {
      map['weight_total'] = Variable<double>(weightTotal.value);
    }
    if (weightUsed.present) {
      map['weight_used'] = Variable<double>(weightUsed.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpoolTablesCompanion(')
          ..write('id: $id, ')
          ..write('filamentId: $filamentId, ')
          ..write('weightTotal: $weightTotal, ')
          ..write('weightUsed: $weightUsed, ')
          ..write('locationId: $locationId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VendorTablesTable vendorTables = $VendorTablesTable(this);
  late final $FilamentTablesTable filamentTables = $FilamentTablesTable(this);
  late final $SpoolTablesTable spoolTables = $SpoolTablesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [vendorTables, filamentTables, spoolTables];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('vendor_tables',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('filament_tables', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('filament_tables',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('spool_tables', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$VendorTablesTableCreateCompanionBuilder = VendorTablesCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$VendorTablesTableUpdateCompanionBuilder = VendorTablesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$VendorTablesTableReferences
    extends BaseReferences<_$AppDatabase, $VendorTablesTable, VendorData> {
  $$VendorTablesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FilamentTablesTable, List<FilamentData>>
      _filamentTablesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.filamentTables,
              aliasName: $_aliasNameGenerator(
                  db.vendorTables.id, db.filamentTables.vendorId));

  $$FilamentTablesTableProcessedTableManager get filamentTablesRefs {
    final manager = $$FilamentTablesTableTableManager($_db, $_db.filamentTables)
        .filter((f) => f.vendorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_filamentTablesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VendorTablesTableFilterComposer
    extends Composer<_$AppDatabase, $VendorTablesTable> {
  $$VendorTablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> filamentTablesRefs(
      Expression<bool> Function($$FilamentTablesTableFilterComposer f) f) {
    final $$FilamentTablesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.filamentTables,
        getReferencedColumn: (t) => t.vendorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilamentTablesTableFilterComposer(
              $db: $db,
              $table: $db.filamentTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VendorTablesTableOrderingComposer
    extends Composer<_$AppDatabase, $VendorTablesTable> {
  $$VendorTablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$VendorTablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VendorTablesTable> {
  $$VendorTablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> filamentTablesRefs<T extends Object>(
      Expression<T> Function($$FilamentTablesTableAnnotationComposer a) f) {
    final $$FilamentTablesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.filamentTables,
        getReferencedColumn: (t) => t.vendorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilamentTablesTableAnnotationComposer(
              $db: $db,
              $table: $db.filamentTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VendorTablesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VendorTablesTable,
    VendorData,
    $$VendorTablesTableFilterComposer,
    $$VendorTablesTableOrderingComposer,
    $$VendorTablesTableAnnotationComposer,
    $$VendorTablesTableCreateCompanionBuilder,
    $$VendorTablesTableUpdateCompanionBuilder,
    (VendorData, $$VendorTablesTableReferences),
    VendorData,
    PrefetchHooks Function({bool filamentTablesRefs})> {
  $$VendorTablesTableTableManager(_$AppDatabase db, $VendorTablesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VendorTablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VendorTablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VendorTablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VendorTablesCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              VendorTablesCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$VendorTablesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({filamentTablesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (filamentTablesRefs) db.filamentTables
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (filamentTablesRefs)
                    await $_getPrefetchedData<VendorData, $VendorTablesTable,
                            FilamentData>(
                        currentTable: table,
                        referencedTable: $$VendorTablesTableReferences
                            ._filamentTablesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VendorTablesTableReferences(db, table, p0)
                                .filamentTablesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.vendorId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VendorTablesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VendorTablesTable,
    VendorData,
    $$VendorTablesTableFilterComposer,
    $$VendorTablesTableOrderingComposer,
    $$VendorTablesTableAnnotationComposer,
    $$VendorTablesTableCreateCompanionBuilder,
    $$VendorTablesTableUpdateCompanionBuilder,
    (VendorData, $$VendorTablesTableReferences),
    VendorData,
    PrefetchHooks Function({bool filamentTablesRefs})>;
typedef $$FilamentTablesTableCreateCompanionBuilder = FilamentTablesCompanion
    Function({
  required String id,
  required String vendorId,
  required String name,
  required String material,
  required String colorHex,
  Value<double> diameter,
  Value<int> peakExtruderTemp,
  Value<int> peakBedTemp,
  Value<double> density,
  Value<int> rowid,
});
typedef $$FilamentTablesTableUpdateCompanionBuilder = FilamentTablesCompanion
    Function({
  Value<String> id,
  Value<String> vendorId,
  Value<String> name,
  Value<String> material,
  Value<String> colorHex,
  Value<double> diameter,
  Value<int> peakExtruderTemp,
  Value<int> peakBedTemp,
  Value<double> density,
  Value<int> rowid,
});

final class $$FilamentTablesTableReferences
    extends BaseReferences<_$AppDatabase, $FilamentTablesTable, FilamentData> {
  $$FilamentTablesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $VendorTablesTable _vendorIdTable(_$AppDatabase db) =>
      db.vendorTables.createAlias(
          $_aliasNameGenerator(db.filamentTables.vendorId, db.vendorTables.id));

  $$VendorTablesTableProcessedTableManager get vendorId {
    final $_column = $_itemColumn<String>('vendor_id')!;

    final manager = $$VendorTablesTableTableManager($_db, $_db.vendorTables)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vendorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SpoolTablesTable, List<SpoolData>>
      _spoolTablesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.spoolTables,
              aliasName: $_aliasNameGenerator(
                  db.filamentTables.id, db.spoolTables.filamentId));

  $$SpoolTablesTableProcessedTableManager get spoolTablesRefs {
    final manager = $$SpoolTablesTableTableManager($_db, $_db.spoolTables)
        .filter((f) => f.filamentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_spoolTablesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FilamentTablesTableFilterComposer
    extends Composer<_$AppDatabase, $FilamentTablesTable> {
  $$FilamentTablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get material => $composableBuilder(
      column: $table.material, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get diameter => $composableBuilder(
      column: $table.diameter, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get peakExtruderTemp => $composableBuilder(
      column: $table.peakExtruderTemp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get peakBedTemp => $composableBuilder(
      column: $table.peakBedTemp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get density => $composableBuilder(
      column: $table.density, builder: (column) => ColumnFilters(column));

  $$VendorTablesTableFilterComposer get vendorId {
    final $$VendorTablesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vendorId,
        referencedTable: $db.vendorTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VendorTablesTableFilterComposer(
              $db: $db,
              $table: $db.vendorTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> spoolTablesRefs(
      Expression<bool> Function($$SpoolTablesTableFilterComposer f) f) {
    final $$SpoolTablesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.spoolTables,
        getReferencedColumn: (t) => t.filamentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SpoolTablesTableFilterComposer(
              $db: $db,
              $table: $db.spoolTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FilamentTablesTableOrderingComposer
    extends Composer<_$AppDatabase, $FilamentTablesTable> {
  $$FilamentTablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get material => $composableBuilder(
      column: $table.material, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get diameter => $composableBuilder(
      column: $table.diameter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get peakExtruderTemp => $composableBuilder(
      column: $table.peakExtruderTemp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get peakBedTemp => $composableBuilder(
      column: $table.peakBedTemp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get density => $composableBuilder(
      column: $table.density, builder: (column) => ColumnOrderings(column));

  $$VendorTablesTableOrderingComposer get vendorId {
    final $$VendorTablesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vendorId,
        referencedTable: $db.vendorTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VendorTablesTableOrderingComposer(
              $db: $db,
              $table: $db.vendorTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FilamentTablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FilamentTablesTable> {
  $$FilamentTablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get material =>
      $composableBuilder(column: $table.material, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<double> get diameter =>
      $composableBuilder(column: $table.diameter, builder: (column) => column);

  GeneratedColumn<int> get peakExtruderTemp => $composableBuilder(
      column: $table.peakExtruderTemp, builder: (column) => column);

  GeneratedColumn<int> get peakBedTemp => $composableBuilder(
      column: $table.peakBedTemp, builder: (column) => column);

  GeneratedColumn<double> get density =>
      $composableBuilder(column: $table.density, builder: (column) => column);

  $$VendorTablesTableAnnotationComposer get vendorId {
    final $$VendorTablesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vendorId,
        referencedTable: $db.vendorTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VendorTablesTableAnnotationComposer(
              $db: $db,
              $table: $db.vendorTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> spoolTablesRefs<T extends Object>(
      Expression<T> Function($$SpoolTablesTableAnnotationComposer a) f) {
    final $$SpoolTablesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.spoolTables,
        getReferencedColumn: (t) => t.filamentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SpoolTablesTableAnnotationComposer(
              $db: $db,
              $table: $db.spoolTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FilamentTablesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FilamentTablesTable,
    FilamentData,
    $$FilamentTablesTableFilterComposer,
    $$FilamentTablesTableOrderingComposer,
    $$FilamentTablesTableAnnotationComposer,
    $$FilamentTablesTableCreateCompanionBuilder,
    $$FilamentTablesTableUpdateCompanionBuilder,
    (FilamentData, $$FilamentTablesTableReferences),
    FilamentData,
    PrefetchHooks Function({bool vendorId, bool spoolTablesRefs})> {
  $$FilamentTablesTableTableManager(
      _$AppDatabase db, $FilamentTablesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilamentTablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilamentTablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilamentTablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> vendorId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> material = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<double> diameter = const Value.absent(),
            Value<int> peakExtruderTemp = const Value.absent(),
            Value<int> peakBedTemp = const Value.absent(),
            Value<double> density = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FilamentTablesCompanion(
            id: id,
            vendorId: vendorId,
            name: name,
            material: material,
            colorHex: colorHex,
            diameter: diameter,
            peakExtruderTemp: peakExtruderTemp,
            peakBedTemp: peakBedTemp,
            density: density,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String vendorId,
            required String name,
            required String material,
            required String colorHex,
            Value<double> diameter = const Value.absent(),
            Value<int> peakExtruderTemp = const Value.absent(),
            Value<int> peakBedTemp = const Value.absent(),
            Value<double> density = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FilamentTablesCompanion.insert(
            id: id,
            vendorId: vendorId,
            name: name,
            material: material,
            colorHex: colorHex,
            diameter: diameter,
            peakExtruderTemp: peakExtruderTemp,
            peakBedTemp: peakBedTemp,
            density: density,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FilamentTablesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({vendorId = false, spoolTablesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (spoolTablesRefs) db.spoolTables],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (vendorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.vendorId,
                    referencedTable:
                        $$FilamentTablesTableReferences._vendorIdTable(db),
                    referencedColumn:
                        $$FilamentTablesTableReferences._vendorIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (spoolTablesRefs)
                    await $_getPrefetchedData<FilamentData,
                            $FilamentTablesTable, SpoolData>(
                        currentTable: table,
                        referencedTable: $$FilamentTablesTableReferences
                            ._spoolTablesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FilamentTablesTableReferences(db, table, p0)
                                .spoolTablesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.filamentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FilamentTablesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FilamentTablesTable,
    FilamentData,
    $$FilamentTablesTableFilterComposer,
    $$FilamentTablesTableOrderingComposer,
    $$FilamentTablesTableAnnotationComposer,
    $$FilamentTablesTableCreateCompanionBuilder,
    $$FilamentTablesTableUpdateCompanionBuilder,
    (FilamentData, $$FilamentTablesTableReferences),
    FilamentData,
    PrefetchHooks Function({bool vendorId, bool spoolTablesRefs})>;
typedef $$SpoolTablesTableCreateCompanionBuilder = SpoolTablesCompanion
    Function({
  required String id,
  required String filamentId,
  required double weightTotal,
  required double weightUsed,
  Value<String?> locationId,
  Value<int> rowid,
});
typedef $$SpoolTablesTableUpdateCompanionBuilder = SpoolTablesCompanion
    Function({
  Value<String> id,
  Value<String> filamentId,
  Value<double> weightTotal,
  Value<double> weightUsed,
  Value<String?> locationId,
  Value<int> rowid,
});

final class $$SpoolTablesTableReferences
    extends BaseReferences<_$AppDatabase, $SpoolTablesTable, SpoolData> {
  $$SpoolTablesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FilamentTablesTable _filamentIdTable(_$AppDatabase db) =>
      db.filamentTables.createAlias($_aliasNameGenerator(
          db.spoolTables.filamentId, db.filamentTables.id));

  $$FilamentTablesTableProcessedTableManager get filamentId {
    final $_column = $_itemColumn<String>('filament_id')!;

    final manager = $$FilamentTablesTableTableManager($_db, $_db.filamentTables)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_filamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SpoolTablesTableFilterComposer
    extends Composer<_$AppDatabase, $SpoolTablesTable> {
  $$SpoolTablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightTotal => $composableBuilder(
      column: $table.weightTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightUsed => $composableBuilder(
      column: $table.weightUsed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnFilters(column));

  $$FilamentTablesTableFilterComposer get filamentId {
    final $$FilamentTablesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.filamentId,
        referencedTable: $db.filamentTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilamentTablesTableFilterComposer(
              $db: $db,
              $table: $db.filamentTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SpoolTablesTableOrderingComposer
    extends Composer<_$AppDatabase, $SpoolTablesTable> {
  $$SpoolTablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightTotal => $composableBuilder(
      column: $table.weightTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightUsed => $composableBuilder(
      column: $table.weightUsed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnOrderings(column));

  $$FilamentTablesTableOrderingComposer get filamentId {
    final $$FilamentTablesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.filamentId,
        referencedTable: $db.filamentTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilamentTablesTableOrderingComposer(
              $db: $db,
              $table: $db.filamentTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SpoolTablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpoolTablesTable> {
  $$SpoolTablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get weightTotal => $composableBuilder(
      column: $table.weightTotal, builder: (column) => column);

  GeneratedColumn<double> get weightUsed => $composableBuilder(
      column: $table.weightUsed, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => column);

  $$FilamentTablesTableAnnotationComposer get filamentId {
    final $$FilamentTablesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.filamentId,
        referencedTable: $db.filamentTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FilamentTablesTableAnnotationComposer(
              $db: $db,
              $table: $db.filamentTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SpoolTablesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SpoolTablesTable,
    SpoolData,
    $$SpoolTablesTableFilterComposer,
    $$SpoolTablesTableOrderingComposer,
    $$SpoolTablesTableAnnotationComposer,
    $$SpoolTablesTableCreateCompanionBuilder,
    $$SpoolTablesTableUpdateCompanionBuilder,
    (SpoolData, $$SpoolTablesTableReferences),
    SpoolData,
    PrefetchHooks Function({bool filamentId})> {
  $$SpoolTablesTableTableManager(_$AppDatabase db, $SpoolTablesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpoolTablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpoolTablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpoolTablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> filamentId = const Value.absent(),
            Value<double> weightTotal = const Value.absent(),
            Value<double> weightUsed = const Value.absent(),
            Value<String?> locationId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SpoolTablesCompanion(
            id: id,
            filamentId: filamentId,
            weightTotal: weightTotal,
            weightUsed: weightUsed,
            locationId: locationId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String filamentId,
            required double weightTotal,
            required double weightUsed,
            Value<String?> locationId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SpoolTablesCompanion.insert(
            id: id,
            filamentId: filamentId,
            weightTotal: weightTotal,
            weightUsed: weightUsed,
            locationId: locationId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SpoolTablesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({filamentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (filamentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.filamentId,
                    referencedTable:
                        $$SpoolTablesTableReferences._filamentIdTable(db),
                    referencedColumn:
                        $$SpoolTablesTableReferences._filamentIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SpoolTablesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SpoolTablesTable,
    SpoolData,
    $$SpoolTablesTableFilterComposer,
    $$SpoolTablesTableOrderingComposer,
    $$SpoolTablesTableAnnotationComposer,
    $$SpoolTablesTableCreateCompanionBuilder,
    $$SpoolTablesTableUpdateCompanionBuilder,
    (SpoolData, $$SpoolTablesTableReferences),
    SpoolData,
    PrefetchHooks Function({bool filamentId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VendorTablesTableTableManager get vendorTables =>
      $$VendorTablesTableTableManager(_db, _db.vendorTables);
  $$FilamentTablesTableTableManager get filamentTables =>
      $$FilamentTablesTableTableManager(_db, _db.filamentTables);
  $$SpoolTablesTableTableManager get spoolTables =>
      $$SpoolTablesTableTableManager(_db, _db.spoolTables);
}
