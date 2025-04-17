import 'package:equatable/equatable.dart';

enum VisitStatus {
  notStarted(0),
  inProgress(1),
  completed(2);

  final int key;
  const VisitStatus(this.key);

  factory VisitStatus.fromID(int id) =>
      values.firstWhere((type) => (type.key == id));

  factory VisitStatus.fromTitle(String title) =>
      values.firstWhere((type) => (type.title == title));

  String get title {
    switch (this) {
      case VisitStatus.notStarted:
        return 'Not Started';
      case VisitStatus.inProgress:
        return 'In Progress';
      case VisitStatus.completed:
        return 'Completed';
      default:
        return '';
    }
  }

  bool get isNotStarted => this == VisitStatus.notStarted;
  bool get isInProgress => this == VisitStatus.inProgress;
  bool get isCompleted => this == VisitStatus.completed;
}

enum VisitType {
  loan(0),
  dc(1),
  goldStorage(2),
  all(3);

  final int key;

  const VisitType(this.key);

  factory VisitType.fromID(int id) =>
      values.firstWhere((type) => (type.key == id));

  factory VisitType.fromTitle(String title) =>
      values.firstWhere((type) => (type.title == title));

  String get title {
    switch (this) {
      case VisitType.dc:
        return 'DC';
      case VisitType.loan:
        return 'Loan';
      case VisitType.goldStorage:
        return 'Gold Storage';
      case VisitType.all:
        return 'All';
      default:
        return '';
    }
  }

  bool get isDC => this == VisitType.dc;
  bool get isLoan => this == VisitType.loan;
  bool get isGoldStorage => this == VisitType.goldStorage;
}

class UserCard extends Equatable {
  const UserCard({
    required this.name,
    required this.userID,
    required this.visitID,
    required this.visitType,
    required this.visitDate,
    required this.visitStatus,
  });

  final String name;
  final String userID;
  final String visitDate;
  final String visitID;
  final VisitType visitType;
  final VisitStatus visitStatus;

  @override
  List<Object?> get props => [userID];
}
