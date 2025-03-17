import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sop/app/module/sop/controller/sop_controller.dart';
import 'package:sop/app/utils/constants.dart';
import 'package:sop/app/widget/custom_height_width.dart';
import 'package:sop/app/widget/custom_page_number.dart';
import 'package:sop/app/widget/custom_sop_display.dart';
import 'package:sop/app/widget/custom_stopwatch.dart';

class SopScreen extends StatefulWidget {
  const SopScreen({super.key});

  @override
  State<SopScreen> createState() => _SopScreenState();
}

class _SopScreenState extends State<SopScreen> {
  final SopController _controller = SopController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
        leading: Row(
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () {}),
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
          ],
        ),
        leadingWidth: 100,
      ),
      body: ListView(
        children: [
          SafeArea(
            minimum: const EdgeInsets.all(25),
            child: FutureBuilder(
              future: _controller.init(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? Column(
                      children: [
                        StreamBuilder<Duration>(
                          stream: _controller.stopwatchStream,
                          builder: (context, elapsedTimeSnapshot) {
                            return CustomStopwatch(
                              elapsedTime:
                                  elapsedTimeSnapshot.data ?? const Duration(),
                            );
                          },
                        ),
                        customHeight(),
                        StreamBuilder<ButtonState>(
                          stream: _controller.stopwatchButtonStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              style:
                                  snapshot.data == ButtonState.pause
                                      ? ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.black,
                                      )
                                      : snapshot.data == ButtonState.start ||
                                          snapshot.data == ButtonState.resume
                                      ? ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.black,
                                      )
                                      : null,
                              onPressed:
                                  snapshot.data == ButtonState.start ||
                                          snapshot.data == ButtonState.resume
                                      ? () {
                                        startTask();
                                      }
                                      : snapshot.data == ButtonState.pause
                                      ? () {
                                        _controller.stopStopwatch(false, false);
                                      }
                                      : null,
                              child: Padding(
                                padding: const EdgeInsets.all(25),
                                child: Text(
                                  snapshot.data == ButtonState.start ||
                                          snapshot.data == ButtonState.stop
                                      ? 'START TASK'
                                      : snapshot.data == ButtonState.resume
                                      ? 'RESUME TASK'
                                      : snapshot.data == ButtonState.pause
                                      ? 'PAUSE TASK'
                                      : 'TASK IS DONE',
                                  style: const TextStyle(fontSize: 50),
                                ),
                              ),
                            );
                          },
                        ),
                        customHeight(),
                        StreamBuilder<int>(
                          stream: _controller.lastSopStream,
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                Wrap(
                                  spacing: 8,
                                  children:
                                      [1, 2, 3]
                                          .map(
                                            (sop) => SizedBox(
                                              height: 90,
                                              width: 230,
                                              child: CustomSopDisplay(
                                                completedStep:
                                                    sop < (snapshot.data ?? 0),
                                                title: 'SOP $sop',
                                                content: '(description)',
                                              ),
                                            ),
                                          )
                                          .toList(),
                                ),
                                customHeight(height: 5),
                                Wrap(
                                  spacing: 8,
                                  children:
                                      [4, 5, 6]
                                          .map(
                                            (sop) => SizedBox(
                                              height: 90,
                                              width: 230,
                                              child: CustomSopDisplay(
                                                completedStep:
                                                    sop < (snapshot.data ?? 0),
                                                title: 'SOP $sop',
                                                content: '(description)',
                                              ),
                                            ),
                                          )
                                          .toList(),
                                ),
                              ],
                            );
                          },
                        ),
                        customHeight(),
                        StreamBuilder<List>(
                          stream: _controller.itemIndicatorStream,
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                snapshot.data?.length ?? 1,
                                (index) {
                                  return CustomPageNumber(
                                    pageNumber:
                                        snapshot.data?[index]['value'] ?? '',
                                    isSelected:
                                        snapshot.data?[index]['selected'] ??
                                        true,
                                    isCompleted:
                                        snapshot.data?[index]['completed'] ??
                                        false,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        customHeight(),
                        StreamBuilder<bool>(
                          stream: _controller.nextItemButtonStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed:
                                  snapshot.data ?? true
                                      ? () {
                                        _controller.nextItem();
                                      }
                                      : null,
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'NEXT TASK',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                    : const Center(
                      child: SpinKitCircle(size: 50, color: primaryColor),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  void startTask() {
    _controller.startStopwatch();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StreamBuilder<int>(
          stream: _controller.lastSopStream,
          builder: (context, snapshot) {
            Widget content = Container();
            switch (snapshot.data) {
              case 1:
                content = Text(
                  '(description)',
                  style: const TextStyle(fontSize: 25),
                );
                break;
              case 2:
                content = Text(
                  '(description)',
                  style: const TextStyle(fontSize: 25),
                );
                break;
              case 3:
                content = Text(
                  '(description)',
                  style: const TextStyle(fontSize: 25),
                );
                break;
              case 4:
                content = Text(
                  '(description)',
                  style: const TextStyle(fontSize: 25),
                );
                break;
              case 5:
                content = Text(
                  '(description)',
                  style: const TextStyle(fontSize: 25),
                );
                break;
              case 6:
                content = Text(
                  '(description)',
                  style: const TextStyle(fontSize: 25),
                );
                break;
              default:
                break;
            }
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SOP ${snapshot.data}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _controller.stopStopwatch(false, false);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              content: SizedBox(height: 100, width: 300, child: content),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    _controller.nextSop().then((completeTask) {
                      if (completeTask) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(25),
                    child: Text('NEXT', style: TextStyle(fontSize: 25)),
                  ),
                ),
              ],
              actionsPadding: const EdgeInsets.all(25),
              actionsAlignment: MainAxisAlignment.end,
            );
          },
        );
      },
    );
  }
}
