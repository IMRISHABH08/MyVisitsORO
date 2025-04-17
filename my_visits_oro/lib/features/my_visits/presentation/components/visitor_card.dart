import 'package:flutter/material.dart';
import 'package:unicards/features/my_visits/domain/entity/user_card.dart';
import 'package:unicards/global/design_system/colors/colors.dart';

import '../../../../global/design_system/sizing/sizing.dart';

class VisitorCard extends StatelessWidget {
  const VisitorCard({super.key, required this.userCard});

  final UserCard userCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Indra.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Visit ID: $visitID",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      )),
                  const SizedBox(height: Sp.px4),
                  Text(visitDate, style: TextStyle(color: Indra.grey.shade600)),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Indra.lightBlue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  visitStatus.title,
                  style: const TextStyle(
                      color: Indra.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: Sp.px12),
          const Divider(height: 1, color: Indra.grey),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, color: Indra.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    userName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, size: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get visitID => userCard.visitID;

  String get userName => userCard.name;

  String get visitDate => userCard.visitDate;

  VisitStatus get visitStatus => userCard.visitStatus;

  VisitType get visitType => userCard.visitType;
}
