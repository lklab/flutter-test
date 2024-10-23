
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

// 값을 저장할 "provider"를 생성합니다(여기서는 "Hello world").
// provider를 사용하면 노출된 값을 모의(mock)//재정의(override)할 수 있습니다.
@riverpod
String helloWorldHaha(Ref ref) {
  return 'Hello world';
}

void main() {
  runApp(
    // 위젯이 providers를 읽을 수 있게 하려면 전체 애플리케이션을 "ProviderScope" 위젯으로 감싸야 합니다.
    // 여기에 providers의 상태가 저장됩니다.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Riverpod에 의해 노출되는 StatelessWidget 대신 ConsumerWidget을 확장합니다.
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldHahaProvider);
    final int count = ref.watch(counterNotifierProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$value, $count'),
              TextButton(
                onPressed: () {
                  ref.watch(counterNotifierProvider.notifier).increment();
                },
                child: const Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state--;
}
