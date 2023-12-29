import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Selected Umpire and Scorer class
class SelectedUmpireScorer extends StatefulWidget {
  const SelectedUmpireScorer({super.key});

  @override
  State<SelectedUmpireScorer> createState() => _SelectedUmpireScorerState();
}

class _SelectedUmpireScorerState extends State<SelectedUmpireScorer> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



// Unselected Umpire and Scorer class
class UnselectedUmpireScorer extends StatefulWidget {
  Function selected;
 UnselectedUmpireScorer({required this.selected,super.key});
  @override
  State<UnselectedUmpireScorer> createState() => _UnselectedUmpireScorerState();
}
class _UnselectedUmpireScorerState extends State<UnselectedUmpireScorer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

      ],
    );
  }
}