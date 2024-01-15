
import 'package:flutter/material.dart';
import 'package:heart_rate/use_cases/pill_reminder/date_time_formater.dart';
import 'package:heart_rate/use_cases/pill_reminder/pill_model.dart';
import 'package:heart_rate/utils/custom_colors.dart';

class DrugWidget extends StatelessWidget {
  Pill pill;

  DrugWidget(this.pill, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            pill.name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                7,
                (index) => Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:pill.days.contains(index)? CustomColors.primaryColor:Colors.grey,
                      ),
                      child: Text(
                      DateTimeFormatter.  getWeekdayLetter(index),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.alarm),
              Text(
                pill.time!,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
