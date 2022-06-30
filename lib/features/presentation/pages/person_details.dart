import 'package:clean_arch/common/app_colors.dart';
import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:clean_arch/features/presentation/widgets/persons_cached_image_widget.dart';
import 'package:flutter/material.dart';

class PersonDetails extends StatelessWidget {
  const PersonDetails({Key? key, required this.personEntity}) : super(key: key);
  final PersonEntity personEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, bottom: 6),
                child: Text(personEntity.name!, style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w700),)),
            Container(
              padding: const EdgeInsets.all(8),
              child: PersonsCachedImage(
                  width: 240,
                  height: 240,
                  imageUrl: personEntity.image ?? '',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: personEntity.status == 'Alive'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                Text(
                  '${personEntity.status} - ${personEntity.species}',
                  style:  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            ..._getWidgetMap(key: 'Gender:', value: personEntity.gender ?? ''),
            ..._getWidgetMap(key: 'Number of episodes:', value: '${personEntity.episode?.length ?? 0}'),
            ..._getWidgetMap(key: 'Species:', value: personEntity.species ?? ''),
            ..._getWidgetMap(key: 'Last known location:', value: personEntity.location?.name ?? ''),
            ..._getWidgetMap(key: 'Origin:', value: personEntity.origin?.name ?? ''),
            ..._getWidgetMap(key: 'Was created:', value: personEntity.created?.toString() ?? 'never'),
          ],
        ),
      )
    );
  }
}

List<Widget> _getWidgetMap({required String key, required String value}){
  return [Container(
    margin: const EdgeInsets.only(top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          key,
          style:  const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: AppColors.greyBackground),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          value,
          style:  const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  )];
}