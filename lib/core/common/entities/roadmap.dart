import 'goal.dart';

class Roadmap {
  final String userId;
  final String title;
  final List<Goal> goals;
  final String id;

  const Roadmap({
    required this.userId,
    required this.title,
    required this.goals,
    required this.id,
  });
}
