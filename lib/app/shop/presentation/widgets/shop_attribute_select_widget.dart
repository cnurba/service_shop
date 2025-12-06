import 'package:flutter/material.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';
import 'package:service_shop/app/core/models/property_attribute.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';

class ShopAttributeSelectWidget extends StatefulWidget {
  const ShopAttributeSelectWidget({
    super.key,
    required this.attribute,
    required this.onSelected,
    this.isMainAttribute = false,
  });

  final PropertyAttribute attribute;
  final bool isMainAttribute;
  final Function(Property property) onSelected;

  @override
  State<ShopAttributeSelectWidget> createState() =>
      _ShopAttributeSelectWidgetState();
}

class _ShopAttributeSelectWidgetState extends State<ShopAttributeSelectWidget> {
  String selectedUuid = "";
  bool _autoSelected = false;

  @override
  void initState() {
    for (var prop in widget.attribute.properties) {
      if (prop.selected) {
        selectedUuid = prop.propertyUuid;
        break;
      }
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ShopAttributeSelectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если в новых свойствах есть выбранное — синхронизируем локальный selectedUuid
    String? newSelected;
    for (var prop in widget.attribute.properties) {
      if (prop.selected) {
        newSelected = prop.propertyUuid;
        break;
      }
    }
    if (newSelected != null && newSelected != selectedUuid) {
      // Обновляем без вызова onSelected — это отражение состояния контроллера
      if (mounted) {
        setState(() {
          selectedUuid = newSelected!;
          // если пришёл явный выбор от контроллера — блокируем автоподстановку
          _autoSelected = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final propsList = widget.attribute.properties;
    // deduplicate by propertyUuid to avoid rendering duplicates
    final seen = <String>{};
    final List<Property> uniqueProps = [];
    for (var idx = 0; idx < propsList.length; idx++) {
      final p = propsList[idx];
      final key = (p.propertyUuid.isNotEmpty)
          ? p.propertyUuid
          : '${p.propertyValue}_$idx';
      if (!seen.contains(key)) {
        seen.add(key);
        uniqueProps.add(p);
      }
    }

    // if controller didn't provide selected, pick first and notify after build (only once)
    if (selectedUuid.isEmpty && uniqueProps.isNotEmpty && !_autoSelected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            selectedUuid = uniqueProps.first.propertyUuid;
            _autoSelected = true;
          });
          widget.onSelected(uniqueProps.first);
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text(
          //   widget.attribute.attribute.attributeName,
          //   style: const TextStyle(fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: uniqueProps.map((prop) {
              // Цвета отдельным видом
              if (widget.attribute.attribute.attributeName == "Цвет") {
                List<String> parts = prop.propertyValue.split(',');
                int r = 0, g = 0, b = 0;
                if (parts.length >= 3) {
                  r = int.tryParse(parts[0]) ?? 0;
                  g = int.tryParse(parts[1]) ?? 0;
                  b = int.tryParse(parts[2]) ?? 0;
                }
                return CircleAvatar(
                  radius: 22,
                  backgroundColor: selectedUuid == prop.propertyUuid
                      ? Colors.blue
                      : Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      // DEBUG: лог клика по цвету
                      // ignore: avoid_print
                      print(
                        'ShopAttributeSelectWidget.onTap color: attribute=${widget.attribute.attribute.attributeUuid}, property=${prop.propertyUuid}',
                      );
                      setState(() {
                        selectedUuid = prop.propertyUuid;
                        widget.onSelected.call(prop);
                      });
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color.fromRGBO(r, g, b, 1),
                    ),
                  ),
                );
              }

              // Для главного атрибута показываем карточки (с картинкой или плейсхолдером с текстом)
              if (widget.isMainAttribute && prop.propertyPicture.isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    // DEBUG: лог клика по карточке
                    // ignore: avoid_print
                    print(
                      'ShopAttributeSelectWidget.onTap card: attribute=${widget.attribute.attribute.attributeUuid}, property=${prop.propertyUuid}',
                    );
                    setState(() {
                      selectedUuid = prop.propertyUuid;
                      widget.onSelected.call(prop);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedUuid == prop.propertyUuid
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 70,
                          width: 80,
                          child: prop.propertyPicture.isNotEmpty
                              ? AppImageContainer(
                                  image: prop.propertyPicture,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    prop.propertyValue,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 80,
                          child: Text(
                            prop.propertyValue,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Обычный чип для прочих случаев
              return ChoiceChip(
                label: Text(prop.propertyValue),
                selected: selectedUuid == prop.propertyUuid,
                onSelected: (val) {
                  // DEBUG: лог клика по чипу
                  // ignore: avoid_print
                  print(
                    'ShopAttributeSelectWidget.onSelected chip: attribute=${widget.attribute.attribute.attributeUuid}, property=${prop.propertyUuid}',
                  );
                  setState(() {
                    selectedUuid = prop.propertyUuid;
                    widget.onSelected(prop);
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
