import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entity/user_card.dart';
import '../model/user_card_model.dart';

const emptyJson = <String, Object?>{};

typedef Json<T extends Object?> = Map<String, T>;

abstract class MyVisitDataSource {
  Future<List<UserCard>> fetchAllVists({required String userID});
}

class MyVisitDataSourceImpl implements MyVisitDataSource {
  @override
  Future<List<UserCardModel>> fetchAllVists({required String userID}) async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/mock_data/user_profile.json');
      final body = List<Json>.from(jsonDecode(jsonString));
      final userCards = body.map((u) => UserCardModel.fromJson(u)).toList();
      return userCards;
    } catch (e) {
      debugPrint(e.toString());
      return <UserCardModel>[];
    }
  }
}
