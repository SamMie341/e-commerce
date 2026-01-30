import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TimelineStep {
  final String title;
  final String date;
  final String description;
  final String comment;
  final bool isActive;
  final bool isCancel;
  final bool isBuyer;

  TimelineStep({
    required this.title,
    this.date = '',
    this.description = '',
    this.comment = '',
    required this.isActive,
    this.isCancel = false,
    required this.isBuyer,
  });
}

class OrderTimeline extends StatefulWidget {
  final OrderDetailModel orderDetail;
  const OrderTimeline({Key? key, required this.orderDetail}) : super(key: key);

  @override
  State<OrderTimeline> createState() => _OrderTimelineState();
}

class _OrderTimelineState extends State<OrderTimeline> {
  final List<String> cancelProcesses = ['ສັ່ງຊື້ສຳເລັດ', 'ຍົກເລີກ'];
  final Map<int, bool> _expandedStates = {};

  @override
  Widget build(BuildContext context) {
    List<TimelineStep> steps = _generateStepsFromApi();

    return FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0.5,
          nodeItemOverlap: false,
          color: Colors.grey.shade300,
          indicatorTheme: IndicatorThemeData(size: 15.0),
          connectorTheme: ConnectorThemeData(thickness: 2.0),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: steps.length,
          oppositeContentsBuilder: (context, index) {
            final step = steps[index];
            if (step.isBuyer) {
              return _buildStepCard(index, step, isLeft: true);
            }
            return null;
          },
          contentsBuilder: (context, index) {
            final step = steps[index];
            if (!step.isBuyer) {
              return _buildStepCard(index, step, isLeft: false);
            }
            return null;
          },
          indicatorBuilder: (context, index) {
            final step = steps[index];

            if (step.isActive) {
              if (step.isCancel) {
                return DotIndicator(
                  color: Colors.red,
                  size: 20,
                  child:
                      Icon(Icons.close_rounded, color: Colors.white, size: 12),
                );
              }
              bool isCurrent = index == steps.lastIndexWhere((s) => s.isActive);

              return DotIndicator(
                color: Colors.green,
                size: isCurrent ? 20 : 15,
                child: Icon(Icons.check,
                    color: Colors.white, size: isCurrent ? 12 : 10),
              );
            } else {
              return OutlinedDotIndicator(
                color: Colors.grey,
                borderWidth: 2,
              );
            }
          },
          connectorBuilder: (context, index, type) {
            final step = steps[index];

            if (step.isActive) {
              return SolidLineConnector(
                  color: step.isCancel ? Colors.red : Colors.green);
            } else {
              return DashedLineConnector(
                color: Colors.grey.shade300,
                dash: 5,
                gap: 3,
              );
            }
          },
        ));
  }

  Widget _buildStepCard(int index, TimelineStep step, {required bool isLeft}) {
    final isExpanded = _expandedStates[index] ?? false;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: isLeft ? 8.0 : 12.0,
          right: isLeft ? 12.0 : 8.0,
          bottom: 24.0,
        ),
        child: InkWell(
          onTap: () {
            if (step.isActive) {
              setState(() {
                _expandedStates[index] = !isExpanded;
              });
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment:
                isLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                step.title,
                textAlign: isLeft ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: step.isActive
                      ? (step.isCancel ? Colors.red : Colors.black)
                      : Colors.grey,
                ),
              ),
              if (step.isActive && step.date.isNotEmpty)
                Text(
                  step.date,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              if (step.isActive && step.description.isNotEmpty)
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: isExpanded
                      ? Container(
                          margin: EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Text(
                            step.description,
                            textAlign:
                                isLeft ? TextAlign.right : TextAlign.left,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              if (step.isActive && step.description.isNotEmpty && !isExpanded)
                Icon(Icons.keyboard_arrow_down_rounded,
                    size: 16, color: Colors.grey.withOpacity(0.5)),
              // if (step.isActive == false && isExpanded && step.comment.isEmpty)
              //   Icon(
              //     Icons.keyboard_arrow_up_rounded,
              //     size: 16,
              //     color: Colors.grey.withOpacity(0.5),
              //   )
            ],
          ),
        ),
      ),
    );
  }

  List<TimelineStep> _generateStepsFromApi() {
    final logs = widget.orderDetail.orderStatuses ?? [];

    logs.sort((a, b) {
      DateTime timeA = DateTime.tryParse(a.createdAt ?? '') ?? DateTime(2000);
      DateTime timeB = DateTime.tryParse(b.createdAt ?? '') ?? DateTime(2000);
      return timeA.compareTo(timeB);
    });

    String formatDate(dynamic date) {
      if (date == null) return '';
      if (date is DateTime) {
        return DateFormat('dd/MM/yyyy HH:mm').format(date);
      }
      String dateStr = date.toString();
      if (dateStr.isEmpty) return '';
      try {
        DateTime d = DateTime.parse(dateStr);
        return DateFormat('dd/MM/yyyy HH:mm').format(d);
      } catch (e) {
        return dateStr;
      }
    }

    String buildDetail(OrderStatus? log) {
      if (log == null) return "";
      String info = "";
      if (log.comment != null && log.comment != null) info += "${log.comment}";
      return info.trim();
    }

    bool isBuyerAction(OrderStatus? log) {
      if (log == null || log.user == null) return false;
      return log.user?.code == widget.orderDetail.userCode;
    }

    List<TimelineStep> steps = [];

    for (var log in logs) {
      int id = log.productstatus?.id ?? 0;
      String title = '';
      bool isBuyer = true;
      bool isCancel = false;

      switch (id) {
        case 1:
          title = 'ສັ່ງຊື້ສຳເລັດ';
          isBuyer = true;
          break;
        case 3:
          title = 'ຮັບອໍເດີ້';
          isBuyer = false;
          break;
        case 4:
          title = 'ຊຳລະເງິນສຳເລັດ';
          isBuyer = true;
          break;
        case 5:
          title = 'ກວດສອບການຊຳລະ';
          isBuyer = false;
          break;
        case 6:
          title = 'ສົ່ງສິນຄ້າສຳເລັດ';
          isBuyer = false;
          break;
        case 7:
          title = 'ຮັບສິນຄ້າສຳເລັດ';
          isBuyer = true;
          break;
        case 2:
          isCancel = true;
          bool buyerAction = isBuyerAction(log);
          title = buyerAction ? 'ຍົກເລີກ' : 'ຍົກເລີກ';
          isBuyer = buyerAction;
          break;
      }
      if (title.isNotEmpty) {
        steps.add(TimelineStep(
          title: title,
          date: formatDate(log.createdAt),
          isActive: true,
          isCancel: isCancel,
          isBuyer: isBuyer,
          description: buildDetail(log),
        ));
      }
    }
    int lastId = logs.isNotEmpty ? (logs.last.productstatus?.id ?? 0) : 0;
    if (lastId != 2 && lastId != 7) {
      final standardFlow = [1, 3, 4, 5, 6, 7];
      int currentIndex = standardFlow.indexOf(lastId);
      if (currentIndex != -1 && currentIndex < standardFlow.length - 1) {
        for (int i = currentIndex + 1; i < standardFlow.length; i++) {
          int futureId = standardFlow[i];
          steps.add(_createFutureStep(futureId));
        }
      }
    }
    return steps;
  }

  TimelineStep _createFutureStep(int id) {
    String title = '';
    bool isBuyer = true;
    switch (id) {
      case 3:
        title = 'ລໍຖ້າຮັບອໍເດີ້';
        isBuyer = false;
        break;
      case 4:
        title = 'ລໍຖ້າຊຳລະເງິນ';
        isBuyer = true;
        break;
      case 5:
        title = 'ລໍຖ້າກວດສອບການຊຳລະ';
        isBuyer = false;
        break;
      case 6:
        title = 'ລໍຖ້າສົ່ງສິນຄ້າ';
        isBuyer = false;
        break;
      case 7:
        title = 'ລໍຖ້າຮັບສິນຄ້າ';
        isBuyer = true;
        break;
    }
    return TimelineStep(
      title: title,
      isActive: false,
      isBuyer: isBuyer,
      isCancel: false,
    );
  }
}
