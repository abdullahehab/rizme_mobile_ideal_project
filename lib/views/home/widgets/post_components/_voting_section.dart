import 'package:flutter/material.dart';

import '../../../../generated/localization.dart';

class VotingSection extends StatelessWidget {
  final int votes;
  final VoidCallback onUpVotePressed;
  final VoidCallback onDownVotePressed;
  const VotingSection({
    super.key,
    required this.votes,
    required this.onUpVotePressed,
    required this.onDownVotePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.horizontal(
              left: context.isEnglish ? const Radius.circular(25) : Radius.zero,
              right: context.isArabic ? const Radius.circular(25) : Radius.zero,
            ),
            onTap: onUpVotePressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    votes.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 16,
            color: Colors.grey,
          ),
          InkWell(
            borderRadius: BorderRadius.horizontal(
              right: context.isEnglish ? const Radius.circular(25) : Radius.zero,
              left: context.isArabic ? const Radius.circular(25) : Radius.zero,
            ),
            onTap: onDownVotePressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
