import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/router/routes.dart';

class SavedRoadmapTile extends StatelessWidget {
  const SavedRoadmapTile({super.key, required this.roadmap});
  final RoadmapMetadata roadmap;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final theme = context.theme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: screenWidth * 0.03,
      children: [
        Column(
          spacing: screenHeight * 0.01,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.3,
              child: Text(
                roadmap.title,
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.3,
              child: Text(
                roadmap.description,
                style: textTheme.titleMedium!.copyWith(),
              ),
            ),

            // Row(
            //   spacing: screenHeight * 0.01,
            //   children: [
            //     SizedBox(
            //       width: screenWidth * 0.3,
            //       child: LinearProgressIndicator(
            //         value: roadmap.goalsCount == 0
            //             ? 0
            //             : (roadmap.completedSubgoals / roadmap.subgoalsCount),
            //         backgroundColor: colorScheme.primary.withAlpha(50),
            //         valueColor: AlwaysStoppedAnimation<Color>(
            //           colorScheme.primary,
            //         ),
            //         borderRadius: BorderRadius.circular(20),
            //         minHeight: 8,
            //       ),
            //     ),
            //     Text(
            //       '${(roadmap.completedSubgoals / roadmap.subgoalsCount * 100).toStringAsFixed(2)}%',
            //     ),
            //   ],
            // ),
            Text(
              'Contains ${roadmap.goalsCount} goals',
              style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
            ),
            SizedBox(),
            Row(
              spacing: screenWidth * 0.005,
              children: [
                SizedBox(
                  height: screenHeight * 0.035,
                  child: FilledButton(
                    onPressed: () {
                      context.goNamed(
                        AppRoutes.roadmapView,
                        pathParameters: {'roadmapId': roadmap.id},
                      );
                    },
                    style: theme.filledButtonTheme.style?.copyWith(
                      textStyle: WidgetStatePropertyAll(textTheme.bodyLarge),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                    child: Text(
                      'View',
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (roadmap.postId == null)
                  Consumer(
                    builder: (context, ref, child) {
                      return SizedBox(
                        height: screenHeight * 0.035,
                        child: OutlinedButton(
                          onPressed: () {
                            context.goNamed(
                              AppRoutes.createPost,
                              extra: roadmap,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            textStyle: textTheme.bodyMedium,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: colorScheme.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text('Post'),
                        ),
                      );
                    },
                  )
                // show a posted chip
                else
                  Chip(
                    label: Text(
                      'Posted',
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: colorScheme.primary,
                  ),
              ],
            ),
          ],
        ),

        Container(
          width: screenHeight * 0.1,
          height: screenHeight * 0.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: CircularProgressIndicator(
                  value: roadmap.goalsCount == 0
                      ? 0
                      : (roadmap.completedSubgoals / roadmap.subgoalsCount),
                  backgroundColor: colorScheme.secondaryContainer,
                  color: colorScheme.primary,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              ),
              Text(
                '${(roadmap.completedSubgoals / roadmap.subgoalsCount * 100).toStringAsFixed(2)}%',
              ),
            ],
          ),
        ),
      ],
    );
  }

  double calculateProgress(Roadmap roadmap) {
    final goals = roadmap.goals;
    int subgoals = goals.fold(
      0,
      (combine, element) => combine + element.subgoals.length,
    );
    int completedSubgoals = goals.fold(
      0,
      (combine, element) =>
          combine +
          element.subgoals
              .where((subgoal) => subgoal.status?.completed == true)
              .length,
    );
    if (subgoals == 0) return 0;
    return completedSubgoals / subgoals;
  }
}
