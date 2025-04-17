import 'package:unicards/features/my_visits/domain/entity/user_card.dart';

import '../data_source/my_visit_data_source.dart';

class UserCardModel extends UserCard {
  const UserCardModel({
    required super.name,
    required super.userID,
    required super.visitID,
    required super.visitType,
    required super.visitDate,
    required super.visitStatus,
  });

  factory UserCardModel.fromJson(Json json) => UserCardModel(
        name: json['name'] as String,
        userID: json['userID'] as String,
        visitID: json['visitID'] as String,
        visitDate: json['visitDate'] as String,
        visitStatus:
            VisitStatus.fromID(int.tryParse('${json['visitType']}') ?? 0),
        visitType: VisitType.fromID(int.tryParse('${json['visitType']}') ?? 0),
      );
}
