// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteModelAdapter extends TypeAdapter<QuoteModel> {
  @override
  final int typeId = 4;

  @override
  QuoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuoteModel(
      id: fields[0] as String,
      quoteNumber: fields[1] as String,
      date: fields[2] as DateTime,
      expiryDate: fields[3] as DateTime,
      client: fields[4] as ClientModel,
      products: (fields[5] as List).cast<ProductModel>(),
      terms: fields[6] as TermsModel,
      discount: fields[7] as double,
      tax: fields[8] as double,
      totalAmount: fields[9] as double,
      title: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuoteModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.quoteNumber)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.client)
      ..writeByte(5)
      ..write(obj.products)
      ..writeByte(6)
      ..write(obj.terms)
      ..writeByte(7)
      ..write(obj.discount)
      ..writeByte(8)
      ..write(obj.tax)
      ..writeByte(9)
      ..write(obj.totalAmount)
      ..writeByte(10)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
