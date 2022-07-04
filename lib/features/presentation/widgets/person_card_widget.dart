import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:clean_arch/common/app_colors.dart';
import 'package:clean_arch/features/presentation/pages/person_details.dart';
import 'package:clean_arch/features/presentation/widgets/persons_cached_image_widget.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({Key? key, required this.person}) : super(key: key);

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PersonDetails(personEntity: person)
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.cellBackground,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: PersonsCachedImage(
                imageUrl: person.image ?? '',
                width: 140,
                height: 140,
              )
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(person.name ?? '', style:  const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),),
                   Row(
                     children: [
                       Container(
                         margin: const EdgeInsets.only(right: 10),
                         width: 10,
                         height: 10,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: person.status == 'Alive'
                               ? Colors.green
                               : Colors.red,
                         ),
                       ),
                       Text(
                         '${person.status} - ${person.species}',
                         style:  const TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                       ),
                     ],
                   ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Last known location:', style:  TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: AppColors.greyBackground),),
                    ),
                    Text(
                      '${person.location?.name}',
                      style:  const TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Origin:', style:  TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: AppColors.greyBackground),),
                    ),
                    Text(
                      '${person.origin?.name}',
                      style:  const TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
