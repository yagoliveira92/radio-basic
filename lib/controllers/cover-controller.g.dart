// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover-controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CoverController on _CoverControllerBase, Store {
  final _$coverAlbumAtom = Atom(name: '_CoverControllerBase.coverAlbum');

  @override
  String get coverAlbum {
    _$coverAlbumAtom.reportRead();
    return super.coverAlbum;
  }

  @override
  set coverAlbum(String value) {
    _$coverAlbumAtom.reportWrite(value, super.coverAlbum, () {
      super.coverAlbum = value;
    });
  }

  final _$artistNameAtom = Atom(name: '_CoverControllerBase.artistName');

  @override
  String get artistName {
    _$artistNameAtom.reportRead();
    return super.artistName;
  }

  @override
  set artistName(String value) {
    _$artistNameAtom.reportWrite(value, super.artistName, () {
      super.artistName = value;
    });
  }

  final _$musicNameAtom = Atom(name: '_CoverControllerBase.musicName');

  @override
  String get musicName {
    _$musicNameAtom.reportRead();
    return super.musicName;
  }

  @override
  set musicName(String value) {
    _$musicNameAtom.reportWrite(value, super.musicName, () {
      super.musicName = value;
    });
  }

  final _$getMetadataAsyncAction =
      AsyncAction('_CoverControllerBase.getMetadata');

  @override
  Future<dynamic> getMetadata() {
    return _$getMetadataAsyncAction.run(() => super.getMetadata());
  }

  @override
  String toString() {
    return '''
coverAlbum: ${coverAlbum},
artistName: ${artistName},
musicName: ${musicName}
    ''';
  }
}
